//
//  SettingsViewModel.swift
//  BillTracker
//
//  Created by Danis Preldzic on 13. 8. 2024..
//

import Foundation

@MainActor
class SettingsViewModel: ObservableObject {
    
    @Published private(set) var user: DBUser? = nil
    @Published var isDarkMode: Bool = false
    @Published var notificationOn: Bool = false
    
    func loadCurrentUser() async throws {
        do {
            let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
            self.user = try await UserManager.instance.getUser(userID: authDataResult.uuid)
        } catch {
            throw error
        }
    }
    
    func isUserAnonymous() -> Bool {
        guard let userCurrent = user else { return false }
        return userCurrent.isAnonymous ?? false
    }
    
}
