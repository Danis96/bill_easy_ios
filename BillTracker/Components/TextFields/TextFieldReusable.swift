//
//  TextFieldReusable.swift
//  BillTracker
//
//  Created by Danis Preldzic on 4. 8. 2024..
//

import SwiftUI

struct TextFieldReusable: View {
    
    @Binding var textBinding: String
    @Binding var showIconOverlay: Bool
    var hintText: String
    var iconString: String? = ""
    var textCase: UIKeyboardType = .emailAddress
    
    var body: some View {
        TextField(hintText, text: $textBinding)
            .textInputAutocapitalization(.never)
            .keyboardType(textCase)
            .textCase(.lowercase)
            .frame(height: 50)
            .padding(.horizontal)
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .overlay(
                showOverlay
            )
    }
}

extension TextFieldReusable {
    private var showOverlay: some View {
        HStack {
            Spacer()
            if showIconOverlay {
                if let icon = iconString {
                    Image(systemName: icon)
                        .foregroundColor(.gray)
                }
            }
        }.padding(.trailing, 10)
    }
}

#Preview {
    TextFieldReusable(
        textBinding: .constant(""),
        showIconOverlay: .constant(false),
        hintText: "Hint text",
        iconString: "eye.slash"
    )
}
