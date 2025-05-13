//
//  DateSelectionView.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 13/05/25.
//

import SwiftUI

struct DateSelectionView: View {
    @Binding var startDate: Date
    @Binding var endDate: Date

    var body: some View {
        VStack {
            DatePicker("From:", selection: $startDate, displayedComponents: .date)
            DatePicker("To:", selection: $endDate, displayedComponents: .date)
        }
    }
}
