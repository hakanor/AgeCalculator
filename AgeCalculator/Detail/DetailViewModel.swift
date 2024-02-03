//
//  DetailViewModel.swift
//  AgeCalculator
//
//  Created by Hakan Or on 1.02.2024.
//

import SwiftUI

class DetailViewModel: ObservableObject {
    
    @Published var details: [(String, String)] = [
        ("Total Years:", "Years"),
        ("Total Months:", "Months"),
        ("Total Days:", "Days"),
        ("Total Hours:", "Hours"),
        ("Total Minutes:", "Minutes"),
        ("Total Seconds:", "Seconds")
    ]
    @Published var daysUntilNextBirthday: Int = 0
    @Published var test: Double = 0
    
    let timerInterval = 1.0
    var birthDate = ISO8601DateFormatter().date(from: "1999-01-20T19:20:46+0000")!
    
    init() {
        startTimer()
    }
    
    func startTimer() {
        Timer.scheduledTimer(withTimeInterval: timerInterval, repeats: true) { timer in
            withAnimation {
                self.calculateDetails()
            }
        }
    }
    
    func calculateDetails() {
        let calendar = Calendar.current
        let now = Date()
        
        let years = calendar.dateComponents([.year], from: birthDate, to: now).year ?? 0
        let months = calendar.dateComponents([.month], from: birthDate, to: now).month ?? 0
        let days = calendar.dateComponents([.day], from: birthDate, to: now).day ?? 0
        let hours = calendar.dateComponents([.hour], from: birthDate, to: now).hour ?? 0
        let minutes = calendar.dateComponents([.minute], from: birthDate, to: now).minute ?? 0
        let seconds = calendar.dateComponents([.second], from: birthDate, to: now).second ?? 0
        
        daysUntilNextBirthday = daysUntilNextBirthday(birthday: birthDate)
        
        details[0].1 = "\(years)"
        details[1].1 = "\(months)"
        details[2].1 = "\(days)"
        details[3].1 = "\(hours)"
        details[4].1 = "\(minutes)"
        details[5].1 = "\(seconds)"
    }
    
    func daysUntilNextBirthday(birthday: Date) -> Int {
        let today = Date()
        let calendar = Calendar.current
        
        // this year's birthday date
        var nextBirthdayComponents = calendar.dateComponents([.month, .day, .year], from: today)
        let birthComponents = calendar.dateComponents([.month, .day], from: birthday)
        
        // next year's birthday date
        if let nextBirthdayDate = calendar.date(from: nextBirthdayComponents),
           nextBirthdayDate <= today {
            nextBirthdayComponents.year = (nextBirthdayComponents.year ?? 0) + 1
        }
        
        nextBirthdayComponents.month = birthComponents.month
        nextBirthdayComponents.day = birthComponents.day
        
        // nextBirthdayDate
        guard let nextBirthdayDate = calendar.date(from: nextBirthdayComponents) else {
            return 0
        }
        
        // difference between today - nextBirthdayDate
        let difference = calendar.dateComponents([.day], from: today, to: nextBirthdayDate)
        return difference.day ?? 0
    }
}
