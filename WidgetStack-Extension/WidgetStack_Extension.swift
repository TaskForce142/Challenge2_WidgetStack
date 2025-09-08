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
        // OLD CODE (replace this):
        // VStack {
        //     Text("Time:")
        //     Text(entry.date, style: .time)
        // }
        
        // NEW CODE (analog clock):
        ZStack {
            // Clock face
            Circle()
                .stroke(Color.primary, lineWidth: 4)
                .background(Circle().fill(Color(.systemBackground)))
            
            // Hour markers
            ForEach(1...12, id: \.self) { hour in
                Rectangle()
                    .fill(Color.primary)
                    .frame(width: 2, height: 8)
                    .offset(y: -35)
                    .rotationEffect(.degrees(Double(hour) * 30))
            }
            
            // Hour hand
            Rectangle()
                .fill(Color.primary)
                .frame(width: 3, height: 20)
                .offset(y: -10)
                .rotationEffect(.degrees(hourAngle(from: entry.date)))
            
            // Minute hand
            Rectangle()
                .fill(Color.primary)
                .frame(width: 2, height: 30)
                .offset(y: -15)
                .rotationEffect(.degrees(minuteAngle(from: entry.date)))
            
            // Center dot
            Circle()
                .fill(Color.primary)
                .frame(width: 6, height: 6)
        }
        .padding()
        .widgetURL(URL(string: "challenge2://open"))
    }
    
    // ADD these helper functions inside the struct:
    private func hourAngle(from date: Date) -> Double {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date) % 12
        let minute = calendar.component(.minute, from: date)
        return Double(hour) * 30 + Double(minute) * 0.5
    }
    
    private func minuteAngle(from date: Date) -> Double {
        let calendar = Calendar.current
        let minute = calendar.component(.minute, from: date)
        return Double(minute) * 6
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
