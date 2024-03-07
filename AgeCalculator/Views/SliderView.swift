//
//  SliderView.swift
//  AgeCalculator
//
//  Created by Hakan Or on 6.03.2024.
//

import SwiftUI

struct SliderView: View {
    
    @EnvironmentObject var themeColors: ThemeColors
    @Binding var value: Double
    @State var lastCoordinateValue: CGFloat = 0.0
    var sliderRange: ClosedRange<Double> = 1...100
    var thumbColor: Color = Color(.systemGray)
    var minTrackColor: Color = Color(.systemGray3)
    var maxTrackColor: Color = Color(.systemGray4)
    
    var body: some View {
        GeometryReader { gr in
            let thumbHeight = gr.size.height * 1.1
            let thumbWidth = gr.size.width * 0.03
            let radius = gr.size.height * 0.5
            let minValue = gr.size.width * 0.015
            let maxValue = (gr.size.width * 0.98) - thumbWidth
            
            let scaleFactor = (maxValue - minValue) / (sliderRange.upperBound - sliderRange.lowerBound)
            let lower = sliderRange.lowerBound
            let sliderVal = (self.value - lower) * scaleFactor + minValue
            
            ZStack {
                
                Rectangle()
                    .foregroundColor(maxTrackColor)
                    .frame(width: gr.size.width, height: gr.size.height * 0.95)
                    .clipShape(RoundedRectangle(cornerRadius: radius))
                HStack {
                    Rectangle()
                        .foregroundColor(minTrackColor)
                        .frame(width: sliderVal, height: gr.size.height * 0.95)
                    Spacer()
                }
                .clipShape(RoundedRectangle(cornerRadius: radius))
                HStack {
                    ZStack {
                        
                        // Top Label
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundColor(thumbColor)
                        
                        // Stroke
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(style: StrokeStyle(lineWidth: 2.5, lineCap: .round, lineJoin: .round))
                            .colorMultiply(themeColors.strokeColor)
                    }
                    
                    .foregroundColor(thumbColor)
                    .frame(width: thumbWidth, height: thumbHeight)
                    .offset(x: sliderVal)
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { v in
                                if (abs(v.translation.width) < 0.1) {
                                    self.lastCoordinateValue = sliderVal
                                }
                                if v.translation.width > 0 {
                                    let nextCoordinateValue = min(maxValue, self.lastCoordinateValue + v.translation.width)
                                    self.value = ((nextCoordinateValue - minValue) / scaleFactor)  + lower
                                } else {
                                    let nextCoordinateValue = max(minValue, self.lastCoordinateValue + v.translation.width)
                                    self.value = ((nextCoordinateValue - minValue) / scaleFactor) + lower
                                }
                            }
                    )
                    Spacer()
                }
            }
        }
    }
}
