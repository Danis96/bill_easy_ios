//
//  BillTrackerApp.swift
//  BillTracker
//
//  Created by Danis Preldzic on 19. 7. 2024..
//

import SwiftUI
import FirebaseCore
import SwiftfulRouting

@main
struct BillTrackerApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    // MARK: View Models Registration
    @StateObject private var authenticationVM = AuthenticationViewModel()
    @StateObject private var onboardingVM = OnboardingViewModel()
    @StateObject private var settingsVM = SettingsViewModel()
    
    var body: some Scene {
        WindowGroup {
            RouterView { _ in
               RootView()
            }
            .environmentObject(authenticationVM)
            .environmentObject(onboardingVM)
            .environmentObject(settingsVM)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        print("Configured firebase!")
        return true
    }
}
