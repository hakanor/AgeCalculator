//
//  DetailViewModel.swift
//  AgeCalculator
//
//  Created by Hakan Or on 1.02.2024.
//

import SwiftUI
import Combine

class DetailViewModel: ObservableObject {
    
    @Published var ageInfo: AgeInfo = AgeInfo(fractionalAge:"", years: 0, months: 0, days: 0, hours: 0, minutes: 0, seconds: 0, daysUntilNextBirthday: 0)
    @Published var ageInfoDetail: [(String, String)] = [
        ("totalYears_string", ""),
        ("totalMonths_string", ""),
        ("totalDays_string", ""),
        ("totalHours_string", ""),
        ("totalMinutes_string", ""),
        ("totalSeconds_string", ""),
    ]
    private var ageService = AgeService.shared
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        withAnimation {
            self.ageService.$ageInfo
                .sink { [weak self] ageInfo in
                    guard let self = self else { return }
                    withAnimation {
                        self.ageInfo = ageInfo
                        self.ageInfoDetail = self.getAgeInfoDetail(ageInfo: ageInfo)
                    }
                }
                .store(in: &cancellables)
        }
    }
    
    func getAgeInfoDetail(ageInfo: AgeInfo) -> [(String, String)] {
        let ageInfoDetail: [(String, String)] = [
            ("totalYears_string", "\(ageInfo.years)"),
            ("totalMonths_string", "\(ageInfo.months)"),
            ("totalDays_string", "\(ageInfo.hours)"),
            ("totalHours_string", "\(ageInfo.minutes)"),
            ("totalMinutes_string", "\(ageInfo.minutes)"),
            ("totalSeconds_string", "\(ageInfo.seconds)"),
        ]
        return ageInfoDetail
    }
}
