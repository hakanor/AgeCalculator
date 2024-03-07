//
//  BottomSheetView.swift
//  AgeCalculator
//
//  Created by Hakan Or on 8.02.2024.
//

import SwiftUI

struct BottomSheetView: View {
    
    @EnvironmentObject var themeColors: ThemeColors
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var birthDateService = BirthDateService.shared
    @StateObject private var viewModel = BottomSheetViewModel()
    @State private var isAddDateSheetPresented = false
    @State private var isEdited : Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    isAddDateSheetPresented = true
                }, label: {
                    RetroView(type: .image("plus"), size: 14, color: themeColors.success)
                        .fixedSize()
                }).buttonStyle(RetroButtonStyle())
                    .padding()
                
                let text = String(viewModel.calculateRemainingBirthDates())
                Text("remaining_string \(text)")
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        isEdited.toggle()
                    }
                }, label: {
                    RetroView(type: .image("pencil"), size: 14)
                        .fixedSize()
                }).buttonStyle(RetroButtonStyle())
                    .padding()
            }
            
            Divider()
            
            ScrollView {
                ForEach(birthDateService.birthDates, id: \.self) { birthDate in
                    HStack {
                        let nameString = birthDate.name
                        let dateString = birthDate.birthDate.formatted()
                        
                        Button(action: {
                            viewModel.setSelectedBirthDate(birthDateObject: birthDate)
                            self.presentationMode.wrappedValue.dismiss()
                        }, label: {
                            HStack {
                                RetroView(type: .text(nameString + ": " + dateString),size: 14)
                                    .fixedSize(horizontal: false, vertical: false)
                            }
                        }).buttonStyle(RetroButtonStyle())
                            .padding()
                        
                        Spacer()
                        
                        if isEdited {
                            Button(action: {
                                withAnimation {
                                    viewModel.removeBirthDate(date: birthDate)
                                }
                            }, label: {
                                HStack {
                                    RetroView(type: .image("xmark"),size: 14, color: .red)
                                        .fixedSize()
                                }
                            }).buttonStyle(RetroButtonStyle())
                                .padding()
                        }
                    }
                }
            }
            Spacer()
        }
        .sheet(isPresented: $isAddDateSheetPresented, content: {
            AddDateView(isPresented: $isAddDateSheetPresented)
                .presentationDetents([.medium])
        })
    }
}

#Preview {
    BottomSheetView()
}
