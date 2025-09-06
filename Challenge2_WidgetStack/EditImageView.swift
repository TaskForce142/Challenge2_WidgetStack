//
//  EditImageView.swift
//  Challenge2_WidgetStack
//
//  Created by Chan Yap Long on 30/8/25.
//

import SwiftUI
import PhotosUI

extension Color {
    init(hex: UInt, alpha: Double = 1.0) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255.0,
            green: Double((hex >> 8) & 0xFF) / 255.0,
            blue: Double(hex & 0xFF) / 255.0,
            opacity: alpha
        )
    }
    
    static let aliceBlue        = Color(hex: 0xF0F8FF)
    static let antiqueWhite     = Color(hex: 0xFAEBD7)
    static let aqua             = Color(hex: 0x00FFFF)
    static let aquamarine       = Color(hex: 0x7FFFD4)
    static let azure            = Color(hex: 0xF0FFFF)
    static let beige            = Color(hex: 0xF5F5DC)
    static let bisque           = Color(hex: 0xFFE4C4)
    static let blanchedAlmond   = Color(hex: 0xFFEBCD)
    static let blueViolet       = Color(hex: 0x8A2BE2)
    static let burlyWood        = Color(hex: 0xDEB887)
    static let cadetBlue        = Color(hex: 0x5F9EA0)
    static let chartreuse       = Color(hex: 0x7FFF00)
    static let chocolate        = Color(hex: 0xD2691E)
    static let coral            = Color(hex: 0xFF7F50)
    static let cornflowerBlue   = Color(hex: 0x6495ED)
    static let cornsilk         = Color(hex: 0xFFF8DC)
    static let crimson          = Color(hex: 0xDC143C)
    static let darkBlue         = Color(hex: 0x00008B)
    static let darkCyan         = Color(hex: 0x008B8B)
    static let darkGoldenRod    = Color(hex: 0xB8860B)
    static let darkGray         = Color(hex: 0xA9A9A9)
    static let darkGreen        = Color(hex: 0x006400)
    static let darkKhaki        = Color(hex: 0xBDB76B)
    static let darkMagenta      = Color(hex: 0x8B008B)
    static let darkOliveGreen   = Color(hex: 0x556B2F)
}

struct EditImageView: View {
    @State private var avatarItem: PhotosPickerItem?
    @State private var avatarImage: Image?
    @State private var selectedImageData: Data?
    
    @State private var selectedColorName: String = "Blue"
    @State private var widgetImage: String = "default-image" // Added missing widget image
    @State private var widgetText: String = ""
    @State private var widgetTextXAxis: Double = 200
    @State private var widgetTextYAxis: Double = 100
    @State private var widgetTextSize: Double = 50
    @State private var widgetTextColor: Color = .black
    @State private var widgetRandomQuote: Bool = false
    
    var body: some View {
        let widgetColors: [(String, Color)] = [
            ("AliceBlue", .aliceBlue),
            ("AntiqueWhite", .antiqueWhite),
            ("Aqua", .aqua),
            ("Aquamarine", .aquamarine),
            ("Azure", .azure),
            ("Beige", .beige),
            ("Bisque", .bisque),
            ("Black", .black),
            ("BlanchedAlmond", .blanchedAlmond),
            ("Blue", .blue),
            ("BlueViolet", .blueViolet),
            ("Brown", .brown),
            ("BurlyWood", .burlyWood),
            ("CadetBlue", .cadetBlue),
            ("Chartreuse", .chartreuse),
            ("Chocolate", .chocolate),
            ("Coral", .coral),
            ("CornflowerBlue", .cornflowerBlue),
            ("Cornsilk", .cornsilk),
            ("Crimson", .crimson),
            ("Cyan", .cyan),
            ("DarkBlue", .darkBlue),
            ("DarkCyan", .darkCyan),
            ("DarkGoldenRod", .darkGoldenRod),
            ("DarkGray", .darkGray),
            ("DarkGreen", .darkGreen),
            ("DarkKhaki", .darkKhaki),
            ("DarkMagenta", .darkMagenta),
            ("DarkOliveGreen", .darkOliveGreen),
            ("Gray", .gray),
            ("Green", .green),
            ("Orange", .orange),
            ("Pink", .pink),
            ("Purple", .purple),
            ("Red", .red),
            ("White", .white),
            ("Yellow", .yellow)
        ]
        
        let selectedColor = widgetColors.first { $0.0 == selectedColorName }?.1 ?? .blue
        
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Widget Preview with selected image overlay
                    ZStack {
                        ExampleWidgetView(
                            WidgetImage: widgetImage,
                            WidgetColor: .constant(selectedColor),
                            WidgetText: $widgetText,
                            WidgetTextXAxis: $widgetTextXAxis,
                            WidgetTextYAxis: $widgetTextYAxis,
                            WidgetTextSize: $widgetTextSize,
                            WidgetTextColor: $widgetTextColor,
                            WidgetRandomQuote: $widgetRandomQuote
                        )
                        
                        // Overlay selected image if available
                        if let avatarImage {
                            avatarImage
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 342, height: 164)
                                .clipShape(RoundedRectangle(cornerRadius: 21))
                                .opacity(0.8) // Make it slightly transparent to see background color
                        }
                    }
                    
                    // Controls Section
                    VStack(spacing: 15) {
                        // Background Color Picker
                        VStack(alignment: .leading) {
                            Text("Background Color")
                                .font(.headline)
                            
                            Picker("Select a Color", selection: $selectedColorName) {
                                ForEach(widgetColors, id: \.0) { name, color in
                                    HStack {
                                        Circle()
                                            .fill(color)
                                            .frame(width: 20, height: 20)
                                        Text(name)
                                    }
                                    .tag(name)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                        }
                        .padding(.horizontal)
                        
                        Divider()
                        
                        // Photo Picker Section
                        VStack(alignment: .leading) {
                            Text("Widget Image")
                                .font(.headline)
                            
                            PhotosPicker(
                                selection: $avatarItem,
                                matching: .images,
                                photoLibrary: .shared()
                            ) {
                                HStack {
                                    Image(systemName: "photo")
                                    Text("Select Photo from Library")
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue.opacity(0.1))
                                .cornerRadius(8)
                            }
                            
                            if avatarImage != nil {
                                Button("Remove Image") {
                                    avatarImage = nil
                                    avatarItem = nil
                                    selectedImageData = nil
                                }
                                .foregroundColor(.red)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.red.opacity(0.1))
                                .cornerRadius(8)
                            }
                        }
                        .padding(.horizontal)
                        
                        // Image preview (smaller version)
                        if let avatarImage {
                            VStack {
                                Text("Selected Image Preview")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                
                                avatarImage
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 150, height: 150)
                                    .cornerRadius(8)
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Image Widget")
        }
        .onChange(of: avatarItem) { oldValue, newValue in
            Task {
                if let data = try? await newValue?.loadTransferable(type: Data.self),
                   let uiImage = UIImage(data: data) {
                    selectedImageData = data
                    avatarImage = Image(uiImage: uiImage)
                } else {
                    print("Failed to load image")
                    selectedImageData = nil
                    avatarImage = nil
                }
            }
        }
    }
}

#Preview {
    EditImageView()
}
