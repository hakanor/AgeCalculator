//
//  StoreItemView.swift
//  AgeCalculator
//
//  Created by Hakan Or on 29.03.2024.
//

import SwiftUI
import StoreKit

struct StoreItem: View {
    @ObservedObject var storeKit : StoreKitManager
    @State var isPurchased: Bool = false
    var product: Product
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(product.displayName)
                    .font(.headline)
                    .foregroundColor(.primary)
                Text(product.displayPrice)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
            if isPurchased {
                Image(systemName: "checkmark")
                    .foregroundColor(.green)
            } else {
                Button(action: {
                    Task {
                        try await storeKit.purchase(product)
                    }
                }) {
                    RetroView(type: .text("Buy"), size: 12)
                        .fixedSize()
                        
                }
                .buttonStyle(RetroButtonStyle())
            }
        }
        .onChange(of: storeKit.purchasedProducts) { course in
            Task {
                isPurchased = (try? await storeKit.isPurchased(product)) ?? false
            }
        }
        .onAppear(perform: {
            Task {
                isPurchased = (try? await storeKit.isPurchased(product)) ?? false
            }
        })
        .padding(.vertical, 10)
        .padding(.horizontal)
        .background(Color.secondary.opacity(0.1))
        .cornerRadius(10)
    }
}
