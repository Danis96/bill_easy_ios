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
    @EnvironmentObject private var authenticationVM: AuthenticationViewModel
    @Environment(\.router) var router
    
    var body: some View {
        ScrollView {
            Divider()
            VStack(alignment: .leading) {
                spacerHeight(height: 20, foregroundStyle: nil)
                if settingsVM.isUserAnonymous() {
                    anonymousSection
                }
                personalizationSection
                notificationSection
                userManagementSection
            }
        }
        .padding(20)
        .navigationTitle(TextLocalizationUtility.st_headline)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            Task {
                await loadUser()
            }
        }
        
    }
    
    private func getSettingsAnonymousList() -> [SettingsItemModel] {
        return [
            SettingsItemModel(itemTitle: TextLocalizationUtility.st_anonymous_title, itemSubtitle: TextLocalizationUtility.st_anonymous_subtitle,
                              imageName: "settingsAnonymousIcon",
                              isSwitch: false,
                              onArrowPressed: {
                                  router.showScreen(.push) { _ in
                                      RouteGenerator.shared.getRoute(route: .AnonymousLinking)
                                  }
                              }
                             )
        ]
    }
    
    private func getSettingsPersonalizationList() -> [SettingsItemModel] {
        return [
            SettingsItemModel(itemTitle: TextLocalizationUtility.st_pers_lang_title, itemSubtitle: TextLocalizationUtility.st_pers_lang_subtitle, imageName: "settingsPasswordChangeIcon", isSwitch: false, onArrowPressed: {
                print("Go to app language")
            }),
            SettingsItemModel(itemTitle: TextLocalizationUtility.st_pers_edit_title, itemSubtitle: TextLocalizationUtility.st_pers_edit_subtitle, imageName: "settingsProfileIcon", isSwitch: false, onArrowPressed: {
                print("Go to app edit info")
            }),
            SettingsItemModel(itemTitle: TextLocalizationUtility.st_pers_dark_title, itemSubtitle: TextLocalizationUtility.st_pers_dark_subtitle, imageName: "settingsDarkMode", isSwitch: true, onArrowPressed: {})
        ]
    }
    
    private func getSettingsNotificationList() -> [SettingsItemModel] {
        return [
            SettingsItemModel(itemTitle: TextLocalizationUtility.st_not_app_title, itemSubtitle: TextLocalizationUtility.st_not_app_subtitle, imageName: "settingsNotIcon", isSwitch: true, onArrowPressed: {
                print("Go to app language")
            }),
            SettingsItemModel(itemTitle: TextLocalizationUtility.st_not_his_title, itemSubtitle: TextLocalizationUtility.st_not_his_subtitle, imageName: "settingsNotHistoryIcon", isSwitch: false, onArrowPressed: {
                print("Go to notification history profile")
            })
        ]
    }
    
    private func getSettingsUserManagementList() -> [SettingsItemModel] {
        return [
            SettingsItemModel(itemTitle: "Sign out", itemSubtitle: nil, imageName: "settingsSignOut", isSwitch: false, onArrowPressed: {
                print("Open sign out modal")
                
                Task {
                    try authenticationVM.signOut()
                    router.showScreen(.push) { _ in
                        SignInView()
                    }
                }
                
            }),
            SettingsItemModel(itemTitle: "Delete user", itemSubtitle: nil, imageName: "settingsDeleteUser", isSwitch: false, onArrowPressed: {
                print("Open delete user modal")
                Task {
                    try await authenticationVM.deleteUser()
                    router.showScreen(.push) { _ in
                        SignInView()
                    }
                }
            })
        ]
    }
}

// MARK: Settings Section

extension SettingsView {
    
    
    private var anonymousSection: some View {
        Section(TextLocalizationUtility.st_anonymous_section) {
            ForEach(getSettingsAnonymousList()) { item in
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
        Section(TextLocalizationUtility.st_pers_section) {
            ForEach(getSettingsPersonalizationList()) { item in
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
        Section(TextLocalizationUtility.st_not_section) {
            ForEach(getSettingsNotificationList()) { item in
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
    
    private var userManagementSection: some View {
        Section("User Management") {
            ForEach(getSettingsUserManagementList()) { item in
                SettingsItemCard(
                    isSwitch: item.isSwitch,
                    hasIcon: false, itemTitle: item.itemTitle,
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
    private func loadUser() async {
        do {
            try await settingsVM.loadCurrentUser()
        } catch {
            router.showBasicAlert(text: error.localizedDescription)
        }
    }
    
    
}

#Preview {
    RouterView { _ in
        SettingsView()
            .environmentObject(SettingsViewModel())
    }
}
