//
//  ContentView.swift
//  AgeCalculator
//
//  Created by Hakan Or on 21.01.2024.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    NavigationLink {
                        DetailView()
                    } label: {
                        RetroView(type: .text("Profile"), size: 20)
                            .fixedSize()
                    }
                    .buttonStyle(RetroButtonStyle())
                    Spacer()
                    NavigationLink {
                        DetailView()
                    } label: {
                        RetroView(type: .image("gearshape.fill"), size: 20)
                            .fixedSize()
                    }
                    .buttonStyle(RetroButtonStyle())
                }
                .padding()
                Spacer()
                HStack {
                    Text("Age:")
                        .font(.system(size: 24, weight: .semibold, design: .monospaced))
                        .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 0))
                    Spacer()
                }
                NavigationLink {
                    DetailView()
                } label: {
                    RetroView(type: .text(viewModel.formatAge(viewModel.age)))
                        .contentTransition(.numericText(value: viewModel.age))
                        .padding()
                        .frame(height: 100)
                        .onAppear {
                            viewModel.startTimer()
                        }
                }
                .buttonStyle(RetroButtonStyle())
                Spacer()
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
