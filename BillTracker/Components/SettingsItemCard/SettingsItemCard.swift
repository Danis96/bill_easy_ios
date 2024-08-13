//
//  SettingsItemCard.swift
//  BillTracker
//
//  Created by Danis Preldzic on 13. 8. 2024..
//

import SwiftUI

struct SettingsItemCard: View {
    
    var isSwitch: Bool = false
    var itemTitle: String
    var itemSubtitle: String
    var onArrowPressed: () -> Void
    @Binding var isToggleOn: Bool
    
    var body: some View {
        RoundedRectangle(cornerRadius: 14)
            .fill(.white)
            .frame(maxWidth: .infinity, maxHeight: 80)
            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
            .overlay {
                cardOverlayBody
            }
    }
}

extension SettingsItemCard {
    
    private var cardOverlayBody: some View {
        HStack {
            HStack {
                imageSection
                headlineSection
            }
            Spacer()
            if isSwitch {
                switchView
            } else {
                arrowTappable
            }
        }.padding()
    }
    
    private var imageSection: some View {
        Image("settingsPasswordChangeIcon")
    }
    
    private var headlineSection: some View {
        VStack(alignment: .leading) {
            Text(itemTitle)
                .font(.headline)
            Spacer()
            Text(itemSubtitle)
                .font(.subheadline)
                .foregroundStyle(.black.opacity(0.7))
        }
    }
    
    private var arrowTappable: some View {
        Image(systemName: "arrow.right")
            .foregroundStyle(.blue)
            .onTapGesture {
                onArrowPressed()
            }
    }
    
    private var switchView: some View {
        Toggle(isOn: $isToggleOn) {}
            .tint(.yellow)
            .frame(width: 10)
            .toggleStyle(SwitchToggleStyle())
            .padding()
    }
    
}

#Preview {
    SettingsItemCard(
        isSwitch: false,
        itemTitle: "Change password",
        itemSubtitle: "Go and change your password",
        onArrowPressed: {
            print("On arrow pressed")
        },
        isToggleOn: .constant(true)
    )
    .padding()
}
