//
//  RadioButtonReusable.swift
//  BillTracker
//
//  Created by Danis Preldzic on 7. 8. 2024..
//

import SwiftUI

struct RadioButtonReusable: View {
    
    @Binding var selectedGender: Gender?
    var gender: Gender
    
    var body: some View {
        Button(action: {
            selectedGender = gender
        }) {
            HStack {
                Image(systemName: selectedGender == gender ? "largecircle.fill.circle" : "circle")
                Text(gender.rawValue)
                    .font(.caption)
            }
            .foregroundColor(selectedGender == gender ? .blue : .gray)
            .padding(.horizontal)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    RadioButtonReusable(selectedGender: .constant(.male), gender: .female)
}
