//
//  SettingsView.swift
//  AgeCalculator
//
//  Created by Hakan Or on 2.03.2024.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.colorScheme) private var scheme
    @AppStorage("userTheme") private var userTheme: Theme = .systemDefault
    
    @State private var isDarkModeEnabled: Bool = false
    
    @State var showingLanguageSettingsSheet = false
    @State var showingColorSettingsSheet = false
    
    init() {
        _isDarkModeEnabled = State(initialValue: userTheme == .dark)
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 30) {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("generalSettings_string")
                            .font(.headline)
                        Button(action: {
                            showingLanguageSettingsSheet.toggle()
                        }, label: {
                            RetroView(type: .settings("changeLanguage_string"), size: 15)
                                .fixedSize(horizontal: false, vertical: true)
                        })
                        .buttonStyle(RetroButtonStyle())
                        
                        NavigationLink {
                            PurchaseView()
                        } label: {
                            RetroView(type: .settings("buyPremium_string"), size: 15)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        .buttonStyle(RetroButtonStyle())
                        
                    }
                    VStack(alignment: .leading, spacing: 15) {
                        Text("premiumSettings_string")
                            .font(.headline)
                        
                        Button(action: {
                            showingColorSettingsSheet.toggle()
                        }, label: {
                            RetroView(type: .settings("changeColor_string"), size: 15)
                                .fixedSize(horizontal: false, vertical: true)
                        })
                        .buttonStyle(RetroButtonStyle())
                        
                        RetroView(type: .toggle($isDarkModeEnabled, "toggleDarkMode_string"), size: 15)
                            .onChange(of: isDarkModeEnabled) { newValue in
                                userTheme = newValue ? .dark : .light
                                if let window = UIApplication.shared.keyWindow {
                                    UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
                                        window.overrideUserInterfaceStyle = newValue ? .dark : .light
                                    }, completion: nil)
                                }
                            }
                    }
                    
                    VStack(alignment: .leading, spacing: 15) {
                        Text("aboutApp_string")
                            .font(.headline)
                        RetroView(type: .text("appVersion_string"), size: 15)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                .padding()
            }
            .sheet(isPresented: $showingLanguageSettingsSheet) {
                LanguageSettingsView(showingLanguageSettingsSheet: $showingLanguageSettingsSheet)
                    .presentationDetents([.medium])
                    .padding()
            }
            .sheet(isPresented: $showingColorSettingsSheet) {
                ColorSettingsView()
                    .presentationDetents([.medium])
                    .padding()
            }
        }
        .navigationBarTitle("settingsTitle_string")
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            RetroArrowView(size: CGSize(width: 30, height: 30))
                .buttonStyle(RetroButtonStyle())
        })
    }
}

#Preview {
    SettingsView()
}
