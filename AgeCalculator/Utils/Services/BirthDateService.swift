//
//  BirthDateService.swift
//  AgeCalculator
//
//  Created by Hakan Or on 8.02.2024.
//

import Foundation

struct BirthDateObject: Codable, Hashable {
    var date: Date = Date()
    let birthDate: Date
    let name: String
}

class BirthDateService: ObservableObject {
    static let shared = BirthDateService()
    
    var birthDateCount = 3
    private let userDefaults = UserDefaults.standard
    
    @Published var birthDates: [BirthDateObject] = []
    @Published var selectedBirthDate: BirthDateObject?
    
    private init() {
        self.birthDates = getBirthDates()
        self.selectedBirthDate = getSelectedBirthDate()
    }
    
    func setSelectedBirthDate(_ birthDate: BirthDateObject) {
        let dataOfBirthDate = objectToData(object: birthDate)
        userDefaults.setValue(dataOfBirthDate, forKey: "selectedBirthDate")
        self.selectedBirthDate = birthDate
    }
    
    func getSelectedBirthDate() -> BirthDateObject? {
        guard let dataOfBirthDateObject = userDefaults.object(forKey: "selectedBirthDate") as? Data else { return nil }
        return dataToObject(data: dataOfBirthDateObject) as BirthDateObject? ?? nil
    }
    
    func removeSelectedBirthDate() {
        userDefaults.removeObject(forKey: "selectedBirthDate")
        self.selectedBirthDate = nil
    }
    
    func removeFromBirthDates(_ birthDate: BirthDateObject) {
        var updatedBirthDates = getBirthDates()
        
        if let index = updatedBirthDates.firstIndex(of: birthDate) {
            updatedBirthDates.remove(at: index)
            
            let birthDateObjectsData = birthDateObjectToData(birthDateObjects: updatedBirthDates)
            userDefaults.setValue(birthDateObjectsData, forKey: "birthDates")
            
            self.birthDates = getBirthDates()
        }
    }
    
    func appendToBirthDateArray(_ birthDate: BirthDateObject) {
        let newBirthDate = birthDate
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
        return dataToBirthDateObject(data: birthDateData)?.sorted(by: {$0.date < $1.date}) ?? []
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
    
    func objectToData<T: Encodable>(object: T) -> Data? {
        do {
            let encoder = JSONEncoder()
            return try encoder.encode(object)
        } catch {
            print("Error encoding object: \(error.localizedDescription)")
            return nil
        }
    }
    
    func dataToObject<T: Decodable>(data: Data) -> T? {
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            print("Error decoding data to object: \(error.localizedDescription)")
            return nil
        }
    }
}
