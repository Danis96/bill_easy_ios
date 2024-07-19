//
//  PreviewProvider.swift
//  BillTracker
//
//  Created by Danis Preldzic on 19. 7. 2024..
//

import Foundation
import SwiftUI


extension Preview {
    
    static var dev: DeveloperPreview {
        return DeveloperPreview.instance
    }
    
}

@MainActor
class DeveloperPreview {
    
    static let instance = DeveloperPreview()
    
    // lazy initializations is ensuring that it is tunning on the main thread
//    private(set) lazy var tabsViewModel: TabViewModel = {
//        TabViewModel()
//    }()
    

    private init() { }
    
}

