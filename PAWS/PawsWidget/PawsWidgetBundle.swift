//
//  PawsWidgetBundle.swift
//  PawsWidget
//
//  Created by kimjihee on 6/17/24.
//

import WidgetKit
import SwiftUI

@main
struct PawsWidgetBundle: WidgetBundle {
    var body: some Widget {
        PawsWidget()
        PawsWidgetLiveActivity()
    }
}
