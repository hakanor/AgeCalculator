//
//  Colors.swift
//  AgeCalculator
//
//  Created by Hakan Or on 30.01.2024.
//

import SwiftUI

class ThemeColors: ObservableObject {
    
    static let shared = ThemeColors()
    
    @Published var backgroundColor: Color = Color("backgroundColor")
    var labelColor : Color = Color("labelColor")
    var strokeColor : Color = Color("strokeColor")
    
    let success = Color(hexString: "#65B741")
    let error = Color(hexString: "#EC6B6C")
    
    init() {
        load()
    }
    
    // functions that save & load colorSettings to UserDefaults
    func save(color: Color) {
        let uiColor = UIColor(color)
        let colorData = try? NSKeyedArchiver.archivedData(withRootObject: uiColor, requiringSecureCoding: false)
        UserDefaults.standard.set(colorData, forKey: "backgroundColor")
        backgroundColor = color
    }
    
    func load() {
        if let storedColorData = UserDefaults.standard.data(forKey: "backgroundColor") {
            if let uiColor = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(storedColorData) as? UIColor {
                backgroundColor = Color(uiColor)
            }
        }
    }
    
    func resetColors() {
        UserDefaults.standard.removeObject(forKey: "backgroundColor")
        backgroundColor = Color("backgroundColor")
    }
}
