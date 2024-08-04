//
//  TextFieldReusable.swift
//  BillTracker
//
//  Created by Danis Preldzic on 4. 8. 2024..
//

import SwiftUI

struct TextFieldReusable: View {
    
    @Binding var textBinding: String
    var hintText: String
    
    var body: some View {
        TextField(hintText, text: $textBinding)
            .frame(height: 50)
            .padding(.horizontal)
            .background(Color(.systemGray6))
            .cornerRadius(10)
    }
}

#Preview {
    TextFieldReusable(textBinding: .constant(""), hintText: "Hint text")
}
