//
//  AddDateView.swift
//  AgeCalculator
//
//  Created by Hakan Or on 24.02.2024.
//

import SwiftUI

struct AddDateView: View {
    @Binding var isPresented: Bool
    @State private var selectedDate = Date()
    @State private var name: String = ""
    
    @StateObject var viewModel = AddDateViewModel()
    
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
                viewModel.addBirthDate(name: name, selectedDate: selectedDate)
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
    AddDateView(isPresented: .constant(true))
}

