//
//  WelcomeView.swift
//  BillTracker
//
//  Created by Danis Preldzic on 19. 7. 2024..
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        getStartedView
    }
}

extension WelcomeView {
    private var getStartedView: some View {
        NavigationLink {
            SignInView()
        } label: {
            Text("Go to login")
        }
    }
}

#Preview {
    WelcomeView()
}
