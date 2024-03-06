//
//  ColorSettings.swift
//  AgeCalculator
//
//  Created by Hakan Or on 5.03.2024.
//

import SwiftUI

struct ColorSettingsView: View {
    
    @State private var redValue: Double = 0.5
    @State private var greenValue: Double = 0.5
    @State private var blueValue: Double = 0.5
    
    let basicColors: [Color] = [.red, .green, .blue, .yellow, .orange, .purple]
 
    var body: some View {
        VStack {
            HStack {
                Text("Red")
                SliderView(value: $redValue, sliderRange: 0...1, thumbColor: Color(red: redValue, green: greenValue, blue: blueValue))
                    .frame(height: 30)
            }
            
            HStack {
                Text("Blue")
                SliderView(value: $blueValue, sliderRange: 0...1, thumbColor: Color(red: redValue, green: greenValue, blue: blueValue))
                    .frame(height: 30)
            }
            
            HStack {
                Text("Green")
                SliderView(value: $greenValue, sliderRange: 0...1, thumbColor: Color(red: redValue, green: greenValue, blue: blueValue))
                    .frame(height: 30)
            }
            
            HStack {
                ForEach(basicColors, id: \.self) { color in
                    Circle()
                        .fill(color)
                        .frame(width: 30, height: 30)
                        .onTapGesture {
                            let uiColor = UIColor(color)
                            redValue = Double(uiColor.cgColor.components?[0] ?? 0)
                            greenValue = Double(uiColor.cgColor.components?[1] ?? 0)
                            blueValue = Double(uiColor.cgColor.components?[2] ?? 0)
                        }
                }
            }
            .padding()
            
            Button(action: {
                // burada renk kayıt etme ve kapatma işlemleri olacak
            }, label: {
                RetroView(type: .text("apply_string"),size: 16, backgroundColor: Color(red: redValue, green: greenValue, blue: blueValue))
                    .fixedSize()
            })
            .buttonStyle(RetroButtonStyle())
            
        }
        .padding()
    }
}
