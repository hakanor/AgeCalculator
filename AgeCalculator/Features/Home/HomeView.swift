//
//  ContentView.swift
//  AgeCalculator
//
//  Created by Hakan Or on 21.01.2024.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = HomeViewModel()
    @State var showingBottomSheet = false
    
    var body: some View {
        GeometryReader { geometry in
            if geometry.size.width < geometry.size.height { // dikey
                NavigationView {
                    VStack {
                        HStack {
                            VStack {
                                Button(action: {
                                    showingBottomSheet.toggle()
                                }, label: {
                                    RetroView(type: .text(BirthDateService.shared.selectedBirthDate?.name ?? "addDate_string"), size: 20)
                                        .fixedSize()
                                })
                                .buttonStyle(RetroButtonStyle())
                            }
                            .sheet(isPresented: $showingBottomSheet) {
                                BottomSheetView()
                                    .presentationDetents([.medium])
                            }
                            Spacer()
                            NavigationLink {
                                SettingsView()
                            } label: {
                                RetroView(type: .image("gearshape.fill"), size: 20)
                                    .fixedSize()
                            }
                            .buttonStyle(RetroButtonStyle())
                        }
                        .padding()
                        Spacer()
                        HStack {
                            Text("age_string")
                                .font(.system(size: 24, weight: .semibold, design: .monospaced))
                                .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 0))
                            Spacer()
                        }
                        NavigationLink {
                            DetailView()
                        } label: {
                            RetroView(type: .text("\(viewModel.ageInfo.fractionalAge)"))
                                .contentTransition(.numericText(value: Double(viewModel.ageInfo.fractionalAge) ?? 0))
                                .padding()
                                .frame(height: 100)
                        }
                        .buttonStyle(RetroButtonStyle())
                        Spacer()
                    }
                    .padding()
                }
            } else { // yatay
                VStack() {
                    Spacer()
                    RetroView(type: .text("\(viewModel.ageInfo.fractionalAge)"),
                    size: 60)
                        .contentTransition(.numericText(value: Double(viewModel.ageInfo.fractionalAge) ?? 0))
                        .padding()
                        .fixedSize()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    Spacer()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
