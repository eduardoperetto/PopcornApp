//
//  Double+Currency.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 10/05/25.
//

import Foundation

extension Double {
    var formattedCurrency: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 0
        formatter.currencySymbol = "$"
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}
