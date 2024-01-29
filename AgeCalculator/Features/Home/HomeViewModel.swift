//
//  HomeViewModel.swift
//  AgeCalculator
//
//  Created by Hakan Or on 30.01.2024.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    var birthDate = ISO8601DateFormatter().date(from: "1999-01-20T19:20:46+0000")!
    
    init() {
    }
    
    public func calculateAge(from birthDate: Date) -> Double {
        let currentTime = Date()
        let timeDifference = currentTime.timeIntervalSince(birthDate)
        return timeDifference / 31556926
    }
    
    var ageFormatter: NumberFormatter = {
          var formatter = NumberFormatter()
          formatter.numberStyle = .decimal
          formatter.minimumFractionDigits = 7
          return formatter
      }()
}
