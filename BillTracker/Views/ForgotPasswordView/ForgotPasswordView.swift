//
//  ForgotPasswordView.swift
//  BillTracker
//
//  Created by Danis Preldzic on 7. 8. 2024..
//

import SwiftUI
import SwiftfulRouting

struct ForgotPasswordView: View {
    
    @EnvironmentObject var authenticationVM: AuthenticationViewModel
    @Environment(\.router) var router
    
    var body: some View {
        VStack {
            if authenticationVM.isLoading {
                ProgressLoaderReusable()
            } else {
                headline
                spacerHeight(height: 30, foregroundStyle: nil)
                textFieldEmailView
                spacerHeight(height: 10, foregroundStyle: nil)
                buttonSendEmail
                Spacer()
            }
        }.navigationTitle("Forgot Password")
    }
}

extension ForgotPasswordView {
    
    private var headline: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(TextLocalizationUtility.fp_subheadline)
                .foregroundStyle(.black.opacity(0.7))
        }
    }
    
    private var textFieldEmailView: some View {
        TextFieldReusable(textBinding: $authenticationVM.email, showIconOverlay: .constant(false), hintText: TextLocalizationUtility.fp_email_hint)
            .padding(.horizontal)
    }
    
    private var buttonSendEmail: some View {
        ButtonWideReusable(buttonTitle: TextLocalizationUtility.fp_button_title, iconTrailing: "arrow.right", buttonWidth: 300) {
           sendResetPasswordEmail()
        }
    }
}

extension ForgotPasswordView {
    private func sendResetPasswordEmail() {
        authenticationVM.setLoading(value: true)
        Task {
            do {
                try await authenticationVM.resetPasswordRequest()
                authenticationVM.setLoading(value: false)
                router.showScreen(.push) { _ in
                    RouteGenerator.shared.getRoute(route: .SignIn)
                }
            } catch {
                router.showBasicAlert(text: error.localizedDescription)
                print("Error")
            }
        }
    }
}

#Preview {
    RouterView { _ in
        ForgotPasswordView()
            .environmentObject(AuthenticationViewModel())
    }
}
