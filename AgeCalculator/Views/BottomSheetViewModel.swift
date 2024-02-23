//
//  BottomSheetViewModel.swift
//  AgeCalculator
//
//  Created by Hakan Or on 17.02.2024.
//

import Foundation
import SwiftUI

class BottomSheetViewModel: ObservableObject {
    @Published var birthDates: [BirthDateObject] = []
    
    init() {
        loadBirthDates()
    }
    
    func loadBirthDates() {
        self.birthDates = BirthDateService.shared.birthDates
    }
}
