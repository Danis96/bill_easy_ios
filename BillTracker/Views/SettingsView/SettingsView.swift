//
//  SettingsView.swift
//  BillTracker
//
//  Created by Danis Preldzic on 13. 8. 2024..
//

import SwiftUI
import SwiftfulRouting

struct SettingsView: View {
    
    @EnvironmentObject private var settingsVM: SettingsViewModel
    
    // MARK: Settings Section Lists
    
    var settingsAnonymousList: [SettingsItemModel] = [
        SettingsItemModel(itemTitle: "Anonymous", itemSubtitle: "Click here to link profile",
                          imageName: "settingsAnonymousIcon",
                          isSwitch: false,
                          onArrowPressed: {
                              print("Go to linking profile")
                          }
        )
    ]
    
    var settingsPersonalizationList: [SettingsItemModel] = [
        SettingsItemModel(itemTitle: "Language", itemSubtitle: "Set the app language", imageName: "settingsPasswordChangeIcon", isSwitch: false, onArrowPressed: {
            print("Go to app language")
        }),
        SettingsItemModel(itemTitle: "Edit info", itemSubtitle: "Change user info", imageName: "settingsProfileIcon", isSwitch: false, onArrowPressed: {
            print("Go to app edit info")
        }),
        SettingsItemModel(itemTitle: "Dark mode", itemSubtitle: "Choose a view mode", imageName: "settingsDarkMode", isSwitch: true, onArrowPressed: {})
    ]

    var settingsNotificationList: [SettingsItemModel] = [
        SettingsItemModel(itemTitle: "App Notifications", itemSubtitle: "Get push notifications", imageName: "settingsNotIcon", isSwitch: true, onArrowPressed: {
            print("Go to app language")
        }),
        SettingsItemModel(itemTitle: "Notification History", itemSubtitle: "See all notifications", imageName: "settingsNotHistoryIcon", isSwitch: false, onArrowPressed: {
            print("Go to notification history profile")
        })
    ]
    
    var body: some View {
        ScrollView {
            Divider()
            VStack(alignment: .leading) {
                spacerHeight(height: 20, foregroundStyle: nil)
                anonymousSection
                personalizationSection
                notificationSection
            }
        }
        .padding(20)
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

// MARK: Settings Section

extension SettingsView {
    
    private var anonymousSection: some View {
        Section("Anonymous Linking") {
            ForEach(settingsAnonymousList) { item in
                SettingsItemCard(
                    isSwitch: item.isSwitch, 
                    itemTitle: item.itemTitle,
                    itemSubtitle: item.itemSubtitle,
                    imageName: item.imageName,
                    onArrowPressed: item.onArrowPressed,
                    isToggleOn: .constant(false)
                )
                .padding(10)
            }
        }
    }
    
    private var personalizationSection: some View {
        Section("Personalization") {
            ForEach(settingsPersonalizationList) { item in
                SettingsItemCard(
                    isSwitch: item.isSwitch,
                    itemTitle: item.itemTitle,
                    itemSubtitle: item.itemSubtitle,
                    imageName: item.imageName,
                    onArrowPressed: item.onArrowPressed,
                    isToggleOn: $settingsVM.isDarkMode
                )
                .padding(10)
            }
        }
    }

    private var notificationSection: some View {
        Section("Notifications") {
            ForEach(settingsNotificationList) { item in
                SettingsItemCard(
                    isSwitch: item.isSwitch,
                    itemTitle: item.itemTitle,
                    itemSubtitle: item.itemSubtitle,
                    imageName: item.imageName,
                    onArrowPressed: item.onArrowPressed,
                    isToggleOn: $settingsVM.notificationOn
                )
                .padding(10)
            }
        }
    }
    
}

extension SettingsView {
    
}

#Preview {
    RouterView { _ in
        SettingsView()
            .environmentObject(SettingsViewModel())
    }
}
