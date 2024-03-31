//
//  BottomSheetViewModel.swift
//  AgeCalculator
//
//  Created by Hakan Or on 17.02.2024.
//

import Foundation
import SwiftUI

class BottomSheetViewModel: ObservableObject {
    
    private var birthDateService = BirthDateService.shared
    
    init() {
    }
    
    func calculateRemainingBirthDates() -> Int {
        return birthDateService.birthDateCount - birthDateService.getBirthDatesCount()
    }
    
    func removeBirthDate(date: BirthDateObject) {
        // remove from birtHdate array
        birthDateService.removeFromBirthDates(date)
        // remove from selectedBirthDate if it is selected.
        if date.birthDate == birthDateService.selectedBirthDate?.birthDate {
            birthDateService.removeSelectedBirthDate()
        }
    }
    
    func setSelectedBirthDate(birthDateObject: BirthDateObject) {
        birthDateService.setSelectedBirthDate(birthDateObject)
    }
    
    func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.string(from: date)
    }
}
