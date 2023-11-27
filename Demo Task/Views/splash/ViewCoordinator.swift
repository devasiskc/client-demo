//
//  ViewCoordinator.swift
//  Demo Task
//
//  Created by Devasis KC on 26/11/2023.
//

import SwiftUI

struct ViewCoordinator: View {
    @State private var isActive = false
    
    var body: some View {
        if isActive {
            ContentView()
        } else {
            SplashScreen(isActive: $isActive)
        }
        
    }
}

#Preview {
    ViewCoordinator()
}
