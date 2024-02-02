import SwiftUI

enum RetroViewType {
    case text(String)
    case image(String)
}

struct RetroButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}

struct RetroView: View {
    var type: RetroViewType
    var size: CGFloat = 30
    
    var body: some View {
        ZStack(alignment: .leading) {
            ZStack {
                // Bottom Shadow
                RoundedRectangle(cornerRadius: 8)
                    .offset(x: 4, y: 5)
                
                // Top Label
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(ThemeColors.backgroundColor)
                
                // Stroke
                RoundedRectangle(cornerRadius: 8)
                    .stroke(style: StrokeStyle(lineWidth: 2.5, lineCap: .round, lineJoin: .round))
                
                HStack(spacing: 16) {
                    switch type {
                    case .text(let string):
                        Text(string)
                            .font(.system(size: size, weight: .semibold, design: .monospaced))
                            .colorMultiply(ThemeColors.labelColor)
                            .bold()
                    case .image(let string):
                        Image(systemName: string)
                            .font(.system(size: size))
                            .foregroundColor(ThemeColors.labelColor)
                    }
                }
                .padding(10)
                
            }
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        RetroView(type: .text("Test"))
            .fixedSize(horizontal: false, vertical: true)
            .padding(24)
    }
}
