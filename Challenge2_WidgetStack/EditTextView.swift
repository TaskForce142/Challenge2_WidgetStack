import SwiftUI
import Foundation
import WidgetKit

struct EditTextView: View {
    
    @State var WidgetColor: Color = .blue
    @State var WidgetText: String = ""
    @State var WidgetTextXAxis: Double = 200
    @State var WidgetTextYAxis: Double = 100
    @State var WidgetTextSize: Double = 50
    @State var WidgetTextColor: Color = .black
    @State var WidgetRandomQuote: Bool = false
    @State var WidgetImage: String
    
    init(WidgetImage: String) {
        self._WidgetImage = State(initialValue: WidgetImage)
    }
    
    var body: some View {
        NavigationStack{
            ScrollView {
                VStack {
                    
                    ExampleWidgetView(WidgetImage: WidgetImage, WidgetColor: $WidgetColor, WidgetText: $WidgetText, WidgetTextXAxis: $WidgetTextXAxis, WidgetTextYAxis: $WidgetTextYAxis, WidgetTextSize: $WidgetTextSize, WidgetTextColor: $WidgetTextColor, WidgetRandomQuote: $WidgetRandomQuote)
                    
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
                        .padding(.leading, 50)
                        .padding(.trailing, 50)
                    
                    // Save button that updates both app and widget
                    Button("Save & Update Widget") {
                        // Save data using UserDefaults
                        UserDefaults.standard.set(WidgetText, forKey: "savedWidgetText")
                        UserDefaults.standard.set(WidgetTextXAxis, forKey: "savedXAxis")
                        UserDefaults.standard.set(WidgetTextYAxis, forKey: "savedYAxis")
                        UserDefaults.standard.set(WidgetTextSize, forKey: "savedTextSize")
                        
                        // Save color as data
                        if let colorData = try? NSKeyedArchiver.archivedData(withRootObject: UIColor(WidgetTextColor), requiringSecureCoding: false) {
                            UserDefaults.standard.set(colorData, forKey: "savedTextColor")
                        }
                        if let bgColorData = try? NSKeyedArchiver.archivedData(withRootObject: UIColor(WidgetColor), requiringSecureCoding: false) {
                            UserDefaults.standard.set(bgColorData, forKey: "savedBGColor")
                        }
                        
                        // ALSO save to shared container if available
                        if let sharedDefaults = UserDefaults(suiteName: "group.yourcompany.challenge2.widgets") {
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
                        
                        // Force widget refresh
                        WidgetCenter.shared.reloadAllTimelines()
                    }
                    .buttonStyle(.borderedProminent)
                    .padding()
                }
            }
            .navigationTitle(Text("Edit Text"))
            .onAppear {
                // Load saved data when view appears
                loadSavedData()
            }
        }
    }
    
    private func loadSavedData() {
        // Try shared container first, then fallback to regular UserDefaults
        let sharedDefaults = UserDefaults(suiteName: "group.yourcompany.challenge2.widgets")
        let defaults = sharedDefaults ?? UserDefaults.standard
        
        // Load text data
        WidgetText = defaults.string(forKey: "savedWidgetText") ?? ""
        WidgetTextXAxis = defaults.double(forKey: "savedXAxis")
        if WidgetTextXAxis == 0 { WidgetTextXAxis = 200 } // Default value
        
        WidgetTextYAxis = defaults.double(forKey: "savedYAxis")
        if WidgetTextYAxis == 0 { WidgetTextYAxis = 100 } // Default value
        
        WidgetTextSize = defaults.double(forKey: "savedTextSize")
        if WidgetTextSize == 0 { WidgetTextSize = 50 } // Default value
        
        // Load colors
        if let colorData = defaults.data(forKey: "savedTextColor"),
           let uiColor = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(colorData) as? UIColor {
            WidgetTextColor = Color(uiColor)
        }
        
        if let bgColorData = defaults.data(forKey: "savedBGColor"),
           let uiBGColor = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(bgColorData) as? UIColor {
            WidgetColor = Color(uiBGColor)
        }
    }
}

#Preview {
    EditTextView(WidgetImage: "example-image")
}
