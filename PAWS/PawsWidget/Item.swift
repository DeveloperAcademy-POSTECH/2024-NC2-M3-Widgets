//
//  Item.swift
//  PAWS
//
//  Created by kimjihee on 6/18/24.
//

import Foundation

enum ItemType: String, Codable {
    case characterBody
    case characterAccessoryHead
    case characterAccessoryFace
    case interiorLeftSeat
    case interiorTopSeat
}

struct Item: Identifiable, Codable {
    var id = UUID().uuidString
    let imageName: String
//    var imageURL: URL
    var isHaving: Bool
    let type: ItemType
    var isSelected: Bool
}

let sampleItems: [Item] = [
    Item(imageName: "body01", isHaving: true, type: .characterBody, isSelected: false),
    Item(imageName: "body02", isHaving: true, type: .characterBody, isSelected: false),
    
    Item(imageName: "leftSeat01", isHaving: true, type: .interiorLeftSeat, isSelected: false),
    Item(imageName: "leftSeat02", isHaving: true, type: .interiorLeftSeat, isSelected: false),
    Item(imageName: "leftSeat03", isHaving: true, type: .interiorLeftSeat, isSelected: false),
    Item(imageName: "leftSeat04", isHaving: true, type: .interiorLeftSeat, isSelected: false),
    
    Item(imageName: "topSeat01", isHaving: true, type: .interiorTopSeat, isSelected: false),
    Item(imageName: "topSeat02", isHaving: true, type: .interiorTopSeat, isSelected: false),
    Item(imageName: "topSeat03", isHaving: true, type: .interiorTopSeat, isSelected: false),
    Item(imageName: "topSeat04", isHaving: true, type: .interiorTopSeat, isSelected: false),
    Item(imageName: "topSeat05", isHaving: true, type: .interiorTopSeat, isSelected: false),
    
    Item(imageName: "accessoryFace01", isHaving: true, type: .characterAccessoryFace, isSelected: false),
    Item(imageName: "accessoryFace02", isHaving: true, type: .characterAccessoryFace, isSelected: false),
    Item(imageName: "accessoryFace03", isHaving: true, type: .characterAccessoryFace, isSelected: false),
    Item(imageName: "accessoryFace04", isHaving: true, type: .characterAccessoryFace, isSelected: false),
    
    Item(imageName: "accessoryHead01", isHaving: true, type: .characterAccessoryHead, isSelected: false),
    Item(imageName: "accessoryHead02", isHaving: true, type: .characterAccessoryHead, isSelected: false),
    Item(imageName: "accessoryHead03", isHaving: true, type: .characterAccessoryHead, isSelected: false),
    Item(imageName: "accessoryHead04", isHaving: true, type: .characterAccessoryHead, isSelected: false),
    Item(imageName: "accessoryHead05", isHaving: true, type: .characterAccessoryHead, isSelected: false)
]

