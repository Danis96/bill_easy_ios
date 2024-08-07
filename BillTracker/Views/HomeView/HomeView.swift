//
//  HomeView.swift
//  BillTracker
//
//  Created by Danis Preldzic on 6. 8. 2024..
//

import SwiftUI
import SwiftfulRouting

struct HomeView: View {
    
    @EnvironmentObject var authenticationVM: AuthenticationViewModel
    @Environment(\.router) var router
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        List {
            Button(action: {
                Task {
                    try authenticationVM.signOut()
                    router.showScreen(.push) { _ in
                        SignInView()
                    }
                }
            }, label: {
                Text("Sign out")
            })
            
            ForEach(authenticationVM.authProviders, id: \.self ) { provider in
                Text(provider.rawValue)
            }
            
            
            if authenticationVM.authUser?.isAnonimous == true {
                linkSection
            }
            
        }
        .onAppear {
            authenticationVM.loadAuthProviders()
            authenticationVM.loadAuthUser()
            if authenticationVM.authUser?.isAnonimous == true {
                router.showResizableSheet(
                    sheetDetents: [.medium, .large],
                    selection: nil,
                    showDragIndicator: true) { _ in
                        anonymousModalWarning
                    }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

extension HomeView {
    
    private var textFieldEmailView: some View {
        TextFieldReusable(textBinding: $authenticationVM.email, showIconOverlay: .constant(false), hintText: TextLocalizationUtility.login_email_hint)
    }
    
    private var textFieldPasswordView: some View {
        TextFieldPasswordReusable(textBinding: $authenticationVM.password, isSecure: $authenticationVM.togglePassword, hintText: TextLocalizationUtility.login_password_hint)
    }
    
    private var anonymousModalWarning: some View {
        ZStack {
            Color.yellow.ignoresSafeArea()
            VStack {
                Image("transaction")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                spacerHeight(height: 0, foregroundStyle: .init(.yellow))
                Text("Anonymous?")
                    .font(.title)
                spacerHeight(height: 0, foregroundStyle: .init(.yellow))
                Text("You are signed in as anonymous user.\nTo be able to track and sort your bills you need to link your anonymous account or create a new user with your credentials.")
                    .multilineTextAlignment(.center)
                spacerHeight(height: 0, foregroundStyle: .init(.yellow))
                Spacer()
            }
            .padding(.vertical, 30)
            .padding(.horizontal, 30)
            
        }
    }
    
    private var linkSection: some View {
        Section("Create account") {
            Button(action: {
                Task {
                    do {
                        try await authenticationVM.linkGoogle()
                    } catch {
                        print("Error \(error)")
                    }
                }
            }, label: {
                Text("Link Google Account")
            })
            
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
            })
            
            VStack {
                textFieldEmailView
                textFieldPasswordView
                Button(action: {
                    Task {
                        do {
                            try await authenticationVM.linkEmail()
                        } catch {
                            print("Error \(error)")
                        }
                    }
                }, label: {
                    Text("Link Email Account")
                }).buttonStyle(.bordered)
            }
        }
    }
}

#Preview {
    RouterView { _ in
        SuccessView()
            .environmentObject(AuthenticationViewModel())
    }
}


#Preview {
    HomeView()
}
