import SwiftUI
import Foundation
import WidgetKit

struct EditTextView: View {
    @State private var WidgetColor: Color = .blue
    @State private var WidgetText: String = ""
    @State private var WidgetTextXAxis: Double = 200
    @State private var WidgetTextYAxis: Double = 100
    @State private var WidgetTextSize: Double = 50
    @State private var WidgetTextColor: Color = .black
    @State private var WidgetRandomQuote: Bool = false
    @State private var WidgetImage: String
    
    private let sharedDefaults = UserDefaults(suiteName: "group.org.yourname.Challenge2-WidgetStack")!
    
    init(WidgetImage: String) {
        self._WidgetImage = State(initialValue: WidgetImage)
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    ExampleWidgetView(
                        WidgetImage: WidgetImage,
                        WidgetColor: $WidgetColor,
                        WidgetText: $WidgetText,
                        WidgetTextXAxis: $WidgetTextXAxis,
                        WidgetTextYAxis: $WidgetTextYAxis,
                        WidgetTextSize: $WidgetTextSize,
                        WidgetTextColor: $WidgetTextColor,
                        WidgetRandomQuote: $WidgetRandomQuote
                    )
                    
                    HStack {
                        Text("Text")
                            .padding(.trailing, 30)
                        TextField("Text", text: $WidgetText)
                    }
                    .padding(.leading, 50)
                    
                    Divider()
                    Slider(value: $WidgetTextXAxis, in: 100...300, step: 10)
                    Text("X Axis: \(WidgetTextXAxis, specifier: "%.1f")")
                    
                    Divider()
                    Slider(value: $WidgetTextYAxis, in: 30...170, step: 10)
                    Text("Y Axis: \(WidgetTextYAxis, specifier: "%.1f")")
                    
                    Divider()
                    Slider(value: $WidgetTextSize, in: 1...100, step: 1)
                    Text("Font Size: \(WidgetTextSize, specifier:"%.1f")")
                        .padding(.leading, 50)
                    
                    Divider()
                    ColorPicker("Text Color", selection: $WidgetTextColor)
                        .padding(.horizontal, 50)
                    
                    Button("Save & Update Widget") {
                        if let sharedDefaults = UserDefaults(suiteName: "group.org.yourname.Challenge2-WidgetStack") {
                            sharedDefaults.set(WidgetText, forKey: "savedWidgetText")
                            sharedDefaults.set(WidgetTextXAxis, forKey: "savedXAxis")
                            sharedDefaults.set(WidgetTextYAxis, forKey: "savedYAxis")
                            sharedDefaults.set(WidgetTextSize, forKey: "savedTextSize")

                            if let textColorData = try? NSKeyedArchiver.archivedData(withRootObject: UIColor(WidgetTextColor), requiringSecureCoding: false) {
                                sharedDefaults.set(textColorData, forKey: "savedTextColor")
                            }
                            if let bgColorData = try? NSKeyedArchiver.archivedData(withRootObject: UIColor(WidgetColor), requiringSecureCoding: false) {
                                sharedDefaults.set(bgColorData, forKey: "savedBGColor")
                            }
                            sharedDefaults.synchronize()
                        }

                        WidgetCenter.shared.reloadAllTimelines()
                    }
                    .buttonStyle(.borderedProminent)
                    .padding()
                }
            }
            .navigationTitle(Text("Edit Text"))
            .onAppear { loadData() }
        }
    }
    
    // MARK: - Save & Load
    
    private func saveData() {
        sharedDefaults.set(WidgetText, forKey: "savedWidgetText")
        sharedDefaults.set(WidgetTextXAxis, forKey: "savedXAxis")
        sharedDefaults.set(WidgetTextYAxis, forKey: "savedYAxis")
        sharedDefaults.set(WidgetTextSize, forKey: "savedTextSize")
        
        if let colorData = try? NSKeyedArchiver.archivedData(withRootObject: UIColor(WidgetTextColor), requiringSecureCoding: false) {
            sharedDefaults.set(colorData, forKey: "savedTextColor")
        }
        if let bgColorData = try? NSKeyedArchiver.archivedData(withRootObject: UIColor(WidgetColor), requiringSecureCoding: false) {
            sharedDefaults.set(bgColorData, forKey: "savedBGColor")
        }
    }
    
    private func loadData() {
        WidgetText = sharedDefaults.string(forKey: "savedWidgetText") ?? ""
        WidgetTextXAxis = sharedDefaults.double(forKey: "savedXAxis")
        if WidgetTextXAxis == 0 { WidgetTextXAxis = 200 }
        
        WidgetTextYAxis = sharedDefaults.double(forKey: "savedYAxis")
        if WidgetTextYAxis == 0 { WidgetTextYAxis = 100 }
        
        WidgetTextSize = sharedDefaults.double(forKey: "savedTextSize")
        if WidgetTextSize == 0 { WidgetTextSize = 50 }
        
        if let colorData = sharedDefaults.data(forKey: "savedTextColor"),
           let uiColor = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(colorData) as? UIColor {
            WidgetTextColor = Color(uiColor)
        }
        
        if let bgColorData = sharedDefaults.data(forKey: "savedBGColor"),
           let uiBGColor = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(bgColorData) as? UIColor {
            WidgetColor = Color(uiBGColor)
        }
    }
}

#Preview {
    EditTextView(WidgetImage: "example-image")
}
