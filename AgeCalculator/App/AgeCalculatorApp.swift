//
//  AgeCalculatorApp.swift
//  AgeCalculator
//
//  Created by Hakan Or on 21.01.2024.
//

import SwiftUI

@main
struct AgeCalculatorApp: App {
    @AppStorage("userTheme") private var userTheme: Theme = .systemDefault
    @State var languageSettings = LanguageSettings()
    @StateObject var storeKitManager = StoreKitManager.shared
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .preferredColorScheme(userTheme.colorScheme)
                .environment(languageSettings)
                .environmentObject(ThemeColors.shared)
                .environmentObject(storeKitManager)
                .environment(\.locale, languageSettings.locale)
        }
    }
}
