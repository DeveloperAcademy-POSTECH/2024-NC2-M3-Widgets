//
//  PawsWidget.swift
//  PawsWidget
//
//  Created by kimjihee on 6/18/24.
//

import WidgetKit
import SwiftUI
import SharedDataModel
import AppIntents

struct Provider: AppIntentTimelineProvider {
    let dataModel = AppDataModel()
    
    func placeholder(in context: Context) -> SimpleEntry {
        let selectedItems = loadSelectedItems()
        return SimpleEntry(date: Date(), configuration: ConfigurationAppIntent(), selectedItems: selectedItems)
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        let selectedItems = loadSelectedItems()
        return SimpleEntry(date: Date(), configuration: configuration, selectedItems: selectedItems)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        let currentDate = Date()
        let selectedItems = loadSelectedItems()
        let entry = SimpleEntry(date: currentDate, configuration: configuration, selectedItems: selectedItems)
        
        let nextUpdateDate = Calendar.current.date(byAdding: .second, value: 1, to: currentDate)!
        
        return Timeline(entries: [entry], policy: .after(nextUpdateDate))
    }

    private func loadSelectedItems() -> [Item] {
        guard let data = dataModel.userDefaults.data(forKey: "selectedItems") else { return [] }
        let decoder = JSONDecoder()
        if let decodedItems = try? decoder.decode([Item].self, from: data) {
            return decodedItems
        }
        return []
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
    let selectedItems: [Item]
}

struct PawsWidgetEntryView : View {
    var entry: Provider.Entry
    
    let widgetWidth: CGFloat = 160
    let widgetHeight: CGFloat = 160
    let contentWidth: CGFloat = 370
    let contentHeight: CGFloat = 370

    var body: some View {
        ZStack {
            
            ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
                room(selectedItems: entry.selectedItems)
                Button(intent: IncrementPointIntent()){
                    Circle()
                        .foregroundColor(Color.white.opacity(0.4))
                        .frame(height: 40)
                        .overlay {
                            Image(systemName: "pawprint.fill")
                                .font(.headline)
                                .foregroundColor(Color.primarycolor)
                        }
                }
                .padding(10)
                
            }
            
        }
    }
    
    private func room(selectedItems: [Item]) -> some View {
        ZStack {
            if let item = selectedItems.first(where: { $0.type == .backgroundSeat }) {
                Image(item.imageName)
                    .resizable()
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .frame(width: widgetWidth, height: widgetHeight)
            }
            
            if let item = selectedItems.first(where: { $0.type == .characterBody }) {
                Image(item.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200 * widgetWidth / contentWidth, height: 200 * widgetHeight / contentHeight)
                    .offset(x: 10 * widgetWidth / contentWidth, y: 50 * widgetHeight / contentHeight)
            }
                
            if let item = selectedItems.first(where: { $0.type == .characterAccessoryHead }) {
                Image(item.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60 * widgetWidth / contentWidth)
                    .offset(x: 7 * widgetWidth / contentWidth, y: -25 * widgetHeight / contentHeight)
            }
            
            if let item = selectedItems.first(where: { $0.type == .characterAccessoryFace }) {
                Image(item.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100 * widgetWidth / contentWidth, height: 100 * widgetHeight / contentHeight)
                    .offset(x: 10 * widgetWidth / contentWidth, y: 30 * widgetHeight / contentHeight)
            }
                    
            if let item = selectedItems.first(where: { $0.type == .interiorLeftSeat }) {
                Image(item.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80 * widgetWidth / contentWidth)
                    .offset(x: -100 * widgetWidth / contentWidth, y: 105 * widgetHeight / contentHeight)
            }
                    
            if let item = selectedItems.first(where: { $0.type == .interiorTopSeat }) {
                Image(item.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 140 * widgetWidth / contentWidth)
                    .offset(x: 0, y: -100 * widgetHeight / contentHeight)
            }
        }
        .frame(width: widgetWidth, height: widgetHeight)
    }
}

struct PawsWidget: Widget {
    let kind: String = "PawsWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            PawsWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("Paws Widget")
        .description("This is a Paws widget.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

struct IncrementPointIntent: AppIntent {
    static var title: LocalizedStringResource = "Increment Point"

    func perform() async throws -> some IntentResult {
        let userDefaults = UserDefaults(suiteName: "group.com.iOSDevJoy.PAWS") // UserDefaults 그룹명을 정확히 입력하세요.
        let currentPoint = userDefaults?.integer(forKey: "point") ?? 0
        let newPoint = currentPoint + 1
        userDefaults?.set(newPoint, forKey: "point")
        WidgetCenter.shared.reloadAllTimelines()
        print("sssnew : \(newPoint)")
        return .result()
    }
}

