//
//  HomeViewModel.swift
//  AgeCalculator
//
//  Created by Hakan Or on 30.01.2024.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var ageInfo: AgeInfo = AgeInfo(fractionalAge:"", years: 0, months: 0, days: 0, hours: 0, minutes: 0, seconds: 0, daysUntilNextBirthday: 0)
    private var ageService = AgeService.shared
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        withAnimation {
            self.ageService.$ageInfo
                .sink { [weak self] ageInfo in
                    guard let self = self else { return }
                    withAnimation {
                        self.ageInfo = ageInfo
                    }
                }
                .store(in: &cancellables)
        }
    }
}
