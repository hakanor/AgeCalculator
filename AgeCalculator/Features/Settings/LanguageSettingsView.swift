//
//  LanguageSettingsView.swift
//  AgeCalculator
//
//  Created by Hakan Or on 5.03.2024.
//

import SwiftUI

struct LanguageSettingsView: View {
    
    @Environment(LanguageSettings.self) var languageSettings
    @State private var selectedLanguage = SupportedLanguage.english
    @Binding var showingLanguageSettingsSheet: Bool
    
    var body: some View {
        VStack {
            Picker(selection: $selectedLanguage, label: Text("Select Language")) {
                ForEach(SupportedLanguage.allCases, id: \.self) { language in
                    Text(language.description.capitalized)
                        .tag(language)
                }
            }
            .pickerStyle(.wheel)
            Button(action: {
                languageSettings.setLocale(language: selectedLanguage)
                showingLanguageSettingsSheet = false
            }, label: {
                RetroView(type: .text("apply_string"), size: 15)
                    .fixedSize(horizontal: true, vertical: true)
            })
            .buttonStyle(RetroButtonStyle())
        }
    }
}
