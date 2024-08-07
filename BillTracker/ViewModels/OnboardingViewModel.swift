//
//  OnboardingViewModel.swift
//  BillTracker
//
//  Created by Danis Preldzic on 7. 8. 2024..
//

import Foundation


@MainActor
final class OnboardingViewModel: ObservableObject {
    
    @Published private(set) var user: DBUser? = nil
    
    // Text Fields "Controllers"
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var address: String = ""
    @Published var selectedGender: Gender?
    @Published var dob: Date = Date()
    @Published var state: String = ""
    @Published var city: String = ""
    @Published var zip: String = ""
    
    func loadCurrentUser() async throws {
        let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
        self.user = try await UserManager.instance.getUser(userID: authDataResult.uuid)
    }
    
    func setUserOnboardingData() -> String? {
        guard let user = user else { return "No user found" }
        if checkMandatoryData() {
            Task {
                await collectUserData()
                try await UserManager.instance.updateUserData(userID: user.userId, user: user)
                self.user = try await UserManager.instance.getUser(userID: user.userId)
            }
            return nil
        } else {
            return "Mandatory fields cannot be empty!"
        }
        
    }
    
    func collectUserData() async {
        guard var user = user else { return }
        user.address = address
        user.firstName = firstName
        user.lastName = lastName
        user.finishedOnboarding = true
        user.gender = selectedGender?.rawValue ?? Gender.male.rawValue
        user.dob = dob
        user.city = city
        user.state = state
        user.zipCode = zip
    }
    
    func checkMandatoryData() -> Bool {
        return !firstName.isEmpty && !lastName.isEmpty && !address.isEmpty && selectedGender != nil && dob != Date.now
    }
    
    
}
