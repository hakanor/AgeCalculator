import SwiftUI

enum RetroViewType {
    case text(String)
    case image(String)
}

struct RetroView: View {
    var type: RetroViewType
    var size: CGFloat = 30
    var action: () -> Void
    
    var body: some View {
        ZStack(alignment: .leading) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .offset(x: 4, y: 5)
                
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(ThemeColors.backgroundColor)
                
                HStack(spacing: 16) {
                    Button(action: action) {
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
                RoundedRectangle(cornerRadius: 8)
                    .stroke(style: StrokeStyle(lineWidth: 2.5, lineCap: .round, lineJoin: .round))
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
