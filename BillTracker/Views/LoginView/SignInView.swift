//
//  SignInView.swift
//  BillTracker
//
//  Created by Danis Preldzic on 4. 8. 2024..
//

import SwiftUI

struct SignInView: View {
    
    @State private var textEmailString: String = ""
    @State private var textPassString: String = ""
    @State private var togglePassword: Bool = true
    
    var body: some View {
        VStack(alignment: .leading) {
            Rectangle()
                .frame(height: 50)
                .foregroundStyle(.windowBackground)
            headlineView
            Rectangle()
                .frame(height: 30)
                .foregroundStyle(.windowBackground)
            VStack(spacing: 20) {
                textFieldEmailView
                textFieldPasswordView
            }
            Spacer()
        }
        .padding(.horizontal, 20)
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
            
        } label: {
            Text("Sign Up")
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundStyle(.black)
        }
    }
    
    private var textFieldEmailView: some View {
        TextFieldReusable(textBinding: $textEmailString, hintText: "Email")
    }

    private var textFieldPasswordView: some View {
        TextFieldPasswordReusable(textBinding: $textPassString, isSecure: $togglePassword, hintText: "Password")
    }
}

#Preview {
    NavigationStack {
        SignInView()
    }
}
