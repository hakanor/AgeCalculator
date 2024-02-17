//
//  BottomSheetView.swift
//  AgeCalculator
//
//  Created by Hakan Or on 8.02.2024.
//

import SwiftUI

struct BottomSheetView: View {
    @State private var birthDates: [Date] = []
    @State private var isAddDateSheetPresented = false
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(birthDates, id: \.self) { birthDate in
                Button(action: {
                    BirthDateService.shared.setSelectedBirthDate(birthDate)
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    RetroView(type: .text(birthDate.formatted()),size: 10)
                        .frame(width: 100,height: 50)
                }).buttonStyle(RetroButtonStyle())
                    .padding()
            }
            Button(action: {
                isAddDateSheetPresented = true
            }, label: {
                RetroView(type: .text("Add date"), size: 10)
                    .frame(width: 100, height: 50)
            }).buttonStyle(RetroButtonStyle())
            .padding()
        }
        .sheet(isPresented: $isAddDateSheetPresented, content: {
            AddDateView(isPresented: $isAddDateSheetPresented)
        })
        .onAppear {
            loadBirthDates()
        }
    }
    private func loadBirthDates() {
        let birthDateObjects = BirthDateService.shared.birthDates
        for birthDate in birthDateObjects {
            self.birthDates.append(birthDate.birthDate)
        }
    }
}

struct AddDateView: View {
    @Binding var isPresented: Bool
    @State private var selectedDate = Date()
    
    var body: some View {
        VStack {
            DatePicker("Select a date", selection: $selectedDate, in: ...Date(), displayedComponents: .date)
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding()
            Button(action: {
                BirthDateService.shared.setSelectedBirthDate(selectedDate)
                BirthDateService.shared.appendToBirthDateArray(selectedDate)
                isPresented = false
            }, label: {
                Text("Add")
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue))
                    .foregroundColor(.white)
            })
            .padding()
            
            Spacer()
        }
    }
}

#Preview {
    BottomSheetView()
}
