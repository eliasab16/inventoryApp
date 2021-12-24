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
    
//    init() {
//        FirebaseApp.configure()
//    }
    
    // an application delegate adapter is held in appDelegate instance
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @StateObject var model = ViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(model)
                .environment(\.colorScheme, .light)
                .environment(\.layoutDirection, .rightToLeft)
        }
    }
}


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        
        return true
    }
}
