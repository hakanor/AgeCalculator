//
//  BirthDateService.swift
//  AgeCalculator
//
//  Created by Hakan Or on 8.02.2024.
//

import Foundation

class BirthDateService: ObservableObject {
    static let shared = BirthDateService()
    
    private let userDefaults = UserDefaults.standard
    
    @Published var birthDates: [Date] = []
    @Published var selectedBirthDate: Date?
    
    private init() {
        self.birthDates = getBirthDates()
        self.selectedBirthDate = getSelectedBirthDate()
    }
    
    func setSelectedBirthDate(_ birthDate: Date) {
        userDefaults.removeObject(forKey: "selectedBirthDate")
        userDefaults.set(birthDate, forKey: "selectedBirthDate")
        self.selectedBirthDate = birthDate
    }
    
    func getSelectedBirthDate() -> Date {
        let object = userDefaults.object(forKey: "selectedBirthDate") as? Date ?? Date()
        return object
    }
    
    func appendToBirthDateArray(_ birthDate: Date) {
        var birthDates = getBirthDates()
        birthDates.append(birthDate)
        
        userDefaults.removeObject(forKey: "birthDates")
        userDefaults.setValue(birthDates, forKey: "birthDates")
        self.birthDates = getBirthDates()
    }
    
    func getBirthDates() -> [Date] {
        return userDefaults.object(forKey: "birthDates") as? [Date] ?? []
    }
}
