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
    let timerInterval = 1.0
    
    var ageFormatter: NumberFormatter = {
        var formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 7
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
                        withAnimation {
                            self.age = calculateAge(from: birthDate) / 31556926
                        }
                    }
                }
                .lineLimit(1)
        }
        .padding()
    }
    
    func calculateAge(from birthDate: Date) -> Double {
        let currentTime = Date()
        let timeDifference = currentTime.timeIntervalSince(birthDate)
        return timeDifference
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
