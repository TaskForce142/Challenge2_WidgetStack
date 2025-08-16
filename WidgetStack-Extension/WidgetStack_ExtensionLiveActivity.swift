//
//  WidgetStack_ExtensionLiveActivity.swift
//  WidgetStack-Extension
//
//  Created by Chan Yap Long on 16/8/25.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct WidgetStack_ExtensionAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct WidgetStack_ExtensionLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: WidgetStack_ExtensionAttributes.self) { context in
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

extension WidgetStack_ExtensionAttributes {
    fileprivate static var preview: WidgetStack_ExtensionAttributes {
        WidgetStack_ExtensionAttributes(name: "World")
    }
}

extension WidgetStack_ExtensionAttributes.ContentState {
    fileprivate static var smiley: WidgetStack_ExtensionAttributes.ContentState {
        WidgetStack_ExtensionAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: WidgetStack_ExtensionAttributes.ContentState {
         WidgetStack_ExtensionAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: WidgetStack_ExtensionAttributes.preview) {
   WidgetStack_ExtensionLiveActivity()
} contentStates: {
    WidgetStack_ExtensionAttributes.ContentState.smiley
    WidgetStack_ExtensionAttributes.ContentState.starEyes
}
