//
//  SupportedLanguages.swift
//  AgeCalculator
//
//  Created by Hakan Or on 5.03.2024.
//

import Foundation

enum SupportedLanguage: String, CaseIterable {
    case english = "en"
    case german = "de"
    case turkish = "tr"
    case spanish = "es"
    
    var description: String {
        switch self {
        case .english:
            return "English"
        case .turkish:
            return "Turkish"
        case .spanish:
            return "Spanish"
        case .german:
            return "German"
        }
    }
}
