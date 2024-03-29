//
//  PurchaseViewModel.swift
//  AgeCalculator
//
//  Created by Hakan Or on 29.03.2024.
//

import SwiftUI
import StoreKit

class PurchaseViewModel: ObservableObject {
    
    @Published var randomNumbers = "0"
    
    func startRandomizingNumbers() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
            let randomNumber = Double.random(in: 1...100)
            withAnimation {
                self.randomNumbers = String(format: "%.5f", randomNumber)
            }
            self.startRandomizingNumbers()
        }
    }
    
    func restorePurchases() async {
        try? await AppStore.sync()
    }
}
