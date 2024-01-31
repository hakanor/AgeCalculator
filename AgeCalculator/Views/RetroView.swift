import SwiftUI

struct RetroView: View {
    var text: String
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
                        Text(text)
                            .font(.system(size: 30, weight: .semibold, design: .monospaced))
                            .colorMultiply(ThemeColors.labelColor)
                            .bold()
                    }
                }
                RoundedRectangle(cornerRadius: 8)
                    .stroke(style: StrokeStyle(lineWidth: 2.5, lineCap: .round, lineJoin: .round))
            }
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        RetroView(text: "Test", action: {})
            .fixedSize(horizontal: false, vertical: true)
            .padding(24)
    }
}
