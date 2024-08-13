//
//  SettingsViewModel.swift
//  BillTracker
//
//  Created by Danis Preldzic on 13. 8. 2024..
//

import Foundation

class SettingsViewModel: ObservableObject {
    
    @Published var isDarkMode: Bool = false
    @Published var notificationOn: Bool = false
    
}
