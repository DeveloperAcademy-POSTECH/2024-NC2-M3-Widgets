//
//  IncrementPointIntent.swift
//  PAWS
//
//  Created by kimjihee on 6/20/24.
//

import AppIntents
import WidgetKit

struct IncrementPointIntent: AppIntent {
    static var title: LocalizedStringResource = "Increment Point"

    func perform() async throws -> some IntentResult {
        let userDefaults = UserDefaults(suiteName: "group.com.yourAppGroup") // UserDefaults 그룹명을 정확히 입력하세요.
        let currentPoint = userDefaults?.integer(forKey: "point") ?? 0
        let newPoint = currentPoint + 1
        userDefaults?.set(newPoint, forKey: "point")
        WidgetCenter.shared.reloadAllTimelines()
        return .result()
    }
}
