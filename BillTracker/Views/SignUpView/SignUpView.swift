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
    
    @State private var textEmailString: String = ""
    @State private var textPassString: String = ""
    @State private var togglePassword: Bool = true
    
    @Environment(\.router) var router
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                spacerHeight(height: 40)
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
            spacerHeight(height: 20)
            ButtonWideReusable(buttonTitle: "Join BillTracker!", iconTrailing: "arrow.right",  buttonWidth: 350) {
               
            }
            spacerHeight(height: 25)
            socialMediaTextDivider
            VStack {
                googleSignInButtonView
                appleSignInButtonView
            }
            .padding(.horizontal, 20)
            Spacer()
        }
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
            Text("Sign Up")
                .font(.largeTitle)
                .bold()
            Text("Welcome to BillTracker!")
        }
    }
    
    private var toolbarItemNavigationSignUpView: some View {
       
        Button(action: {
            router.showScreen(.push) { _ in
                SignInView()
            }
        }, label: {
            Text("Login")
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundStyle(.black)
        })
        
//        NavigationLink {
//           
//        } label: {
//            
//        }
    }
    
    private var textFieldEmailView: some View {
        TextFieldReusable(textBinding: $textEmailString, showIconOverlay: .constant(false), hintText: TextLocalizationUtility.login_email_hint)
    }
    
    private var textFieldPasswordView: some View {
        TextFieldPasswordReusable(textBinding: $textPassString, isSecure: $togglePassword, hintText: TextLocalizationUtility.login_password_hint)
    }
    
    private var forgotPasswordComponentView: some View {
        NavigationLink {
            Text("Forgot password")
        } label: {
            Text(TextLocalizationUtility.login_forgot_password)
                .font(.subheadline)
                .foregroundStyle(.gray)
                .underline()
        }
    }
    
    private var socialMediaTextDivider: some View {
        Text("or sign up with social account")
            .font(.subheadline)
    }
    
    private var googleSignInButtonView: some View {
        GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .dark, style: .wide, state: .normal)) {
            //            Task {
            //                do {
            //
            //                } catch {
            //                    print(error)
            //                }
            //            }
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

#Preview {
    RouterView { _ in
        SignUpView()
    }
}
