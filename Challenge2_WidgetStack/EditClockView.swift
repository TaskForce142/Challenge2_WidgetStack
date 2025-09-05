//
//  ContentView.swift
//  Digital Clock App
//

import SwiftUI

struct EditClockView: View {
    @State private var currentTime = Date()
    @State private var useAnalogClock = false
    @State private var selectedTheme = "Light"
    
    let themes = ["Light", "Dark", "Neon"]
    
    var body: some View {
        VStack(spacing: 20) {
            Toggle("Analog Clock Mode", isOn: $useAnalogClock)
                .padding()

            if useAnalogClock {
                AnalogClockView(theme: selectedTheme)
            } else {
                DigitalClockView(currentTime: $currentTime, theme: selectedTheme)
            }
            Text(formattedDate())
                .font(.title2)
                .foregroundColor(themeTextColor())
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            startClock()
        }
    }
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
        case "Dark": return Color.white
        case "Neon": return Color.green
        default: return Color.black
        }
    }
}
struct AnalogClockView: View {
    @State private var currentTime = Date()
    var theme: String
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 4)
                .foregroundColor(themeTextColor())
            ForEach(1...12, id: \.self) { number in
                Text("\(number)")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(themeTextColor())
                    .position(hourMarkerPosition(for: number, radius: 90))
            }
            Rectangle()
                .fill(themeTextColor())
                .frame(width: 6, height: 50)
                .offset(y: -25)
                .rotationEffect(.degrees(hourRotation()), anchor: .center)
            Rectangle()
                .fill(themeTextColor())
                .frame(width: 4, height: 70)
                .offset(y: -35)
                .rotationEffect(.degrees(minuteRotation()), anchor: .center)
            Rectangle()
                .fill(Color.red)
                .frame(width: 2, height: 80)
                .offset(y: -40)
                .rotationEffect(.degrees(secondRotation()), anchor: .center)
            Circle().frame(width: 10, height: 10)
        }
        .frame(width: 200, height: 200)
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                self.currentTime = Date()
            }
        }
    }

    func hourRotation() -> Double {
        let hour = Calendar.current.component(.hour, from: currentTime) % 12
        let minutes = Calendar.current.component(.minute, from: currentTime)
        return (Double(hour) * 30) + (Double(minutes) * 0.5)
    }

    func minuteRotation() -> Double {
        let minute = Calendar.current.component(.minute, from: currentTime)
        let seconds = Calendar.current.component(.second, from: currentTime)
        return (Double(minute) * 6) + (Double(seconds) * 0.1)
    }

    func secondRotation() -> Double {
        let second = Calendar.current.component(.second, from: currentTime)
        return Double(second) * 6
    }
    func hourMarkerPosition(for hour: Int, radius: CGFloat) -> CGPoint {
        let angle = Double(hour) * 30 * .pi / 180
        let x = cos(angle - .pi / 2) * Double(radius)
        let y = sin(angle - .pi / 2) * Double(radius)
        return CGPoint(x: 100 + x, y: 100 + y)
    }
    func themeTextColor() -> Color {
        switch theme {
        case "Dark": return Color.white
        case "Neon": return Color.green
        default: return Color.black
        }
    }
}
struct DigitalClockView: View {
    @Binding var currentTime: Date
    var theme: String
    
    var body: some View {
        Text(formattedTime())
            .font(.system(size: 60, weight: .bold, design: .rounded))
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
        case "Dark": return Color.white
        case "Neon": return Color.green
        default: return Color.black
        }
    }
}

#Preview {
    EditClockView()
}

