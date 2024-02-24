//
//  AddDateViewModel.swift
//  AgeCalculator
//
//  Created by Hakan Or on 24.02.2024.
//

import Foundation

final class AddDateViewModel: ObservableObject {
    
    private var birthDateService: BirthDateService
    
    init(birthDateService: BirthDateService = BirthDateService.shared) {
        self.birthDateService = birthDateService
    }
    
    func addBirthDate(name: String, selectedDate: Date) {
        let birthDateObject = BirthDateObject(birthDate: selectedDate, name: name)
        birthDateService.setSelectedBirthDate(birthDateObject)
        birthDateService.appendToBirthDateArray(birthDateObject)
    }
}
