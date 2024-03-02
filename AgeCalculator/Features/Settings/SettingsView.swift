//
//  SettingsView.swift
//  AgeCalculator
//
//  Created by Hakan Or on 2.03.2024.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var isDarkModeEnabled = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                VStack(alignment: .leading, spacing: 15) {
                    Text("General Settings")
                        .font(.headline)
                    
                    NavigationLink(destination: ColorSettingsView()) {
                        RetroView(type: .settings("Change Language"), size: 15)
                            .fixedSize(horizontal: false, vertical: true)
                    }.buttonStyle(RetroButtonStyle())
                    
                    NavigationLink(destination: ColorSettingsView()) {
                        RetroView(type: .settings("Change Color"), size: 15)
                            .fixedSize(horizontal: false, vertical: true)
                    }.buttonStyle(RetroButtonStyle())
                }
                
                VStack(alignment: .leading, spacing: 15) {
                    Text("Premium Settings")
                        .font(.headline)
                    
                    NavigationLink(destination: ColorSettingsView()) {
                        RetroView(type: .settings("Change Button Color"), size: 15)
                            .fixedSize(horizontal: false, vertical: true)
                    }.buttonStyle(RetroButtonStyle())
                    
                    RetroView(type: .toggle($isDarkModeEnabled, "Toggle Dark Mode"), size: 15)
                }
                
                VStack(alignment: .leading, spacing: 15) {
                    Text("About App")
                        .font(.headline)
                    RetroView(type: .text("App Version: 1.0.1"), size: 15)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            .padding()
        }
        .navigationBarTitle("Settings")
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            RetroArrowView(size: CGSize(width: 30, height: 30), color: ThemeColors.labelColor)
                .buttonStyle(RetroButtonStyle())
        })
    }
}


struct LanguageSettingsView: View {
    var body: some View {
        Text("language change screen")
    }
}

struct ColorSettingsView: View {
    var body: some View {
        Text("color change screen")
    }
}

#Preview {
    SettingsView()
}
