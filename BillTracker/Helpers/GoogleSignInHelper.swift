//
//  GoogleSignInHelper.swift
//  BillTracker
//
//  Created by Danis Preldzic on 19. 7. 2024..
//

import Foundation
import GoogleSignIn
import GoogleSignInSwift

struct GoogleSignInResultModel {
    
    let idToken: String?
    let accessToken: String?
    let name: String?
    let email: String?
    
}

@MainActor
final class SignInGoogleHelper {
    
    func signIn() async throws -> GoogleSignInResultModel {
        guard let topVC = Utilities.shared.topViewController() else {
            throw URLError(.cannotFindHost)
        }
        
        let GIDResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)
        
        guard let userIDToken = GIDResult.user.idToken?.tokenString else {
            throw URLError(.serverCertificateHasBadDate)
        }
        
        let accessToken = GIDResult.user.accessToken.tokenString
        let name = GIDResult.user.profile?.name
        let email = GIDResult.user.profile?.email
        
        
        let tokens = GoogleSignInResultModel(idToken: userIDToken, accessToken: accessToken, name: name, email: email)
        return tokens
    }
    
}
