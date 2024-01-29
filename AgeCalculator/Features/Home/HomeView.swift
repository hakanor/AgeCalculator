//
//  ContentView.swift
//  AgeCalculator
//
//  Created by Hakan Or on 21.01.2024.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    
    @State var age: Double = 0
    let timerInterval = 1.0
    
    var body: some View {
        VStack {
            HStack {
                Text("Your age:")
                    .font(.system(size: 24, weight: .semibold, design: .monospaced))
                    .colorMultiply(.black)
                    .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 0))
                Spacer()
            }
            RetroView(text: "\(viewModel.ageFormatter.string(from: NSNumber(value: age))!)", action: {})
                .contentTransition(.numericText(value: age))
                .font(.largeTitle)
                .bold()
                .lineLimit(1)
                .padding()
                .frame(height: 100)
                .onAppear {
                    Timer.scheduledTimer(withTimeInterval: timerInterval, repeats: true) { timer in
                        withAnimation {
                            self.age = viewModel.calculateAge(from: viewModel.birthDate) 
                        }
                    }
                }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
