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
    
    @objc static let shared = LiveActivityManager()
    private init(activity: Activity<PawsWidgetAttributes>? = nil) {
        self.activity = activity
    }
    
    @objc func onLiveActivity() {
        guard ActivityAuthorizationInfo().areActivitiesEnabled else { return }
        
        // 정적 프로퍼티 초기화
        let attribute = PawsWidgetAttributes(name: "name")
        
        // 동적 프로퍼티 기본값 초기화
        let state = PawsWidgetAttributes.ContentState(emoji: "emoji")
        
        do {
            // live activity 시작
            self.activity = try Activity.request(attributes: attribute, contentState: state)
        } catch {
            print(error)
        }
    }
    
    @objc func offLiveActivity() {
        Task {
            await activity?.end(using: nil, dismissalPolicy: .immediate)
        }
    }
    
    @objc func updateLiveActivity(emoji: String) {
        Task {
            let newState = PawsWidgetAttributes.ContentState(emoji: emoji)
            await self.activity?.update(using: newState)
        }
    }
}
