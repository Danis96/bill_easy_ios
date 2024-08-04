//
//  ButtonWideReusable.swift
//  BillTracker
//
//  Created by Danis Preldzic on 4. 8. 2024..
//

import SwiftUI

struct ButtonWideReusable: View {
    
    let buttonTitle: String
    var iconTrailing: String?
    var buttonWidth: Double = 200
    var onTapPressed: () async -> Void
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                Task {
                    await onTapPressed()
                }
            }, label: {
                HStack{
                    Text(buttonTitle)
                    Spacer()
                    if let icon = iconTrailing {
                        Image(systemName: icon)
                    }
                }
                .padding(.horizontal)
                .foregroundStyle(.black)
                .frame(width: buttonWidth, height: 50)
                .background(Color.yellow)
                .clipShape(RoundedCornersCustom(tl: 10, tr: 0, bl: 10, br: 0))
            })
        }
    }
}

#Preview {
    ButtonWideReusable(buttonTitle: "Login", iconTrailing: "arrow.right") {
        
    }
}
