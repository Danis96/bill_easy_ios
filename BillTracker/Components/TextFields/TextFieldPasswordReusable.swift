//
//  TextFieldPasswordReusable.swift
//  BillTracker
//
//  Created by Danis Preldzic on 4. 8. 2024..
//

import SwiftUI

struct TextFieldPasswordReusable: View {
    
    @Binding var textBinding: String
    @Binding var isSecure: Bool
    var hintText: String
    
    var body: some View {
        HStack {
            if isSecure {
                SecureField(hintText, text: $textBinding)
                    .frame(height: 50)
                    .padding(.horizontal)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
            } else {
                TextField(hintText, text: $textBinding)
                    .frame(height: 50)
                    .padding(.horizontal)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                
            }
        }
        .overlay(
            showPasswordOverlay
        )
        
    }
}

extension TextFieldPasswordReusable {
    private var showPasswordOverlay: some View {
        HStack {
            Spacer()
            Button(action: {
                isSecure.toggle()
            }) {
                Image(systemName: self.isSecure ? "eye.slash" : "eye")
                    .foregroundColor(.gray)
            }
            .padding(.trailing, 10)
        }
    }
}

#Preview {
    TextFieldPasswordReusable(textBinding: .constant(""), isSecure: .constant(true), hintText: "Password Hint")
}
