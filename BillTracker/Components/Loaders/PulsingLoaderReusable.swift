//
//  LoaderReusable.swift
//  BillTracker
//
//  Created by Danis Preldzic on 9. 8. 2024..
//

import SwiftUI

struct PulsingLoaderView: View {
    
    @State var scale: CGFloat = 1.0
    @State var color: Color = .pink
     
    var body: some View {
        Circle()
            .fill(color)
            .frame(width: 50, height: 50)
            .scaleEffect(scale)
            .onAppear {
                withAnimation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                    self.scale = 1.5
                }
            }
    }
}

#Preview {
    PulsingLoaderView(scale: 1.0, color: .pink)
}
