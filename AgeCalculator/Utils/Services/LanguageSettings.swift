//
//  LanguageSettings.swift
//  AgeCalculator
//
//  Created by Hakan Or on 5.03.2024.
//

import Foundation

@Observable
class LanguageSettings {
    
    enum LanguageConstants: String {
        case languageKey = "language-key"
    }
    
    var locale: Locale = .current {
        didSet {}
    }
    
    init() {
        setupInitialLocale()
    }
    
    private func setupInitialLocale() {
        if let language = UserDefaults.standard.string(forKey: LanguageConstants.languageKey.rawValue), let value = SupportedLanguage(rawValue: language) {
            setLocale(language: value)
        } else {
            setLocale(language: .english)
        }
    }
    
    func setLocale(language: SupportedLanguage) {
        switch language {
        case .english:
            locale = Locale(identifier: SupportedLanguage.english.rawValue)
            UserDefaults.standard.set(SupportedLanguage.english.rawValue, forKey: LanguageConstants.languageKey.rawValue)
        case .turkish:
            locale = Locale(identifier: SupportedLanguage.turkish.rawValue)
            UserDefaults.standard.set(SupportedLanguage.turkish.rawValue, forKey: LanguageConstants.languageKey.rawValue)
        case .spanish:
            locale = Locale(identifier: SupportedLanguage.spanish.rawValue)
            UserDefaults.standard.set(SupportedLanguage.spanish.rawValue, forKey: LanguageConstants.languageKey.rawValue)
        case .german:
            locale = Locale(identifier: SupportedLanguage.german.rawValue)
            UserDefaults.standard.set(SupportedLanguage.german.rawValue, forKey: LanguageConstants.languageKey.rawValue)
        }
        UserDefaults.standard.synchronize()
    }
}
