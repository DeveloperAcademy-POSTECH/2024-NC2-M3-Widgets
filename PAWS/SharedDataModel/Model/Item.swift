//
//  SwiftUIView.swift
//  PAWS
//
//  Created by kimjihee on 6/19/24.
//

import Foundation

enum ItemType: String, Codable {
    case characterBody
    case characterAccessoryHead
    case characterAccessoryFace
    case interiorLeftSeat
    case interiorTopSeat
    case backgroundSeat
}

struct Item: Identifiable, Codable, Hashable {
    var id = UUID().uuidString
    let imageName: String
//    var imageURL: URL
    var isHaving: Bool
    let type: ItemType
    var isSelected: Bool
    var price: Int
    
    func toJSON() -> String? {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(self) {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
}

let sampleItems: [Item] = [
    Item(imageName: "body01", isHaving: true, type: .characterBody, isSelected: true, price: 0),
    Item(imageName: "body02", isHaving: true, type: .characterBody, isSelected: false, price: 0),
    
    Item(imageName: "leftSeat01", isHaving: false, type: .interiorLeftSeat, isSelected: false, price: 5),
    Item(imageName: "leftSeat02", isHaving: false, type: .interiorLeftSeat, isSelected: false, price: 12),
    Item(imageName: "leftSeat03", isHaving: false, type: .interiorLeftSeat, isSelected: false, price: 12),
    Item(imageName: "leftSeat04", isHaving: false, type: .interiorLeftSeat, isSelected: false, price: 28),
    
    Item(imageName: "topSeat01", isHaving: false, type: .interiorTopSeat, isSelected: false, price: 20),
    Item(imageName: "topSeat02", isHaving: false, type: .interiorTopSeat, isSelected: false, price: 12),
    Item(imageName: "topSeat03", isHaving: false, type: .interiorTopSeat, isSelected: false, price: 12),
    Item(imageName: "topSeat04", isHaving: false, type: .interiorTopSeat, isSelected: false, price: 12),
    Item(imageName: "topSeat05", isHaving: false, type: .interiorTopSeat, isSelected: false, price: 12),
    
    Item(imageName: "accessoryFace01", isHaving: false, type: .characterAccessoryFace, isSelected: false, price: 14),
    Item(imageName: "accessoryFace02", isHaving: false, type: .characterAccessoryFace, isSelected: false, price: 14),
    Item(imageName: "accessoryFace03", isHaving: false, type: .characterAccessoryFace, isSelected: false, price: 14),
    Item(imageName: "accessoryFace04", isHaving: false, type: .characterAccessoryFace, isSelected: false, price: 14),
    
    Item(imageName: "accessoryHead00", isHaving: false, type: .characterAccessoryHead, isSelected: false, price: 99),
    Item(imageName: "accessoryHead01", isHaving: false, type: .characterAccessoryHead, isSelected: false, price: 60),
    Item(imageName: "accessoryHead02", isHaving: false, type: .characterAccessoryHead, isSelected: false, price: 10),
    Item(imageName: "accessoryHead03", isHaving: false, type: .characterAccessoryHead, isSelected: false, price: 10),
    Item(imageName: "accessoryHead04", isHaving: false, type: .characterAccessoryHead, isSelected: false, price: 10),
    Item(imageName: "accessoryHead05", isHaving: false, type: .characterAccessoryHead, isSelected: false, price: 10),
    
    Item(imageName: "background00", isHaving: true, type: .backgroundSeat, isSelected: false, price: 0),
    Item(imageName: "background01", isHaving: false, type: .backgroundSeat, isSelected: false, price: 5),
    Item(imageName: "background02", isHaving: false, type: .backgroundSeat, isSelected: false, price: 5),
    Item(imageName: "background03", isHaving: false, type: .backgroundSeat, isSelected: false, price: 18),
    Item(imageName: "background04", isHaving: false, type: .backgroundSeat, isSelected: false, price: 18),
    Item(imageName: "background05", isHaving: false, type: .backgroundSeat, isSelected: false, price: 18),
    Item(imageName: "background06", isHaving: false, type: .backgroundSeat, isSelected: false, price: 18),
    Item(imageName: "background07", isHaving: false, type: .backgroundSeat, isSelected: false, price: 20),
    Item(imageName: "background08", isHaving: false, type: .backgroundSeat, isSelected: false, price: 20),
    Item(imageName: "background09", isHaving: false, type: .backgroundSeat, isSelected: false, price: 20),
    Item(imageName: "background10", isHaving: false, type: .backgroundSeat, isSelected: false, price: 20),
    Item(imageName: "background11", isHaving: false, type: .backgroundSeat, isSelected: false, price: 32),
    Item(imageName: "background12", isHaving: false, type: .backgroundSeat, isSelected: false, price: 32),
    Item(imageName: "background13", isHaving: false, type: .backgroundSeat, isSelected: false, price: 32),
    Item(imageName: "background14", isHaving: false, type: .backgroundSeat, isSelected: false, price: 32),
    Item(imageName: "background15", isHaving: false, type: .backgroundSeat, isSelected: false, price: 34),
    Item(imageName: "background16", isHaving: false, type: .backgroundSeat, isSelected: false, price: 34),
    Item(imageName: "background17", isHaving: false, type: .backgroundSeat, isSelected: false, price: 34),
    Item(imageName: "background18", isHaving: false, type: .backgroundSeat, isSelected: false, price: 34)
]


