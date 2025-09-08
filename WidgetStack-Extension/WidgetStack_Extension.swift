//
//  WidgetStack_Extension.swift
//  WidgetStack-Extension
//
//  Created by Chan Yap Long on 16/8/25.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }

//    func relevances() async -> WidgetRelevances<ConfigurationAppIntent> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
}

struct WidgetStack_ExtensionEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        
        ZStack {
           
            Rectangle()
                .fill(loadBackgroundColor())
                
           
            if !loadWidgetText().isEmpty {
                Text(loadWidgetText())
                    .font(.system(size: CGFloat(loadTextSize() / 3))) // Scale down for widget
                    .foregroundColor(loadTextColor())
                    .multilineTextAlignment(.center)
                    .lineLimit(3)
                    .padding(0)
               
            } else {
                
                
            }
        }
        .widgetURL(URL(string: "challenge2://open"))
    }
    
    // ADDED: Helper functions to load shared data
    private func loadWidgetText() -> String {
        guard let sharedDefaults = UserDefaults(suiteName: "group.yourcompany.challenge2.widgets") else {
            return ""
        }
        return sharedDefaults.string(forKey: "savedWidgetText") ?? ""
    }
    
    private func loadTextSize() -> Double {
        guard let sharedDefaults = UserDefaults(suiteName: "group.yourcompany.challenge2.widgets") else {
            return 50
        }
        let size = sharedDefaults.double(forKey: "savedTextSize")
        return size == 0 ? 50 : size
    }
    
    private func loadTextColor() -> Color {
        guard let sharedDefaults = UserDefaults(suiteName: "group.yourcompany.challenge2.widgets"),
              let colorData = sharedDefaults.data(forKey: "savedTextColor"),
              let uiColor = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(colorData) as? UIColor else {
            return .black
        }
        return Color(uiColor)
    }
    
    private func loadBackgroundColor() -> Color {
        guard let sharedDefaults = UserDefaults(suiteName: "group.yourcompany.challenge2.widgets"),
              let bgColorData = sharedDefaults.data(forKey: "savedBGColor"),
              let uiBGColor = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(bgColorData) as? UIColor else {
            return .blue
        }
        return Color(uiBGColor)
    }
}

struct WidgetStack_Extension: Widget {
    let kind: String = "WidgetStack_Extension"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            WidgetStack_ExtensionEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
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

#Preview(as: .systemSmall) {
    WidgetStack_Extension()
} timeline: {
    SimpleEntry(date: .now, configuration: .smiley)
    SimpleEntry(date: .now, configuration: .starEyes)
}
