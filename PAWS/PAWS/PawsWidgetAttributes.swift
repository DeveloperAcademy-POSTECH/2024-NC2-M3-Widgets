//
//  PawsWidgetAttributes.swift
//  PAWS
//
//  Created by kimjihee on 6/17/24.
//

import ActivityKit

struct PawsWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}
