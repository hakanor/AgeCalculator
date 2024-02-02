//
//  HomeViewModel.swift
//  AgeCalculator
//
//  Created by Hakan Or on 30.01.2024.
//

import SwiftUI

class HomeViewModel: ObservableObject {

    @Published var age: Double = 0
    
    var birthDate = ISO8601DateFormatter().date(from: "1999-01-20T19:20:46+0000")!
    let timerInterval = 1.0
    
    init() {
        startTimer()
    }
    
    public func startTimer() {
        Timer.scheduledTimer(withTimeInterval: timerInterval, repeats: true) { timer in
            withAnimation {
                self.age = self.calculateAge(from: self.birthDate)
            }
        }
    }
    
    public func calculateAge(from birthDate: Date) -> Double {
        let currentTime = Date()
        let timeDifference = currentTime.timeIntervalSince(birthDate)
        return timeDifference / 31556926
    }
    
    func formatAge(_ number: Double) -> String {
        return String(format: "%.7f", number)
    }
}
