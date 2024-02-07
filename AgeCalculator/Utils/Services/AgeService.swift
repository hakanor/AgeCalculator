//
//  AgeService.swift
//  AgeCalculator
//
//  Created by Hakan Or on 3.02.2024.
//

import Foundation

class AgeService {
    static let shared = AgeService()
    
    private var birthDate: Date
    private var timer: Timer?
    
    @Published var ageInfo: AgeInfo = AgeInfo(fractionalAge: "", years: 0, months: 0, days: 0, hours: 0, minutes: 0, seconds: 0, daysUntilNextBirthday: 0)
    
    private init() {
        self.birthDate = ISO8601DateFormatter().date(from: "1999-01-20T19:20:46+0000")!
        startTimer()
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.calculateDetails()
        }
    }
    
    private func calculateDetails() {
        let calendar = Calendar.current
        let now = Date()
        
        let years = calendar.dateComponents([.year], from: birthDate, to: now).year ?? 0
        let months = calendar.dateComponents([.month], from: birthDate, to: now).month ?? 0
        let days = calendar.dateComponents([.day], from: birthDate, to: now).day ?? 0
        let hours = calendar.dateComponents([.hour], from: birthDate, to: now).hour ?? 0
        let minutes = calendar.dateComponents([.minute], from: birthDate, to: now).minute ?? 0
        let seconds = calendar.dateComponents([.second], from: birthDate, to: now).second ?? 0
        
        let daysUntilNextBirthday = self.daysUntilNextBirthday(birthday: birthDate)
        
        self.ageInfo = AgeInfo(fractionalAge: "\(Double(seconds) / 31556926)", years: years, months: months, days: days, hours: hours, minutes: minutes, seconds: seconds, daysUntilNextBirthday: daysUntilNextBirthday)
    }
    
    private func daysUntilNextBirthday(birthday: Date) -> Int {
        let today = Date()
        let calendar = Calendar.current
        
        var nextBirthdayComponents = calendar.dateComponents([.month, .day, .year], from: today)
        let birthComponents = calendar.dateComponents([.month, .day], from: birthday)
        
        if let nextBirthdayDate = calendar.date(from: nextBirthdayComponents),
           nextBirthdayDate <= today {
            nextBirthdayComponents.year = (nextBirthdayComponents.year ?? 0) + 1
        }
        
        nextBirthdayComponents.month = birthComponents.month
        nextBirthdayComponents.day = birthComponents.day
        
        guard let nextBirthdayDate = calendar.date(from: nextBirthdayComponents) else {
            return 0
        }
        
        let difference = calendar.dateComponents([.day], from: today, to: nextBirthdayDate)
        return difference.day ?? 0
    }
}
