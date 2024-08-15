//
//  SettingsItemCard.swift
//  BillTracker
//
//  Created by Danis Preldzic on 13. 8. 2024..
//

import SwiftUI

struct SettingsItemCard: View {
    
    var isSwitch: Bool = false
    var hasIcon: Bool = true
    var itemTitle: String
    var itemSubtitle: String?
    var imageName: String
    var onArrowPressed: () -> Void
    @Binding var isToggleOn: Bool
    
    var body: some View {
        RoundedRectangle(cornerRadius: 14)
            .fill(.white)
            .frame(maxWidth: .infinity, minHeight: 80, maxHeight: 80)
            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
            .overlay {
                cardOverlayBody
            }
            .onTapGesture {
                if isSwitch {
                    print("Is Switch")
                } else {
                    onArrowPressed()
                }
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
            if hasIcon {
                if isSwitch {
                    switchView
                } else {
                    arrowTappable
                }
            }
        }.padding()
    }
    
    private var imageSection: some View {
        Image(imageName)
            .resizable()
            .scaledToFit()
            .frame(maxWidth: 45, maxHeight: 50)
    }
    
    private var headlineSection: some View {
        VStack(alignment: .leading) {
            Text(itemTitle)
                .font(.headline)
            if let subtitle = itemSubtitle {
                Spacer()
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundStyle(.black.opacity(0.7))
            }  
        }
    }
    
    private var arrowTappable: some View {
        Image(systemName: "arrow.right")
            .foregroundStyle(.blue)
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
        isSwitch: true,
        itemTitle: "Change password",
        itemSubtitle: "Go and change your password",
        imageName: "settingsPasswordChangeIcon",
        onArrowPressed: {
            print("On arrow pressed")
        },
        isToggleOn: .constant(true)
    )
    .padding()
}
