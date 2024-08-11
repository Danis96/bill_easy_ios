//
//  SuccessView.swift
//  BillTracker
//
//  Created by Danis Preldzic on 6. 8. 2024..
//

import SwiftUI
import SwiftfulRouting

struct SuccessView: View {
    
    @EnvironmentObject var authenticationVM: AuthenticationViewModel
    @Environment(\.router) var router
    
    var body: some View {
        VStack {
            spacerHeight(height: 120, foregroundStyle: nil)
            img
            headline
            spacerHeight(height: 10, foregroundStyle: nil)
            buttonContinue
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
    }
}

extension SuccessView {
    
    private var img: some View {
        Image("congratulation")
            .resizable()
            .scaledToFit()
            .frame(height: 180)
    }
    
    private var headline: some View {
        VStack {
            Text(TextLocalizationUtility.success_headline)
                .font(.title)
                .fontWeight(.semibold)
            spacerHeight(height: 0, foregroundStyle: nil)
            VStack{
                Text(TextLocalizationUtility.success_subheadline1)
                Text(TextLocalizationUtility.success_subheadline2)
            }
            .font(.headline)
            .foregroundStyle(.black.opacity(0.7))
        }
    }
    
    private var buttonContinue: some View {
        ButtonReusable(buttonTitle: TextLocalizationUtility.success_button) {
             checkAndNavigate()
        }
    }
}

extension SuccessView {
    private func checkAndNavigate() {
        authenticationVM.loadAuthUser()
        if authenticationVM.authUser?.isAnonimous == true {
            router.showScreen(.push) { _ in
                RouteGenerator.shared.getRoute(route: .Home)
            }
        } else {
            router.showScreen(.push) { _ in
                RouteGenerator.shared.getRoute(route: .Onboarding)
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
