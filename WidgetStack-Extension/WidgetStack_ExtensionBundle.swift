//
//  WidgetStack_ExtensionBundle.swift
//  WidgetStack-Extension
//
//  Created by Chan Yap Long on 16/8/25.
//

import WidgetKit
import SwiftUI

@main
struct WidgetStack_ExtensionBundle: WidgetBundle {
    var body: some Widget {
        WidgetStack_Extension()
        WidgetStack_ExtensionControl()
        WidgetStack_ExtensionLiveActivity()
    }
}
