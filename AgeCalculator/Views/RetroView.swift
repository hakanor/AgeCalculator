import SwiftUI

enum RetroViewType {
    case text(String)
    case image(String)
}

struct RetroView: View {
    var type: RetroViewType
    var size: CGFloat = 30
    var action: () -> Void
    
    @State private var isTapped = false
    
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
                            .opacity(isTapped ? 0.4 : 1)
                            .bold()
                    case .image(let string):
                        Image(systemName: string)
                            .font(.system(size: size))
                            .foregroundColor(ThemeColors.labelColor)
                    }
                }
                .padding(10)
                
            }
            .scaleEffect(isTapped ? 1.05 : 1)
            .onTapGesture {
                withAnimation {
                    isTapped.toggle()
                    action()
                }
                isTapped.toggle()
            }
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        RetroView(type: .text("Test"), action: {})
            .fixedSize(horizontal: false, vertical: true)
            .padding(24)
    }
}
