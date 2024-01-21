//
//  ContentView.swift
//  AgeCalculator
//
//  Created by Hakan Or on 21.01.2024.
//

import SwiftUI

struct ContentView: View {
    @State var birthDate = ISO8601DateFormatter().date(from: "1999-01-20T19:20:46+0000")!
    @State var age: Double = 0
    @State var ageToShow: Double = 0
    let timerInterval = 1.0
    
    var ageFormatter: NumberFormatter = {
        var formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 4 // Küsüratlı kısmın minimum 4 hane olması için
        return formatter
    }()
    
    var body: some View {
        VStack {
            Text("\(ageFormatter.string(from: NSNumber(value: age))!)")
                .contentTransition(.numericText(value: age))
                .font(.largeTitle)
                .bold()
                .onAppear {
                    Timer.scheduledTimer(withTimeInterval: timerInterval, repeats: true) { timer in
                        age = calculateAgeInSeconds(from: birthDate)
                        incrementAge(with: timerInterval)
                        
                    }
                }
                .lineLimit(1)
            
            Button {
                self.incrementAge(with: 1)
            } label: {
                Text("Get older")
            }
        }
        .padding()
    }
    
    func calculateAgeInSeconds(from birthDate: Date) -> Double {
        let currentTime = Date()
        let timeDifference = currentTime.timeIntervalSince(birthDate)
        return timeDifference
    }
    
    func incrementAge(with amount: Double) {
        withAnimation {
            self.age += amount
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
