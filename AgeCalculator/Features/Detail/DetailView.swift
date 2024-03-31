//
//  DetailView.swift
//  AgeCalculator
//
//  Created by Hakan Or on 1.02.2024.
//

import SwiftUI

struct DetailView: View {
    
    @StateObject var viewModel = DetailViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        GeometryReader { geometry in
            VStack {
                Group {
                    if geometry.size.width < geometry.size.height {
                        ScrollView {
                            VStack(alignment: .leading, spacing: 16) {
                                ForEach(viewModel.ageInfoDetail, id: \.self.0) { detail in
                                    HStack {
                                        let localizedString = LocalizedStringKey(detail.0)
                                        Text(localizedString)
                                            .font(.system(size: 20, weight: .semibold, design: .monospaced))
                                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                        Spacer()
                                        RetroView(type: .text(detail.1.groupDigits()), size: 16)
                                            .contentTransition(.numericText(value: Double(detail.1) ?? 0.0))
                                            .fixedSize()
                                    }
                                }
                            }
                            .padding()
                        }
                    } else { // Ekran dikey ise
                        ScrollView(.vertical) {
                            HStack(spacing: 16) {
                                ForEach(viewModel.ageInfoDetail, id: \.self.0) { detail in
                                    VStack(alignment: .leading) {
                                        Text(detail.0)
                                            .font(.system(size: 20, weight: .semibold, design: .monospaced))
                                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                        Spacer()
                                        RetroView(type: .text(detail.1.groupDigits()), size: 16)
                                            .contentTransition(.numericText(value: Double(detail.1) ?? 0.0))
                                            .fixedSize()
                                    }
                                }
                            }
                            .padding()
                        }
                    }
                    Text("daysUntil_string")
                        .font(.system(size: 20, weight: .semibold, design: .monospaced))
                    RetroView(type: .text(String(viewModel.ageInfo.daysUntilNextBirthday)), size: 20)
                        .fixedSize()
                        .contentTransition(.numericText(value: Double(viewModel.ageInfo.daysUntilNextBirthday)))
                    Text("toNextBirthday_string")
                        .font(.system(size: 20, weight: .semibold, design: .monospaced))
                }
                .padding()
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            RetroArrowView(size: CGSize(width: 30, height: 30))
                .buttonStyle(RetroButtonStyle())
        })
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}

struct DetailRow: View {
    let title: String
    let value: String

    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 20, weight: .semibold, design: .monospaced))
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            Spacer()
            RetroView(type: .text(value.groupDigits()), size: 16)
                .contentTransition(.numericText(value: Double(value) ?? 0.0))
                .fixedSize()
        }
    }
}
