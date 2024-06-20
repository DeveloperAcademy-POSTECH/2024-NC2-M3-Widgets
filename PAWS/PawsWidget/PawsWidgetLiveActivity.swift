//
//  PawsWidgetLiveActivity.swift
//  PawsWidget
//
//  Created by kimjihee on 6/18/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct PawsWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: PawsWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                room(selectedItems: context.state.selectedItems)
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here. Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
//                    Image(systemName: "timer.circle.fill")
//                        .resizable()
//                        .frame(width: 44.0, height: 44.0)
//                        .foregroundColor(Color.accentColor)
//                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
//                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
//                    Image("body01")
//                        .resizable()
//                        .clipShape(RoundedRectangle(cornerRadius: 16))
//                    room(selectedItems: context.state.selectedItems)
                }
            } compactLeading: {
                Text("🐶")
            } compactTrailing: {
                Circle()
                    .foregroundColor(Color.clear)
                    .frame(height: 24)
                    .overlay {
                        Image(systemName: "pawprint.fill")
                            .font(.headline)
                            .foregroundColor(Color.primarycolor)
                    }
                    .padding(3)
            } minimal: {
                Image(systemName: "pawprint.fill")
                    .font(.caption2)
                    .foregroundColor(Color.primarycolor)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }

    private func room(selectedItems: [Item]) -> some View {
        ZStack {
            if let item = selectedItems.first(where: { $0.type == .backgroundSeat }) {
                Image(item.imageName)
                    .resizable()
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            
            if let item = selectedItems.first(where: { $0.type == .characterBody }) {
                Image(item.imageName)
                    .resizable()
                    .scaledToFit()
                    .offset(x: 10, y: 50)
            }
                
            if let item = selectedItems.first(where: { $0.type == .characterAccessoryHead }) {
                Image(item.imageName)
                    .resizable()
                    .scaledToFit()
                    .offset(x: 7, y: -25)
            }
            
            if let item = selectedItems.first(where: { $0.type == .characterAccessoryFace }) {
                Image(item.imageName)
                    .resizable()
                    .scaledToFit()
                    .offset(x: 10, y: 30)
            }
                    
            if let item = selectedItems.first(where: { $0.type == .interiorLeftSeat }) {
                Image(item.imageName)
                    .resizable()
                    .scaledToFit()
                    .offset(x: -100, y: 105)
            }
                    
            if let item = selectedItems.first(where: { $0.type == .interiorTopSeat }) {
                Image(item.imageName)
                    .resizable()
                    .scaledToFit()
                    .offset(y: -100)
            }
        }
    }
}
