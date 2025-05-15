//
//  CoreDataMovieLocalDataSource.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 11/05/25.
//

import Combine
import CoreData
import Foundation

public final class CoreDataMovieLocalDataSource: MovieLocalDataSource {
    private let container: NSPersistentContainer
    private let logger: LoggerProtocol
    private var context: NSManagedObjectContext { container.viewContext }
    private let logTag = "CoreDataMovieLocalDataSource"

    public init(
        logger: LoggerProtocol,
        container: NSPersistentContainer = CoreDataMovieLocalDataSource.makeContainer()
    ) {
        self.logger = logger
        self.container = container
        logger.d("Initializing Core Data stack.", tag: logTag)
        container.loadPersistentStores { _, error in
            if let error = error {
                logger.e("Failed to load persistent stores: \(error)", tag: "CoreDataMovieLocalDataSource")
                fatalError("Unresolved Core Data error: \(error)")
            } else {
                logger.d("Persistent stores loaded successfully.", tag: "CoreDataMovieLocalDataSource")
            }
        }
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }

    // MARK: Likes

    public func fetchLikedMovies() -> AnyPublisher<[Movie], Error> {
        logger.d("Fetching liked movies.", tag: logTag)
        return fetchMovies(predicate: NSPredicate(format: "isLiked == YES"))
    }

    public func storeLikedMovie(_ movie: Movie) -> AnyPublisher<Void, Error> {
        logger.d("Storing liked movie with ID: \(movie.id).", tag: logTag)
        return update(movie: movie, liked: true)
    }

    public func removeLikedMovie(_ movie: Movie) -> AnyPublisher<Void, Error> {
        logger.d("Removing liked movie with ID: \(movie.id).", tag: logTag)
        return update(movie: movie, liked: false)
    }

    public func isMovieLiked(movieId: Int) -> AnyPublisher<Bool, Error> {
        logger.d("Checking if movie is liked. ID: \(movieId).", tag: logTag)
        return checkFlag(for: movieId, key: "isLiked")
    }

    // MARK: Watch Later

    public func fetchWatchLaterMovies() -> AnyPublisher<[Movie], Error> {
        logger.d("Fetching watch-later movies.", tag: logTag)
        return fetchMovies(predicate: NSPredicate(format: "isSavedToWatchLater == YES"))
    }

    public func storeWatchLaterMovie(_ movie: Movie) -> AnyPublisher<Void, Error> {
        logger.d("Storing movie to watch later with ID: \(movie.id).", tag: logTag)
        return update(movie: movie, watchLater: true)
    }

    public func removeWatchLaterMovie(_ movie: Movie) -> AnyPublisher<Void, Error> {
        logger.d("Removing movie from watch later with ID: \(movie.id).", tag: logTag)
        return update(movie: movie, watchLater: false)
    }

    public func isMovieSetToWatchLater(movieId: Int) -> AnyPublisher<Bool, Error> {
        logger.d("Checking if movie is set to watch later. ID: \(movieId).", tag: logTag)
        return checkFlag(for: movieId, key: "isSavedToWatchLater")
    }

    // MARK: Private Helpers

    private func fetchMovies(predicate: NSPredicate) -> AnyPublisher<[Movie], Error> {
        Deferred {
            Future { [weak self] promise in
                guard let self = self else {
                    self?.logger.w("Self is nil in fetchMovies.", tag: self?.logTag ?? "Unknown")
                    return
                }
                self.context.perform {
                    let request: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
                    request.predicate = predicate
                    do {
                        let entities = try self.context.fetch(request)
                        self.logger.d("Fetched \(entities.count) movies matching predicate.", tag: self.logTag)
                        promise(.success(entities.map { $0.toModel() }))
                    } catch {
                        self.logger.e("Failed to fetch movies: \(error)", tag: self.logTag)
                        promise(.failure(error))
                    }
                }
            }
        }
        .eraseToAnyPublisher()
    }

    private func update(movie: Movie, liked: Bool? = nil, watchLater: Bool? = nil) -> AnyPublisher<Void, Error> {
        Deferred {
            Future { [weak self] promise in
                guard let self = self else {
                    self?.logger.w("Self is nil in update.", tag: self?.logTag ?? "Unknown")
                    return
                }
                self.context.perform {
                    let entity = self.fetchEntity(id: movie.id) ?? MovieEntity(context: self.context)
                    let isNew = entity.managedObjectContext == nil
                    entity.id = Int64(movie.id)
                    entity.title = movie.title
                    entity.overview = movie.overview
                    entity.posterPath = movie.posterPath
                    entity.voteAverage = movie.voteAverage
                    if let liked { entity.isLiked = liked }
                    if let watchLater { entity.isSavedToWatchLater = watchLater }
                    do {
                        try self.context.save()
                        let action = isNew ? "Created" : "Updated"
                        self.logger.d("\(action) movie entity with ID: \(movie.id).", tag: self.logTag)
                        promise(.success(()))
                    } catch {
                        self.logger.e("Failed to save movie entity: \(error)", tag: self.logTag)
                        promise(.failure(error))
                    }
                }
            }
        }
        .eraseToAnyPublisher()
    }

    private func checkFlag(for id: Int, key: String) -> AnyPublisher<Bool, Error> {
        Deferred {
            Future { [weak self] promise in
                guard let self = self else {
                    self?.logger.w("Self is nil in checkFlag.", tag: self?.logTag ?? "Unknown")
                    promise(.failure(NSError(domain: "Core data is nil", code: -1)))
                    return
                }
                self.context.perform {
                    self.logger.d("Fetching MovieEntity", tag: self.logTag)
                    let request: NSFetchRequest<NSFetchRequestResult> = MovieEntity.fetchRequest()
                    request.predicate = NSPredicate(format: "id == %d", id)
                    request.resultType = .dictionaryResultType
                    request.propertiesToFetch = [key]
                    do {
                        self.logger.d("Fetching request: \(request)", tag: self.logTag)
                        if let result = try self.context.fetch(request).first as? [String: Any],
                           let value = result[key] as? Bool
                        {
                            self.logger.d("Flag '\(key)' for movie ID \(id): \(value).", tag: self.logTag)
                            promise(.success(value))
                        } else {
                            self.logger.d("Flag '\(key)' for movie ID \(id) not found. Returning false.", tag: self.logTag)
                            promise(.success(false))
                        }
                    } catch {
                        self.logger.e("Failed to check flag '\(key)' for movie ID \(id): \(error)", tag: self.logTag)
                        promise(.failure(error))
                    }
                }
            }
        }
        .eraseToAnyPublisher()
    }

    private func fetchEntity(id: Int) -> MovieEntity? {
        let request: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)
        request.fetchLimit = 1
        let entity = try? context.fetch(request).first
        if entity == nil {
            logger.d("No existing entity found for movie ID: \(id).", tag: logTag)
        }
        return entity
    }

    public static func makeContainer() -> NSPersistentContainer {
        let container = NSPersistentContainer(name: "PopcornMovies")
        return container
    }
}
