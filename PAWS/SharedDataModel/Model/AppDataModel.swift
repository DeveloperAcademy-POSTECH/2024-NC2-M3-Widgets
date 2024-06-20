//
//  Point.swift
//  PAWS
//
//  Created by kimjihee on 6/19/24.
//

import SwiftUI
import Combine
import WidgetKit

class AppDataModel: ObservableObject {
    public let userDefaults = UserDefaults(suiteName: "group.com.iOSDevJoy.PAWS")!
    
    @Published var point: Int {
        didSet {
            userDefaults.set(point, forKey: "point")
        }
    }
    
    @Published var items: [Item] = sampleItems {
        didSet {
            saveItems()
            saveSelectedItems()
            WidgetCenter.shared.reloadTimelines(ofKind: "PawsWidget")
            print("Widget timelines reloaded")
        }
    }
    
    init() {
        self.point = userDefaults.integer(forKey: "point")
        loadItems()
    }
    
    private func saveItems() {
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(items) {
            userDefaults.set(encodedData, forKey: "items")
        }
        WidgetCenter.shared.reloadTimelines(ofKind: "PawsWidget")
    }
    
    private func saveSelectedItems() {
            let selectedItems = items.filter { $0.isSelected }
            let encoder = JSONEncoder()
            if let encodedData = try? encoder.encode(selectedItems) {
                userDefaults.set(encodedData, forKey: "selectedItems")
            }
        }
    
    private func loadItems() {
        guard let data = userDefaults.data(forKey: "items") else { return }
        let decoder = JSONDecoder()
        if let decodedItems = try? decoder.decode([Item].self, from: data) {
            items = decodedItems
        }
    }
    
}
