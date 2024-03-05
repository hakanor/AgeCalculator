//
//  SupportedLanguages.swift
//  AgeCalculator
//
//  Created by Hakan Or on 5.03.2024.
//

import Foundation

enum SupportedLanguage: String, CaseIterable {
    case english = "en"
    case turkish = "tr"
    
    var description: String {
        switch self {
        case .english:
            return "English"
        case .turkish:
            return "Turkish"
        }
    }
}
