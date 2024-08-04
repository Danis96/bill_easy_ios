//
//  SignInView.swift
//  BillTracker
//
//  Created by Danis Preldzic on 4. 8. 2024..
//

import SwiftUI
import GoogleSignInSwift

struct SignInView: View {
    
    @State private var textEmailString: String = ""
    @State private var textPassString: String = ""
    @State private var togglePassword: Bool = true
    
    var body: some View {
        VStack() {
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
            ButtonWideReusable(buttonTitle: "Login", iconTrailing: "arrow.right",  buttonWidth: 350) {
                
            }
            spacerHeight(height: 25)
            socialMediaTextDivider
            VStack {
                googleSignInButtonView
                appleSignInButtonView
            }
            .padding(.horizontal)
            Spacer()
        }
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
            Text("Login")
                .font(.largeTitle)
                .bold()
            Text("Welcome back!")
        }
    }
    
    private var toolbarItemNavigationSignUpView: some View {
        NavigationLink {
            Text("Sign Up")
        } label: {
            Text("Sign Up")
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundStyle(.black)
        }
    }
    
    private var textFieldEmailView: some View {
        TextFieldReusable(textBinding: $textEmailString, showIconOverlay: .constant(false), hintText: "Email")
    }
    
    private var textFieldPasswordView: some View {
        TextFieldPasswordReusable(textBinding: $textPassString, isSecure: $togglePassword, hintText: "Password")
    }
    
    private func spacerHeight(height: Double) -> some View {
        Rectangle()
            .frame(height: height)
            .foregroundStyle(.windowBackground)
    }
    
    private var forgotPasswordComponentView: some View {
        NavigationLink {
            Text("Forgot Password")
        } label: {
            Text("Forgot Password")
                .font(.subheadline)
                .foregroundStyle(.gray)
                .underline()
        }
    }
    
    private var socialMediaTextDivider: some View {
        Text("or login with social account")
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
    NavigationStack {
        SignInView()
    }
}
