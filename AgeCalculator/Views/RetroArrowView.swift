//
//  RetroArrowView.swift
//  AgeCalculator
//
//  Created by Hakan Or on 3.02.2024.
//

import SwiftUI

struct RetroArrowView: View {
    var size: CGSize
    var offsetx: Double = 1.0
    var offsety: Double = 2.0
    
    var backgroundColor : Color = Color("backgroundColor")
    var labelColor : Color = Color("labelColor")
    var strokeColor : Color = Color("strokeColor")
    
    var body: some View {
        ZStack {
            // Arrow Shape
            GeometryReader { geometry in
                Path { path in
                    let width = geometry.size.width
                    let height = geometry.size.height
                    
                    path.move(to: CGPoint(x: width * 0.8, y: height * 0.5))
                    path.addLine(to: CGPoint(x: width * 0.2, y: height * 0.5))
                    path.addLine(to: CGPoint(x: width * 0.4, y: height * 0.3))
                    path.move(to: CGPoint(x: width * 0.2, y: height * 0.5))
                    path.addLine(to: CGPoint(x: width * 0.4, y: height * 0.7))
                }
                .stroke(style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
                .foregroundColor(strokeColor)
            }
            
            GeometryReader { geometry in
                Path { path in
                    let width = geometry.size.width
                    let height = geometry.size.height
                    
                    path.move(to: CGPoint(x: width * 0.8 - offsetx, y: height * 0.5 - offsety))
                    path.addLine(to: CGPoint(x: width * 0.2 - offsetx, y: height * 0.5 - offsety))
                    path.addLine(to: CGPoint(x: width * 0.4 - offsetx, y: height * 0.3 - offsety))
                    path.move(to: CGPoint(x: width * 0.2 - offsetx, y: height * 0.5 - offsety))
                    path.addLine(to: CGPoint(x: width * 0.4 - offsetx, y: height * 0.7 - offsety))
                }
                .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                .foregroundColor(labelColor)
            }
            
            GeometryReader { geometry in
                Path { path in
                    let width = geometry.size.width
                    let height = geometry.size.height
                    
                    path.move(to: CGPoint(x: width * 0.8 - offsetx, y: height * 0.5 - offsety))
                    path.addLine(to: CGPoint(x: width * 0.2 - offsetx, y: height * 0.5 - offsety))
                    path.addLine(to: CGPoint(x: width * 0.4 - offsetx, y: height * 0.3 - offsety))
                    path.move(to: CGPoint(x: width * 0.2 - offsetx, y: height * 0.5 - offsety))
                    path.addLine(to: CGPoint(x: width * 0.4 - offsetx, y: height * 0.7 - offsety))
                }
                .stroke(style: StrokeStyle(lineWidth: 2.5, lineCap: .round, lineJoin: .round))
                .foregroundColor(backgroundColor)
            }
        }
        .frame(width: size.width, height: size.height)
    }
}

struct TestArrowView_Previews: PreviewProvider {
    static var previews: some View {
        RetroArrowView(size: CGSize(width: 30, height: 30))
    }
}
