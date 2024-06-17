//
//  PawsWidgetLiveActivity.swift
//  PawsWidget
//
//  Created by kimjihee on 6/17/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct PawsWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct PawsWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: PawsWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension PawsWidgetAttributes {
    fileprivate static var preview: PawsWidgetAttributes {
        PawsWidgetAttributes(name: "World")
    }
}

extension PawsWidgetAttributes.ContentState {
    fileprivate static var smiley: PawsWidgetAttributes.ContentState {
        PawsWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: PawsWidgetAttributes.ContentState {
         PawsWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: PawsWidgetAttributes.preview) {
   PawsWidgetLiveActivity()
} contentStates: {
    PawsWidgetAttributes.ContentState.smiley
    PawsWidgetAttributes.ContentState.starEyes
}
