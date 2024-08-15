//
//  AuthenticationViewModel.swift
//  BillTracker
//
//  Created by Danis Preldzic on 6. 8. 2024..
//

import Foundation
import SwiftUI

@MainActor
final class AuthenticationViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var togglePassword: Bool = true
    
    @Published var userAuthenticated: Bool = false
    
    @Published var authUser: AuthDataResultModel? = nil
    @Published var authProviders: [AuthProviderOption] = []
    
    @Published var isLoading: Bool = false
    
    func signUp() async throws {
        guard !email.isEmpty && !password.isEmpty else {
            print("No data added!")
            throw StringError.custom("Fields cannot be empty!")
            
        }
        let res =  try await AuthenticationManager().createUser(email: email,  password: password)
        let user = DBUser(auth: res)
        try await UserManager.instance.createNewUser(user: user)
        resetTextFields()
        print("Success")
    }
    
    func signIn() async throws  {
        guard !email.isEmpty && !password.isEmpty else {
            print("No data added!")
            throw StringError.custom("Fields cannot be empty!")
        }
        try await AuthenticationManager().signInUser(email: email,  password: password)
        resetTextFields()
        print("Success Sign in")
    }
    
    func signInGoogle() async throws {
        let helper = SignInGoogleHelper()
        let tokens = try await helper.signIn()
        let authDataResult = try await AuthenticationManager.shared.signInWithGoogle(tokens: tokens)
        let user = DBUser(auth: authDataResult)
        try await UserManager.instance.createNewUser(user: user)
    }
    
    func signInWithApple() async throws {
        let helper = AppleSignInHelper()
        let tokens = try await helper.startSignInWithAppleFlow()
        let authDataResult = try await AuthenticationManager.shared.signInWithApple(tokens: tokens)
        let user = DBUser(auth: authDataResult)
        try await UserManager.instance.createNewUser(user: user)
    }
    
    func resetPasswordRequest() async throws {
        try await AuthenticationManager.shared.resetPassword(for: email)
        resetTextFields()
    }
    
    func loadAuthProviders() {
        if let providers = try? AuthenticationManager.shared.getProvider() {
            authProviders = providers
        }
    }
    
    func loadAuthUser() {
        self.authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
    }

    func signOut() throws {
        try AuthenticationManager.shared.signOut()
        print("Success Sign out")
    }

    func deleteUser() async throws {
        try await AuthenticationManager.shared.deleteUser()
        print("Success Delete user")
    }
    
    private func resetTextFields() {
        self.email = ""
        self.password = ""
    }
    
    
    // MARK: Anonymous sign in
    func signInWithAnonymous() async throws {
        let res = try await AuthenticationManager.shared.signInAnonimous()
        let user = DBUser(auth: res)
        try await UserManager.instance.createNewUser(user: user)
    }
    
    // MARK: These fn needs to be called if user has authenticated anonymously first then these...
    func linkGoogle() async throws {
        let helper = SignInGoogleHelper()
        let tokens = try await helper.signIn()
        let dataResult = try await AuthenticationManager.shared.linkGoogle(tokens: tokens)
        self.authUser = dataResult
    }
    
    func linkApple() async throws {
        let helper = AppleSignInHelper()
        let tokens = try await helper.startSignInWithAppleFlow()
        let dataResult = try await AuthenticationManager.shared.linkApple(tokens: tokens)
        self.authUser = dataResult
    }
    
    func linkEmail() async throws {
        let dataResult = try await AuthenticationManager.shared.linkEmail(email: email, password: password)
        self.authUser = dataResult
    }
    
    func setLoading(value: Bool) {
        withAnimation {
            self.isLoading = value
        }
    }
}
