//
//  SignInView.swift
//  BillTracker
//
//  Created by Danis Preldzic on 4. 8. 2024..
//

import SwiftUI
import GoogleSignInSwift
import SwiftfulRouting

struct SignInView: View {
    
    @EnvironmentObject var authenticationVM: AuthenticationViewModel
    @EnvironmentObject var onboardingVM: OnboardingViewModel
    @Environment(\.router) var router
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                headlineView
                Rectangle()
                    .frame(height: 30)
                    .foregroundStyle(.windowBackground)
                VStack(alignment: .trailing, spacing: 10) {
                    textFieldEmailView
                    forgotPasswordComponentView
                    textFieldPasswordView
                }
            }
            .padding(.horizontal, 20)
            spacerHeight(height: 20, foregroundStyle: nil)
            ButtonWideReusable(buttonTitle: TextLocalizationUtility.login_button_title, iconTrailing: "arrow.right",  buttonWidth: 350) {
                await signInEmailPassword()
            }
            spacerHeight(height: 25, foregroundStyle: nil)
            socialMediaTextDivider
            VStack {
                googleSignInButtonView
                appleSignInButtonView
            }
            .padding(.horizontal, 20)
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle(TextLocalizationUtility.login_headline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                toolbarItemNavigationSignUpView
            }
        }
    }
}


extension SignInView {
    private var headlineView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(TextLocalizationUtility.login_subheadline)
        }
    }
    
    private var toolbarItemNavigationSignUpView: some View {
        Button(action: {
            router.showScreen(.push) { _ in
                RouteGenerator.shared.getRoute(route: .SignUp)
            }
        }, label: {
            Text(TextLocalizationUtility.login_toolbar_trailing)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundStyle(.black)
        })
    }
    
    private var textFieldEmailView: some View {
        TextFieldReusable(textBinding: $authenticationVM.email, showIconOverlay: .constant(false), hintText: TextLocalizationUtility.login_email_hint)
    }
    
    private var textFieldPasswordView: some View {
        TextFieldPasswordReusable(textBinding: $authenticationVM.password, isSecure: $authenticationVM.togglePassword, hintText: TextLocalizationUtility.login_password_hint)
    }
    
    private var forgotPasswordComponentView: some View {
        Button(action: {
            router.showScreen(.push) { _ in
                RouteGenerator.shared.getRoute(route: .ForgotPassword)
            }
        }, label: {
            Text(TextLocalizationUtility.login_forgot_password)
                .font(.subheadline)
                .foregroundStyle(.gray)
                .underline()
        })
    }
    
    private var socialMediaTextDivider: some View {
        Text(TextLocalizationUtility.login_social_account)
            .font(.subheadline)
    }
    
    private var googleSignInButtonView: some View {
        GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .dark, style: .wide, state: .normal))  {
            Task {
                do {
                    try await authenticationVM.signInGoogle()
                    router.showScreen(.push) { _ in
                        RouteGenerator.shared.getRoute(route: .Success)
                    }
                } catch {
                    print(error)
                }
            }
        }
    }
    
    private var appleSignInButtonView: some View {
        Button(action: {
            //            Task {
            //                do {
            //
            //                } catch {
            //                    print(error)
            //                }
            //            }
        }, label: {
            SignInWithAppleButtonViewRepresentable(type: .signIn, style: .black)
                .allowsHitTesting(false)
        })
        .frame(height: 44)
    }
}

extension SignInView {
    private func signInEmailPassword() async {
        Task {
            do {
                let error: String? = try await authenticationVM.signIn()
                if let error = error {
                    router.showBasicAlert(text: error)
                } else {
                    try await onboardingVM.loadCurrentUser()
                    if onboardingVM.user?.finishedOnboarding == true {
                        router.showScreen(.push) { _ in
                            RouteGenerator.shared.getRoute(route: .Success)
                        }
                    } else {
                        router.showScreen(.push) { _ in
                            RouteGenerator.shared.getRoute(route: .Welcome)
                        }
                    }
                }
            } catch {
                print("Catch Sign Up View: \(error)")
            }
        }
    }
    
}

#Preview {
    RouterView { _ in
        SignInView()
            .environmentObject(AuthenticationViewModel())
            .environmentObject(OnboardingViewModel())
    }
}
