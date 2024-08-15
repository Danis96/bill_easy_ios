//
//  AnonymousLinkingView.swift
//  BillTracker
//
//  Created by Danis Preldzic on 15. 8. 2024..
//

import SwiftUI
import SwiftfulRouting

struct AnonymousLinkingView: View {
    
    @EnvironmentObject var authenticationVM: AuthenticationViewModel
    @EnvironmentObject var onboardingVM: OnboardingViewModel
    @Environment(\.router) var router
    
    var body: some View {
        VStack {
            ExpandableContainerView(passedView: AnyView(emailSection), containerTitle: "Email linking")
                .padding()
            List {
                linkSection
            }
        }
    }
}

extension AnonymousLinkingView {
    
    private var textFieldEmailView: some View {
        TextFieldReusable(textBinding: $authenticationVM.email, showIconOverlay: .constant(false), hintText: TextLocalizationUtility.login_email_hint)
    }
    
    private var textFieldPasswordView: some View {
        TextFieldPasswordReusable(textBinding: $authenticationVM.password, isSecure: $authenticationVM.togglePassword, hintText: TextLocalizationUtility.login_password_hint)
    }
    
    private var linkSection: some View {
        Section("or link with social media") {
            googleSection
            appleSection
        }
    }
    
    private var googleSection: some View {
        VStack(alignment: .leading) {
            Text("Link your anonymous profile with your Google account to seamlessly sync your data across devices.\nBy linking, you'll retain your anonymity while enjoying a more personalized and secure experience.")
            Button(action: {
                Task {
                    do {
                        try await authenticationVM.linkGoogle()
                        try await onboardingVM.setAnonymousToExpire()
                    } catch {
                        router.showBasicAlert(text: error.localizedDescription)
                    }
                }
            }, label: {
                Text("Link Google Account")
            }).buttonStyle(.bordered)
        }
    }

    private var appleSection: some View {
        VStack(alignment: .leading) {
            Text("Connect your anonymous profile with your Apple Sign-In for a seamless and secure experience across all your devices. By linking, you can maintain your privacy while benefiting from enhanced features and data synchronization.\nYour anonymity is preserved, and your personal information stays protected.")
            Button(action: {
                Task {
                    do {
                        try await authenticationVM.linkApple()
                    } catch {
                        print("Error \(error)")
                    }
                }
            }, label: {
                Text("Link Apple Account")
            }).buttonStyle(.bordered)
        }
    }

    private var emailSection: some View {
        VStack(alignment: .leading) {
            Text("Link your anonymous profile with your email and password to secure your data and access it from any device. This connection allows you to maintain your privacy while ensuring your information is backed up and easily recoverable. Your anonymity is respected, and your personal details remain confidential")
            VStack {
                textFieldEmailView
                textFieldPasswordView
                Button(action: {
                    Task {
                        do {
                            try await authenticationVM.linkEmail()
                            try await onboardingVM.setAnonymousToExpire()
                        } catch {
                            router.showBasicAlert(text: error.localizedDescription)
                        }
                    }
                }, label: {
                    Text("Link Email Account")
                }).buttonStyle(.borderedProminent)
            }
        }
    }
}

#Preview {
    RouterView { _ in
        AnonymousLinkingView()
            .environmentObject(AuthenticationViewModel())
            .environmentObject(OnboardingViewModel())
    }
}
