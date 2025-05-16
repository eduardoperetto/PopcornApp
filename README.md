# PopcornApp

A SwiftUI-based movie discovery app that lets you search, filter, and save movies for later. Built for study purposes and evolving with new features and frameworks over time.

---

## 🚀 Features

* **Search & Filter**
  Quickly find movies by title, genre, release date, rating, and more.
* **Watch Later & Like**
  Save your favorite movies or add them to a “watch later” list.

---

## 🏗 Architecture & Patterns

* **Clean Architecture**

  * **Domain**: Entities, Use Cases
  * **Data**: Repositories, Network & Persistence Adapters
  * **Presentation**: ViewModels, Views
* **Coordinator Pattern**
  Centralized navigation using a generic `Coordinator`:

  ```swift
  // Instantiate your coordinator with a custom route enum
  let coordinator: Coordinator<MyCustomRoute>

  // Navigate to a route
  coordinator.navigate(to: .detail(id: movie.id))
  ```

---

## 🛠️ Tech Stack

* **UI**: SwiftUI
* **Async**: Combine
* **Storage**: Core Data
* **Networking**: URLSession + Codable

---

## 📦 Installation

1. Clone the repo:

   ```bash
   git clone https://github.com/your-username/PopcornApp.git
   cd PopcornApp
   ```
2. Open `Popcorn.xcodeproj`
3. Create your configuration file (see **Configuration**)

---

## ⚙️ Configuration

Create an `Environment.xcconfig` file inside the `Popcorn/` folder with these keys:

```ini
API_KEY=your_tmdb_api_key
BASE_URL=https:/$()/api.themoviedb.org
IMAGE_BASE_URL=https:/$()/image.tmdb.org
```

* **API\_KEY**: Your TMDB API key
* **BASE\_URL**: `https://api.themoviedb.org`
* **IMAGE\_BASE\_URL**: `https://image.tmdb.org`

Refer to [TMDB API Docs](https://developer.themoviedb.org/docs).

---

## ✅ Testing

PopcornApp includes:

* **Unit Tests** using XCTest for view models and use case logic.
* **Snapshot Tests** using [SnapshotTesting](https://github.com/pointfreeco/swift-snapshot-testing) to verify SwiftUI views.

Tests cover core business logic, state-driven UI behavior, and visual regressions.

---

## 🤝 Contributing

1. Fork the repo
2. Create a feature branch (`git checkout -b feature/XYZ`)
3. Commit your changes (`git commit -m "Add XYZ"`)
4. Push to your branch (`git push origin feature/XYZ`)
5. Open a Pull Request

---
