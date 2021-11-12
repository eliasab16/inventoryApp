//
//  inventoryAppApp.swift
//  inventoryApp
//
//  Created by Elias Abunuwara on 2021-11-06.
//

import SwiftUI
import Firebase

@main
struct inventoryAppApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    @StateObject var model = ViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(model)
                .environment(\.colorScheme, .light)
            
        }
    }
}
