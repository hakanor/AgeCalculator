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
    var type: RetroViewType
    var size: CGFloat = 30
    
    var backgroundColor : Color = Color("backgroundColor")
    var labelColor : Color = Color("labelColor")
    var strokeColor : Color = Color("strokeColor")
    
    var body: some View {
        ZStack(alignment: .leading) {
            ZStack {
                // Bottom Shadow
                RoundedRectangle(cornerRadius: 8)
                    .offset(x: 4, y: 5)
                    .foregroundColor(labelColor)
                
                // Top Label
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(backgroundColor)
                
                // Stroke
                RoundedRectangle(cornerRadius: 8)
                    .stroke(style: StrokeStyle(lineWidth: 2.5, lineCap: .round, lineJoin: .round))
                    .colorMultiply(strokeColor)
                
                HStack(spacing: 16) {
                    switch type {
                    case .text(let string):
                        Text(string)
                            .font(.system(size: size, weight: .semibold, design: .monospaced))
                            .colorMultiply(strokeColor)
                            .bold()
                    case .image(let string):
                        Image(systemName: string)
                            .font(.system(size: size))
                            .foregroundColor(strokeColor)
                    case .textField(let binding, let placeholder):
                        HStack {
                            Image(systemName: "textformat")
                            TextField(placeholder, text: binding)
                                .textFieldStyle(.plain)
                                .background(.clear)
                        }
                    case .toggle(let binding, let title):
                        HStack {
                            Toggle(title, isOn: binding)
                                .font(.system(size: size, weight: .semibold, design: .monospaced))
                                .toggleStyle(SwitchToggleStyle(tint: .black))
                        }
                        .padding(.horizontal, 10)
                        
                    case .settings(let string):
                        HStack {
                            Text(string)
                                .font(.system(size: size, weight: .semibold, design: .monospaced))
                                .bold()
                            Spacer()
                            Image(systemName: "chevron.right")
                                .font(.system(size: size, weight: .semibold, design: .monospaced))
                                .foregroundColor(labelColor)
                            
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
