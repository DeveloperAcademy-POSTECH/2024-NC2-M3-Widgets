//
//  PAWSApp.swift
//  PAWS
//
//  Created by kimjihee on 6/17/24.
//

import SwiftUI

@main
struct PAWSApp: App {
    @StateObject private var dataModel = AppDataModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(dataModel)
                .onAppear() {
                    dataModel.point = 100
                }
        }
    }
}
