//
//  EditClockView.swift
//
//  Created by Chan Yap Long on 30/8/25.
//
import SwiftUI
import Foundation

struct EditClockView: View {
    @State private var widgetColor: Color = .blue
    @State private var widgetText: String = ""
    @State private var widgetTextXAxis: Double = 200
    @State private var widgetTextYAxis: Double = 100
    @State private var widgetTextSize: Double = 50
    @State private var widgetTextColor: Color = .black
    @State private var widgetRandomQuote: Bool = false
    @State private var widgetImage: String = "clock-background"
    @State private var currentTime = Date()
    @State private var useAnalogClock = false
    @State private var selectedTheme = "Light"
    @State private var widgetClockSize: Double = 120

    let themes = ["Light", "Dark", "Neon"]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {

                    ZStack {
                        ExampleWidgetView(
                            WidgetImage: widgetImage,
                            WidgetColor: $widgetColor,
                            WidgetText: $widgetText,
                            WidgetTextXAxis: $widgetTextXAxis,
                            WidgetTextYAxis: $widgetTextYAxis,
                            WidgetTextSize: $widgetTextSize,
                            WidgetTextColor: $widgetTextColor,
                            WidgetRandomQuote: $widgetRandomQuote
                        )
                    }
                    .overlay(clockOverlay)

                    VStack(spacing: 15) {
                        HStack {
                            Text("Clock Type").font(.headline)
                            Spacer()
                            Toggle("Analog Mode", isOn: $useAnalogClock)
                        }
                        .padding(.horizontal)

                        Divider()

                        VStack(alignment: .leading) {
                            Text("Theme").font(.headline)
                            Picker("Theme", selection: $selectedTheme) {
                                ForEach(themes, id: \.self) { theme in
                                    Text(theme).tag(theme)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }
                        .padding(.horizontal)

                        Divider()

                        ColorPicker("Widget Background", selection: $widgetColor)
                            .padding(.horizontal)

                        Divider()

                        positionAndSizeControls

                        Divider()

                        Text(formattedDate())
                            .font(.title2)
                            .foregroundColor(themeTextColor())
                            .padding()
                    }
                }
                .padding()
            }
            .navigationTitle("Clock Widget")
        }
        .onAppear {
            startClock()
            updateClockText()
        }
        .onChange(of: useAnalogClock) {
            updateClockText()
        }
    }
    var clockOverlay: some View {
        Group {
            if useAnalogClock {
                AnalogClockView(
                    currentTime: $currentTime,
                    theme: selectedTheme,
                    size: CGFloat(widgetClockSize)
                )
            } else {
                DigitalClockView(
                    currentTime: $currentTime,
                    theme: selectedTheme,
                    size: CGFloat(widgetClockSize * 0.3)
                )
            }
        }
        .offset(
            x: CGFloat(widgetTextXAxis - widgetClockSize / 2),
            y: CGFloat(widgetTextYAxis - widgetClockSize / 2)
        )
    }

    // MARK: - Position & Size Controls
    var positionAndSizeControls: some View {
        VStack {
            Text("Clock Position & Size").font(.headline)
            VStack {
                Text("Horizontal: \(Int(widgetTextXAxis))")
                Slider(value: $widgetTextXAxis, in: 0...120, step: 5)
                Text("Left ←→ Right").font(.caption).foregroundColor(.gray)
            }
            VStack {
                Text("Vertical: \(Int(widgetTextYAxis))")
                Slider(value: $widgetTextYAxis, in: 0...120, step: 5)
                Text("Top ↑↓ Bottom").font(.caption).foregroundColor(.gray)
            }
            VStack {
                Text("Clock Size: \(Int(widgetClockSize))")
                Slider(value: $widgetClockSize, in: 50...180, step: 5)
                Text("Small ↑↓ Large").font(.caption).foregroundColor(.gray)
            }
        }
        .padding(.horizontal)
    }

    func updateClockText() { widgetText = "" }

    func startClock() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            currentTime = Date()
        }
    }

    func formattedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter.string(from: currentTime)
    }

    func themeTextColor() -> Color {
        switch selectedTheme {
        case "Dark": return .white
        case "Neon": return .green
        default: return .black
        }
    }
}

struct AnalogClockView: View {
    @Binding var currentTime: Date
    var theme: String
    var size: CGFloat = 180

    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: size * 0.02)
                .foregroundColor(themeTextColor())
                .frame(width: size, height: size)

            ForEach(1...12, id: \.self) { number in
                Text("\(number)")
                    .font(.system(size: size * 0.08, weight: .bold))
                    .foregroundColor(themeTextColor())
                    .position(hourMarkerPosition(for: number, radius: size * 0.39))
            }

            Rectangle()
                .fill(themeTextColor())
                .frame(width: size * 0.02, height: size * 0.28)
                .offset(y: -size * 0.14)
                .rotationEffect(.degrees(hourRotation()), anchor: .center)

            Rectangle()
                .fill(themeTextColor())
                .frame(width: size * 0.015, height: size * 0.38)
                .offset(y: -size * 0.19)
                .rotationEffect(.degrees(minuteRotation()), anchor: .center)

            Rectangle()
                .fill(Color.red)
                .frame(width: size * 0.005, height: size * 0.45)
                .offset(y: -size * 0.225)
                .rotationEffect(.degrees(secondRotation()), anchor: .center)

            Circle()
                .fill(themeTextColor())
                .frame(width: size * 0.045, height: size * 0.045)
        }
        .frame(width: size, height: size)
    }

    func hourRotation() -> Double {
        let hour = Calendar.current.component(.hour, from: currentTime) % 12
        let minutes = Calendar.current.component(.minute, from: currentTime)
        return Double(hour) * 30 + Double(minutes) * 0.5
    }

    func minuteRotation() -> Double {
        let minute = Calendar.current.component(.minute, from: currentTime)
        let seconds = Calendar.current.component(.second, from: currentTime)
        return Double(minute) * 6 + Double(seconds) * 0.1
    }

    func secondRotation() -> Double {
        let second = Calendar.current.component(.second, from: currentTime)
        return Double(second) * 6
    }

    func themeTextColor() -> Color {
        switch theme {
        case "Dark": return .white
        case "Neon": return .green
        default: return .black
        }
    }

    func hourMarkerPosition(for number: Int, radius: CGFloat) -> CGPoint {
        let angle = Double(number) / 12 * 2 * Double.pi - Double.pi/2
        let center = CGPoint(x: size / 2, y: size / 2)
        let x = center.x + radius * cos(angle)
        let y = center.y + radius * sin(angle)
        return CGPoint(x: x, y: y)
    }
}

// MARK: - Digital Clock
struct DigitalClockView: View {
    @Binding var currentTime: Date
    var theme: String
    var size: CGFloat = 36

    var body: some View {
        Text(formattedTime())
            .font(.system(size: size, weight: .bold, design: .rounded))
            .foregroundColor(themeTextColor())
            .padding()
    }

    func formattedTime() -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        return formatter.string(from: currentTime)
    }

    func themeTextColor() -> Color {
        switch theme {
        case "Dark": return .white
        case "Neon": return .green
        default: return .black
        }
    }
}

#Preview {
    EditClockView()
}
