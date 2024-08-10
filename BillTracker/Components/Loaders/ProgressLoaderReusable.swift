//
//  ProgressLoaderReusable.swift
//  BillTracker
//
//  Created by Danis Preldzic on 9. 8. 2024..
//

import SwiftUI

struct ProgressLoaderReusable: View {
    var body: some View {
        ProgressView("Loading...")
            .progressViewStyle(CircularProgressViewStyle())
            .padding()
    }
}

#Preview {
    ProgressLoaderReusable()
}
