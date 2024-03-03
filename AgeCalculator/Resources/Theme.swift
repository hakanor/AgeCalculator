//
//  Theme.swift
//  AgeCalculator
//
//  Created by Hakan Or on 4.03.2024.
//

import Foundation
import SwiftUI

enum Theme: String, CaseIterable {
    case systemDefault = "Default"
    case light = "Light"
    case dark = "Dark"
    
    var colorScheme: ColorScheme {
        switch self {
        case .systemDefault:
            return .light
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
}
