//
//  BottomSheetView.swift
//  AgeCalculator
//
//  Created by Hakan Or on 8.02.2024.
//

import SwiftUI

struct BottomSheetView: View {
    @StateObject private var viewModel = BottomSheetViewModel()
    @State private var isAddDateSheetPresented = false
    @State private var isEdited : Bool = false
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    isAddDateSheetPresented = true
                }, label: {
                    RetroView(type: .image("plus"), size: 14, color: ThemeColors.success)
                        .fixedSize()
                }).buttonStyle(RetroButtonStyle())
                    .padding()
                
                Text("\(BirthDateService.shared.birthDateCount -  BirthDateService.shared.getBirthDates().count) remaining.")
                
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
                ForEach(viewModel.birthDates, id: \.self) { birthDate in
                    
                    HStack {
                        let nameString = birthDate.name
                        let dateString = birthDate.birthDate.formatted()
                        let object = BirthDateObject(birthDate: birthDate.birthDate, name: nameString)
                        
                        Button(action: {
                            BirthDateService.shared.setSelectedBirthDate(object)
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
                                    BirthDateService.shared.removeFromBirthDates(birthDate)
                                    if birthDate.birthDate == BirthDateService.shared.selectedBirthDate!.birthDate {
                                        BirthDateService.shared.removeSelectedBirthDate()
                                    }
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
        .onAppear {
            viewModel.loadBirthDates()
        }
    }
}

struct AddDateView: View {
    @Binding var isPresented: Bool
    @State private var selectedDate = Date()
    @State private var name: String = ""
    @State private var deletedBirthDate: BirthDateObject? // Ekledik
    
    var body: some View {
        VStack {
            DatePicker("", selection: $selectedDate,  displayedComponents: .date)
                .datePickerStyle(.wheel)
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .labelsHidden()
            
            RetroView(type: .textField($name, "Enter Name for This BirthDate"))
                .fixedSize(horizontal: false, vertical: true)
                .padding(24)
            
            Button(action: {
                let object = BirthDateObject(birthDate: selectedDate, name: name)
                BirthDateService.shared.setSelectedBirthDate(object)
                let birthDateObject = BirthDateObject(birthDate: selectedDate, name: name)
                BirthDateService.shared.appendToBirthDateArray(birthDateObject)
                isPresented = false
            }, label: {
                RetroView(type: .text("Add"),size: 20)
                    .fixedSize()
            })
            .buttonStyle(RetroButtonStyle())
            .padding()
        }
    }
}

#Preview {
    BottomSheetView()
}
