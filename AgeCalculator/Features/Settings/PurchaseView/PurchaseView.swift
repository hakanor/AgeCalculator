//
//  PurchaseView.swift
//  AgeCalculator
//
//  Created by Hakan Or on 9.03.2024.
//

import SwiftUI

enum PremiumFeatures: LocalizedStringKey, CaseIterable {
    case unlimited_age_track_string
    case unlock_button_colors_string
    case unlock_dark_mode_string
}

struct PurchaseView: View {
    
    @StateObject var viewModel = PurchaseViewModel()
    @EnvironmentObject var storeKitManager: StoreKitManager
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack(spacing: 20) {
            
            RetroView(type: .text(viewModel.randomNumbers))
                .padding()
                .contentTransition(.numericText(value: Double(viewModel.randomNumbers) ?? 0))
                .onAppear {
                    viewModel.startRandomizingNumbers()
                }
                .fixedSize()
            
            Text("premium_title_string")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            Text("premium_subtitle_string")
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            HStack {
                VStack(alignment: .leading) {
                    ForEach(PremiumFeatures.allCases, id: \.self) { premiumFeature in
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(ThemeColors.shared.backgroundColor)
                            Text(premiumFeature.rawValue)
                        }
                        .padding(.vertical, 2)
                    }
                }
                .padding()
            }
            Text("unlock_premium_string")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.primary)

            ForEach(storeKitManager.storeProducts) { product in
                StoreItem(storeKit: storeKitManager, product: product)
                    .padding(.horizontal)
            }
            
            Spacer()
            Divider()
            Button(action: {
                Task {
                    // Restore purchases
                    await viewModel.restorePurchases()
                }
            }) {
                Text("restore_purchases_string")
                    .font(.headline)
                    .foregroundColor(ThemeColors.shared.labelColor)
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
        .padding()
    }
}

#Preview {
    PurchaseView()
}
