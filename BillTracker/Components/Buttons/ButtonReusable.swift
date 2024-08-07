//
//  ButtonReusable.swift
//  BillTracker
//
//  Created by Danis Preldzic on 6. 8. 2024..
//

import SwiftUI

struct ButtonReusable: View {
    
    let buttonTitle: String
    var iconTrailing: String?
    var buttonWidth: Double = 140
    var onTapPressed: () async -> Void
    
    var body: some View {
        Button(action: {
            Task {
                await onTapPressed()
            }
        }, label: {
            Text(buttonTitle)
                .padding(.horizontal)
                .foregroundStyle(.black)
                .fontWeight(.semibold)
                .frame(width: buttonWidth, height: 50)
                .background(Color.yellow)
                .clipShape(RoundedCornersCustom(tl: 10, tr: 10, bl: 10, br: 10))
        })
    }
}

#Preview {
    ButtonReusable(buttonTitle: "Login", iconTrailing: "arrow.right") {
    }
}
