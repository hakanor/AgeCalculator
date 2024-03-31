import SwiftUI

enum RetroViewType {
    case text(String)
    case image(String)
    case textField(Binding<String>, String)
    case toggle(Binding<Bool>, String)
    case settings(String)
}

struct RetroButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}

struct RetroView: View {
    
    @EnvironmentObject var themeColors: ThemeColors
    var type: RetroViewType
    var size: CGFloat = 30
    
    var color: Color?
    
    var body: some View {
        ZStack(alignment: .leading) {
            ZStack {
                // Bottom Shadow
                RoundedRectangle(cornerRadius: 8)
                    .offset(x: 4, y: 5)
                    .foregroundColor(themeColors.labelColor)
                
                // Top Label
                RoundedRectangle(cornerRadius: 8)
                // varsa color kullanılsın, yoksa themeColors.backgroundColor
                    .foregroundColor(color != nil ? color : themeColors.backgroundColor)
                
                // Stroke
                RoundedRectangle(cornerRadius: 8)
                    .stroke(style: StrokeStyle(lineWidth: 2.5, lineCap: .round, lineJoin: .round))
                    .colorMultiply(themeColors.strokeColor)
                
                HStack(spacing: 16) {
                    switch type {
                    case .text(let string):
                        var text = LocalizedStringKey(string)
                        Text(text)
                            .font(.system(size: size, weight: .semibold, design: .monospaced))
                            .colorMultiply(themeColors.strokeColor)
                            .bold()
                    case .image(let string):
                        Image(systemName: string)
                            .font(.system(size: size))
                            .foregroundColor(themeColors.strokeColor)
                    case .textField(let binding, let placeholder):
                        HStack {
                            var text = LocalizedStringKey(placeholder)
                            Image(systemName: "textformat")
                            TextField(text, text: binding)
                                .textFieldStyle(.plain)
                                .background(.clear)
                        }
                    case .toggle(let binding, let title):
                        HStack {
                            var text = LocalizedStringKey(title)
                            Toggle(text, isOn: binding)
                                .font(.system(size: size, weight: .semibold, design: .monospaced))
                                .toggleStyle(SwitchToggleStyle(tint: .black))
                        }
                        .padding(.horizontal, 10)
                    case .settings(let string):
                        HStack {
                            var text = LocalizedStringKey(string)
                            Text(text)
                                .font(.system(size: size, weight: .semibold, design: .monospaced))
                                .bold()
                            Spacer()
                            Image(systemName: "chevron.right")
                                .font(.system(size: size, weight: .semibold, design: .monospaced))
                                .foregroundColor(themeColors.labelColor)
                            
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                    }
                }
                .padding(10)
                
            }
        }
    }
}

struct TestView_Previews: PreviewProvider {
    @State var textField = ""
    static var previews: some View {
        RetroView(type: .text("Test"))
            .fixedSize(horizontal: false, vertical: true)
            .padding(24)
    }
}
