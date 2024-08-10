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
    
    var body: some View {
        ZStack {
            if authenticationVM.userAuthenticated {
                HomeView()
            } else {
                SignInView()
            }
        }.onAppear {
            let user = try? AuthenticationManager().getAuthenticatedUser()
            authenticationVM.userAuthenticated = user != nil
        }
    }
}

#Preview {
        RouterView { router in
         RootView()
            .environmentObject(AuthenticationViewModel())
    }
}
