//
//  Color.swift
//  PAWS
//
//  Created by kimjihee on 6/19/24.
//

import Foundation
import SwiftUI

struct BackgroundColor: Identifiable {
    var id = UUID().uuidString
    var name: Color
    var isHaving: Bool
    var isSelected: Bool
}

let sampleBackgroundColors: [BackgroundColor] = [
    BackgroundColor(name: Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1)), isHaving: true, isSelected: false),
    BackgroundColor(name: Color(red: 204/255, green: 213/255, blue: 174/255), isHaving: true, isSelected: false)
]
