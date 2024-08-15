//
//  SettingsItemModel.swift
//  BillTracker
//
//  Created by Danis Preldzic on 13. 8. 2024..
//

import Foundation
import SwiftUI

struct SettingsItemModel: Identifiable {
    
    var id: String = UUID().uuidString
    var itemTitle: String
    var itemSubtitle: String?
    var imageName: String
    var isSwitch: Bool
    var onArrowPressed: () -> Void
    
    init(id: String = UUID().uuidString, itemTitle: String, itemSubtitle: String?, imageName: String, isSwitch: Bool, onArrowPressed: @escaping () -> Void) {
        self.id = id
        self.itemTitle = itemTitle
        self.itemSubtitle = itemSubtitle
        self.imageName = imageName
        self.isSwitch = isSwitch
        self.onArrowPressed = onArrowPressed

    }
    
}
