//
//  LiveActivityManager.swift
//  PAWS
//
//  Created by kimjihee on 6/17/24.
//

import Foundation
import ActivityKit

@available(iOS 16.1, *)
@objc class LiveActivityManager: NSObject {
    private var activity: Activity<PawsWidgetAttributes>?

    // Singleton instance
    @objc static let shared = LiveActivityManager()
    
    private override init() {
        super.init()
    }
    
    // Method to start Live Activity
    @objc func onLiveActivity() {
        guard ActivityAuthorizationInfo().areActivitiesEnabled else {
            print("Live Activities are not enabled.")
            return
        }
        
        // Static attributes initialization
        let attributes = PawsWidgetAttributes(name: "name")
        
        // Load initial selected items from UserDefaults or data model
        let initialSelectedItems = loadSelectedItems()
        
        // Dynamic state initialization
        let initialState = PawsWidgetAttributes.ContentState(selectedItems: initialSelectedItems)
        
        do {
            // Request live activity
            activity = try Activity.request(attributes: attributes, contentState: initialState)
            print("Live activity started successfully.")
        } catch {
            print("Failed to start live activity: \(error)")
        }
    }
    
    // Method to end Live Activity
    @objc func offLiveActivity() {
        Task {
            await activity?.end(using: nil, dismissalPolicy: .immediate)
            print("Live activity ended.")
        }
    }
    
    // Method to update Live Activity
    @objc func updateLiveActivity(selectedItemsJSON: String) {
        Task {
            guard let data = selectedItemsJSON.data(using: .utf8) else {
                print("Invalid JSON string.")
                return
            }
            
            let decoder = JSONDecoder()
            guard let selectedItems = try? decoder.decode([Item].self, from: data) else {
                print("Failed to decode JSON string.")
                return
            }
            
            let newState = PawsWidgetAttributes.ContentState(selectedItems: selectedItems)
            do {
                try await activity?.update(using: newState)
                print("Live activity updated with new selected items.")
            } catch {
                print("Failed to update live activity: \(error)")
            }
        }
    }
    
    // Helper method to load selected items from UserDefaults or data model
    private func loadSelectedItems() -> [Item] {
        // Implement loading logic here, similar to the existing data model
        // For example:
        // return AppDataModel().items.filter { $0.isSelected }
        return []
    }
}
