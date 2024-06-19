//
//  PAWSApp.swift
//  PAWS
//
//  Created by kimjihee on 6/17/24.
//

import SwiftUI
import FirebaseCore
//import Firebase

@main
struct PAWSApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
//    init() {
//        FirebaseApp.configure()
//    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}
