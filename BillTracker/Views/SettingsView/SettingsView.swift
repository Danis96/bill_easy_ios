//
//  SettingsView.swift
//  BillTracker
//
//  Created by Danis Preldzic on 13. 8. 2024..
//

import SwiftUI
import SwiftfulRouting


struct SettingsView: View {
    var body: some View {
        ScrollView(.vertical) {
            Divider()
            SettingsItemCard(
                isSwitch: false,
                itemTitle: "Change Password",
                itemSubtitle: "Go and change your password",
                onArrowPressed: {
                
                },
                isToggleOn: .constant(false)
            )
        }
        .padding(.horizontal, 24)
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
    }
}

extension SettingsView {
    
}

#Preview {
    RouterView { _ in
        SettingsView()
    }
}
