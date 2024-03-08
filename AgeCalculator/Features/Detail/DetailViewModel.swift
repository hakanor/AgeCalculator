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
        (NSLocalizedString("totalYears_string", comment: ""), ""),
        (NSLocalizedString("totalMonths_string", comment: ""), ""),
        (NSLocalizedString("totalDays_string", comment: ""), ""),
        (NSLocalizedString("totalHours_string", comment: ""), ""),
        (NSLocalizedString("totalMinutes_string", comment: ""), ""),
        (NSLocalizedString("totalSeconds_string", comment: ""), ""),
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
            (NSLocalizedString("totalYears_string", comment: ""), "\(ageInfo.years)"),
            (NSLocalizedString("totalMonths_string", comment: ""), "\(ageInfo.months)"),
            (NSLocalizedString("totalDays_string", comment: ""), "\(ageInfo.hours)"),
            (NSLocalizedString("totalHours_string", comment: ""), "\(ageInfo.minutes)"),
            (NSLocalizedString("totalMinutes_string", comment: ""), "\(ageInfo.minutes)"),
            (NSLocalizedString("totalSeconds_string", comment: ""), "\(ageInfo.seconds)"),
        ]
        return ageInfoDetail
    }
}
