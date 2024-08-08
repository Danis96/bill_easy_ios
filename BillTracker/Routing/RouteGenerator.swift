//
//  RouteGenerator.swift
//  BillTracker
//
//  Created by Danis Preldzic on 7. 8. 2024..
//

import Foundation
import SwiftUI

enum Routes {
    case Welcome
    case SignIn
    case SignUp
    case Success
    case Home
    case Onboarding
    case ForgotPassword
}

class RouteGenerator {
    
    static let shared = RouteGenerator()
    init() {}
    
    func getRoute(route: Routes) -> some View {
        switch route {
            case .Welcome:
                return AnyView(Text("Welcome View"))
            case .SignIn:
                return AnyView(SignInView())
            case .SignUp:
                return AnyView(SignUpView())
            case .Success:
                return AnyView(SuccessView())
            case .Home:
                return AnyView(HomeView())
            case .Onboarding:
                return AnyView(OnboardingView())
            case .ForgotPassword:
                return AnyView(ForgotPasswordView())
        }
    }
}
