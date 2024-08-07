//
//  SignUpView.swift
//  BillTracker
//
//  Created by Danis Preldzic on 5. 8. 2024..
//

import SwiftUI
import GoogleSignInSwift
import SwiftfulRouting

struct SignUpView: View {
    
    @EnvironmentObject var authenticationVM: AuthenticationViewModel
    @Environment(\.router) var router
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                spacerHeight(height: 40, foregroundStyle: nil)
                headlineView
                Rectangle()
                    .frame(height: 30)
                    .foregroundStyle(.windowBackground)
                VStack(alignment: .trailing, spacing: 10) {
                    textFieldEmailView
                    textFieldPasswordView
                }
            }
            .padding(.horizontal, 20)
            spacerHeight(height: 20, foregroundStyle: nil)
            HStack {
                Spacer()
                anonymousButton
                ButtonWideReusable(buttonTitle: TextLocalizationUtility.reg_button_title, iconTrailing: "arrow.right",  buttonWidth: 300) {
                   await signUpEmailPassword()
                }
            }
            spacerHeight(height: 25, foregroundStyle: nil)
            socialMediaTextDivider
            VStack {
                googleSignInButtonView
                appleSignInButtonView
            }
            .padding(.horizontal, 20)
            Spacer()
            termsAndConditions
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                toolbarItemNavigationSignUpView
            }
        }
    }
}


extension SignUpView {
    private var headlineView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(TextLocalizationUtility.reg_headline)
                .font(.largeTitle)
                .bold()
            Text(TextLocalizationUtility.reg_subheadline)
        }
    }
    
    private var toolbarItemNavigationSignUpView: some View {
        Button(action: {
            router.showScreen(.push) { _ in
                RouteGenerator.shared.getRoute(route: .SignIn)
            }
        }, label: {
            Text(TextLocalizationUtility.reg_toolbar_trailing)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundStyle(.black)
        })
    }
    
    private var textFieldEmailView: some View {
        TextFieldReusable(textBinding: $authenticationVM.email, showIconOverlay: .constant(false), hintText: TextLocalizationUtility.reg_email_hint)
    }
    
    private var textFieldPasswordView: some View {
        TextFieldPasswordReusable(textBinding: $authenticationVM.password, isSecure: $authenticationVM.togglePassword, hintText: TextLocalizationUtility.reg_password_hint)
    }
    
    private var socialMediaTextDivider: some View {
        Text(TextLocalizationUtility.reg_social_account)
            .font(.subheadline)
    }
    
    private var googleSignInButtonView: some View {
        GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .dark, style: .wide, state: .normal)) {
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
    
    private var anonymousButton: some View {
        Button(action: {
            Task {
                do {
                    try await authenticationVM.signInWithAnonymous()
                    router.showScreen(.push) { _ in
                        RouteGenerator.shared.getRoute(route: .Success)
                    }
                } catch {
                    print(error)
                }
            }
        }, label: {
            Image(systemName: "person.fill.and.arrow.left.and.arrow.right")
                .foregroundStyle(.white)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.black)
                        .frame(width: 50, height: 50)
                }
        })
        .padding(.horizontal, 25)
    }
    
    private var termsAndConditions: some View {
        Text(TextLocalizationUtility.reg_terms)
            .padding(.horizontal, 25)
            .font(.subheadline)
            .multilineTextAlignment(.center)
    }
}

extension SignUpView {
    private func signUpEmailPassword() async {
        Task {
            do {
                var error: String? = try await authenticationVM.signUp()
                
                if let error = error {
                    router.showBasicAlert(text: error)
                } else {
                    router.showScreen(.push) { _ in
                        RouteGenerator.shared.getRoute(route: .Success)
                    }
                }
            } catch {
               print("Catch Sign Up View")
            }
        }
    }
}

#Preview {
    RouterView { _ in
        SignUpView()
            .environmentObject(AuthenticationViewModel())
    }
}
