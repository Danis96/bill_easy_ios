//
//  CircularLoaderReusable.swift
//  BillTracker
//
//  Created by Danis Preldzic on 9. 8. 2024..
//

import SwiftUI

struct CircularLoaderView: View {
    
    @Binding var isAnimating: Bool
    
    var body: some View {
        Circle()
            .trim(from: 0, to: 0.7)
            .stroke(Color.blue, lineWidth: 5)
            .frame(width: 50, height: 50)
            .rotationEffect(Angle(degrees: isAnimating ? 360 : 0))
            .onAppear {
                withAnimation(Animation.linear(duration: 1).repeatForever(autoreverses: false)) {
                    isAnimating = true
                }
            }
    }
}

#Preview {
    CircularLoaderView(isAnimating: .constant(false))
}
