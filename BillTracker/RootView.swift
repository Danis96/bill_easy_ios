//
//  RootView.swift
//  BillTracker
//
//  Created by Danis Preldzic on 6. 8. 2024..
//

import SwiftUI
import SwiftfulRouting

struct RootView: View {
    
    @EnvironmentObject var authenticationVM: AuthenticationViewModel
    @EnvironmentObject var onboardingVM: OnboardingViewModel
    
    var body: some View {
        ZStack {
            returnCorrespondingView()
        }.onAppear {
            onAppearFunc()
        }
    }
}

extension RootView {
    private func isUserAuthenticated() -> Bool {
        authenticationVM.userAuthenticated
    }

    private func isOnboardingSet() -> Bool {
        guard let user = onboardingVM.user else { return false }
        return user.finishedOnboarding ?? false
    }

    private func isAnonymous() -> Bool {
        guard let user = onboardingVM.user else { return false }
        return user.isAnonymous ?? false
    }
    
    // MARK: 1 - check authentication 2 - check anonymous 3 - check Onboarding
    private func returnCorrespondingView() -> AnyView {
        if isUserAuthenticated() {
            if isAnonymous() {
                AnyView(HomeView())
            } else {
                if isOnboardingSet() {
                    AnyView(HomeView())
                } else {
                    AnyView(OnboardingView())
                }
            }
        } else {
            AnyView(SignInView())
        }
    }
    
    private func onAppearFunc() {
        let user = try? AuthenticationManager().getAuthenticatedUser()
        authenticationVM.userAuthenticated = user != nil
        Task {
            do {
                try await onboardingVM.loadCurrentUser()
            } catch {
                print("Root catch: \(error)")
            }
        }
    }
}

#Preview {
        RouterView { router in
         RootView()
            .environmentObject(AuthenticationViewModel())
            .environmentObject(OnboardingViewModel())
    }
}
