//
//  String+GroupDigits.swift
//  AgeCalculator
//
//  Created by Hakan Or on 7.02.2024.
//

import Foundation
extension String {
    func groupDigits() -> String {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = "."
        formatter.numberStyle = .decimal
        
        if let number = formatter.number(from: self) {
            return formatter.string(from: number) ?? ""
        } else {
            return self
        }
    }
}
