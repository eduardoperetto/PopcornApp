//
//  String+Date.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 10/05/25.
//

import Foundation

extension String {
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let date = formatter.date(from: self) else { return self }
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

extension String {
    func toDate() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.date(from: self) ?? Date()
    }
}

extension Date {
    func toString() -> String {
        let formatter = DateFormatter()
        return formatter.string(from: self)
    }
}
