//
//  ExpandableContainerView.swift
//  BillTracker
//
//  Created by Danis Preldzic on 15. 8. 2024..
//

import SwiftUI

struct ExpandableContainerView: View {
    @State private var isExpanded = false
    var passedView: AnyView
    var containerTitle: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(containerTitle)
                    .font(.headline)
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        isExpanded.toggle()
                    }
                }) {
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundColor(.blue)
                        .rotationEffect(.degrees(isExpanded ? 180 : 0))
                        .animation(.easeInOut, value: isExpanded)
                }
            }
            
            if isExpanded {
                    passedView
                    .font(.body)
                    .transition(AnyTransition.opacity.combined(with: .move(edge: .leading)))
            }
        }
        .padding()
        .background(Color(.yellow))
        .cornerRadius(10)
        .shadow(radius: 1)
    }
}

#Preview {
    ExpandableContainerView(passedView: AnyView(Text("DanisDanis")), containerTitle: "Expandable")
}
