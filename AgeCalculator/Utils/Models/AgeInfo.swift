//
//  AgeInfo.swift
//  AgeCalculator
//
//  Created by Hakan Or on 3.02.2024.
//

import Foundation

struct AgeInfo {
    let fractionalAge: String
    let years: Int
    let months: Int
    let days: Int
    let hours: Int
    let minutes: Int
    let seconds: Int
    let daysUntilNextBirthday: Int
    
    init(fractionalAge: String, years: Int, months: Int, days: Int, hours: Int, minutes: Int, seconds: Int, daysUntilNextBirthday: Int) {
        self.fractionalAge = String(format: "%.7f", Double(seconds) / 31556926)
        self.years = years
        self.months = months
        self.days = days
        self.hours = hours
        self.minutes = minutes
        self.seconds = seconds
        self.daysUntilNextBirthday = daysUntilNextBirthday
    }
}
