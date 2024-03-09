//
//  PurchaseView.swift
//  AgeCalculator
//
//  Created by Hakan Or on 9.03.2024.
//

import SwiftUI
import StoreKit

struct PurchaseView: View {
    
    @StateObject var storeKit = StoreKitManager()
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(storeKit.storeProducts) { product in
                HStack {
                    Text(product.displayName)
                    Spacer()
                    Button(action: {
                        Task {
                            try await storeKit.purchase(product)
                        }
                    }) {
                        StoreItem(storeKit: storeKit, product: product)
                    }
                }
            }
            Divider()
            Button("Restore Purchases", action: {
                Task {
                    //This call displays a system prompt that asks users to authenticate with their App Store credentials.
                    //Call this function only in response to an explicit user action, such as tapping a button.
                    try? await AppStore.sync()
                }
            })
        }
        .navigationBarBackButtonHidden()
        .padding()
    }
}

struct StoreItem: View {
    @ObservedObject var storeKit : StoreKitManager
    @State var isPurchased: Bool = false
    var product: Product
    
    var body: some View {
        VStack {
            if isPurchased {
                Text(Image(systemName: "checkmark"))
                    .bold()
                    .padding(10)
            } else {
                Text(product.displayPrice)
                    .padding(10)
            }
        }
        .onChange(of: storeKit.purchasedProducts) { course in
            Task {
                isPurchased = (try? await storeKit.isPurchased(product)) ?? false
            }
        }
    }
}

#Preview {
    PurchaseView()
}
