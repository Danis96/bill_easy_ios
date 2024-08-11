//
//  OnboardingViewModel.swift
//  BillTracker
//
//  Created by Danis Preldzic on 7. 8. 2024..
//

import Foundation
import SwiftUI

@MainActor
final class OnboardingViewModel: ObservableObject {
    
    @Published private(set) var user: DBUser? = nil
    @Published var isLoading: Bool = false
    
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
        do {
            let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
            self.user = try await UserManager.instance.getUser(userID: authDataResult.uuid)
        } catch {
            print(error)
        }
        
    }
    
    func setUserOnboardingData() async -> String? {
        do {
           let value = try await loadCurrentUser()
        } catch {
            return error.localizedDescription
        }
        if checkMandatoryData() {
            await collectUserData()
            guard let user = user else { return "No user found" }
            Task {
                try await UserManager.instance.updateUserData(user: user)
                self.user = try await UserManager.instance.getUser(userID: user.userId)
            }
            resetFields()
            return nil
        } else {
            return "Mandatory fields cannot be empty!"
        }
        
    }
    
    func collectUserData() async {
        guard let userValue = user else { return }
        self.user = userValue.updateOnboardingData(addressValue: address, fnValue: firstName, lnValue: lastName, stateValue: state, zipValue: zip, cityValue: city, dobValue: dob, genderValue: selectedGender?.rawValue ?? "")
        print("Finished: ")
        print("User: \(self.user ?? DBUser(userID: "Failed"))")
    }
    
    func setLoading(value: Bool) {
        withAnimation {
            self.isLoading = value
        }
    }
    
    func checkMandatoryData() -> Bool {
        return !firstName.isEmpty && !lastName.isEmpty && !address.isEmpty && selectedGender != nil && dob != Date.now
    }
    
    func setAnonymousToExpire() async throws{
        guard let userValue = user else { return }
        self.user = userValue.updateAnonymous()
        guard let user = user else { return }
        do {
            try await UserManager.instance.updateUserData(user: user)
            self.user = try await UserManager.instance.getUser(userID: user.userId)
        } catch {
            throw StringError.custom("Anonymous expire: \(error.localizedDescription)")
        }
    }
    
    func resetFields() {
        firstName = ""
        lastName = ""
        address = ""
        selectedGender = nil
        dob = Date.now
        state = ""
        city = ""
        zip = ""
    }
}
