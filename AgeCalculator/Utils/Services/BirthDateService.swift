//
//  BirthDateService.swift
//  AgeCalculator
//
//  Created by Hakan Or on 8.02.2024.
//

import Foundation

struct BirthDateObject: Codable {
    var date: Date = Date()
    let birthDate: Date
}

class BirthDateService: ObservableObject {
    static let shared = BirthDateService()
    
    private var birthDateCount = 3
    private let userDefaults = UserDefaults.standard
    
    @Published var birthDates: [BirthDateObject] = []
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
        let newBirthDate = BirthDateObject(birthDate: birthDate)
        var birthDates = getBirthDates()
        
        
        birthDates = birthDates.sorted(by: { $0.date > $1.date })
        let filteredBirthDateObjects = Array(birthDates.prefix(self.birthDateCount))
        
        if birthDates.count >= self.birthDateCount {
            birthDates.removeLast()
        }
        birthDates.append(newBirthDate)
        
        let birthDateObjectsData = birthDateObjectToData(birthDateObjects: birthDates)
        
        userDefaults.removeObject(forKey: "birthDates")
        userDefaults.setValue(birthDateObjectsData, forKey: "birthDates")
        self.birthDates = getBirthDates()
    }
    
    func getBirthDates() -> [BirthDateObject] {
        guard let birthDateData = userDefaults.object(forKey: "birthDates") as? Data else { return [] }
        return dataToBirthDateObject(data: birthDateData)?.sorted(by: {$0.date > $1.date}) ?? []
    }
    
    func birthDateObjectToData(birthDateObjects: [BirthDateObject]) -> Data? {
        do {
            let encoder = JSONEncoder()
            return try encoder.encode(birthDateObjects)
        } catch {
            print("Error encoding birthDateObject: \(error.localizedDescription)")
            return nil
        }
    }
    
    func dataToBirthDateObject(data: Data) -> [BirthDateObject]? {
        do {
            let decoder = JSONDecoder()
            return try decoder.decode([BirthDateObject].self, from: data)
        } catch {
            print("Error decoding data to BirthDateObject: \(error.localizedDescription)")
            return nil
        }
    }
}
