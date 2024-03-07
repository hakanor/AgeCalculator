//
//  ColorSettings.swift
//  AgeCalculator
//
//  Created by Hakan Or on 5.03.2024.
//

import SwiftUI

struct ColorSettingsView: View {
    
    @EnvironmentObject var themeColors: ThemeColors
    @Environment(\.presentationMode) var presentationMode
    @State private var redValue: Double = 0.754
    @State private var greenValue: Double = 0.754
    @State private var blueValue: Double = 0.754
    
    let basicColors: [Color] = [.red, .green, .blue, .yellow, .orange, .purple]
 
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    themeColors.resetColors()
                    redValue = 0.754
                    greenValue = 0.754
                    blueValue = 0.754
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "arrow.counterclockwise")
                        .foregroundStyle(Color("backgroundColor"))
                        .font(.system(size: 24, weight: .semibold))
                        .padding(.vertical, 5)
                }
            }
            
            HStack {
                Text("Red")
                    .font(.system(.title2))
                    .frame(width: 70)
                SliderView(value: $redValue, sliderRange: 0...1, thumbColor: Color(red: redValue, green: greenValue, blue: blueValue))
                    .frame(height: 30)
            }
            
            HStack {
                Text("Blue")
                    .font(.system(.title2))
                    .frame(width: 70)
                SliderView(value: $blueValue, sliderRange: 0...1, thumbColor: Color(red: redValue, green: greenValue, blue: blueValue))
                    .frame(height: 30)
            }
            
            HStack {
                Text("Green")
                    .font(.system(.title2))
                    .frame(width: 70)
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
                let newColor = Color(red: redValue, green: greenValue, blue: blueValue)
                themeColors.save(color: newColor)
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                RetroView(type: .text("apply_string"),size: 16, color: Color(red: redValue, green: greenValue, blue: blueValue))
                    .fixedSize()
            })
            .buttonStyle(RetroButtonStyle())
            
        }
        .onAppear(perform: {
            let uiColor = UIColor(themeColors.backgroundColor)
            var red: CGFloat = 0
            var green: CGFloat = 0
            var blue: CGFloat = 0
            var alpha: CGFloat = 0
            uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
            self.redValue = Double(red)
            self.greenValue = Double(green)
            self.blueValue = Double(blue)
        })
        .padding()
    }
}
