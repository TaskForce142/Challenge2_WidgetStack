//
//  HomeView.swift
//  Challenge2_WidgetStack
//
//  Created by Chan Yap Long on 16/8/25.
//

import SwiftUI

struct HomeView: View {
    @State private var widgets: [UUID] = []

    var body: some View {
        TabView {
            NavigationStack {
                ScrollView {
                    VStack {
                        ForEach(widgets, id: \.self) { _ in
                            // Changed: Show saved widget data instead of plain blue
                            SavedExampleWidgetView()
                        }

                        NavigationLink {
                            VStack {
                                ZStack{
                                    SavedExampleWidgetView()
                                }
                                    HStack {
                                        Text("Layers")
                                            .padding()
                                            .foregroundStyle(Color.gray)
                                        Spacer()
                                    }
                                    
                                    Divider()
                                    
                                    HStack {
                                        Text("Text")
                                            .padding(.leading, 50)
                                        Spacer()
                                        NavigationLink {
                                            EditTextView(WidgetImage: "default-image")
                                        } label: {
                                            Image(systemName: "chevron.right")
                                                .padding(.trailing, 50)
                                                .foregroundStyle(Color.black)
                                        }
                                    }
                                    
                                    Divider()
                                    
                                    HStack {
                                        Text("Image")
                                            .padding(.leading, 50)
                                        Spacer()
                                        NavigationLink {
                                            EditImageView()
                                        } label: {
                                            Image(systemName: "chevron.right")
                                                .padding(.trailing, 50)
                                                .foregroundStyle(Color.black)
                                        }
                                    }
                                    
                                    Divider()
                                    
                                    HStack {
                                        Text("Clock")
                                            .padding(.leading, 50)
                                        Spacer()
                                        NavigationLink {
                                            EditClockView()
                                        } label: {
                                            Image(systemName: "chevron.right")
                                                .padding(.trailing, 50)
                                                .foregroundStyle(Color.black)
                                        }
                                    }
                                    
                                    Divider()
                                    
                                    HStack {
                                        Text("Random Quote")
                                            .padding(.leading, 50)
                                        Spacer()
                                        NavigationLink {
                                            EditRandomQuoteView()
                                        } label: {
                                            Image(systemName: "chevron.right")
                                                .padding(.trailing, 50)
                                                .foregroundStyle(Color.black)
                                        }
                                    }
                                    
                                    Spacer()
                                }
                            .navigationTitle("Edit")
                        } label: {
                            // Changed: Show saved widget data instead of plain blue
                            SavedExampleWidgetView()
                        }
                        .navigationTitle("Widgets Collection")
                    }
                }
                .toolbar {
                    Button {
                        widgets.append(UUID())
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}



// NEW: Widget view that loads and displays saved data
struct SavedExampleWidgetView: View {
    @State private var widgetColor: Color = .blue
    @State private var widgetText: String = ""
    @State private var widgetTextXAxis: Double = 200
    @State private var widgetTextYAxis: Double = 100
    @State private var widgetTextSize: Double = 50
    @State private var widgetTextColor: Color = .black
    
    private let sharedDefaults = UserDefaults(suiteName: "group.org.yourname.Challenge2-WidgetStack")!
    
    var body: some View {
        ZStack {
            VStack {
                widgetColor
            }
            .frame(width: 342, height: 164)
            .clipShape(RoundedRectangle(cornerRadius: 21))
            .padding()
            
            if !widgetText.isEmpty {
                Text(widgetText)
                    .font(.system(size: CGFloat(widgetTextSize)))
                    .foregroundColor(widgetTextColor)
                    .multilineTextAlignment(.center)
                    .padding()
                    .frame(width: 342, height: 164)
                    .position(x: CGFloat(widgetTextXAxis), y: CGFloat(widgetTextYAxis))
                    .minimumScaleFactor(0.5)
            }
        }
        .onAppear { loadSavedData() }
    }
    
    private func loadSavedData() {
        widgetText = sharedDefaults.string(forKey: "savedWidgetText") ?? ""
        widgetTextXAxis = sharedDefaults.double(forKey: "savedXAxis")
        if widgetTextXAxis == 0 { widgetTextXAxis = 200 }
        
        widgetTextYAxis = sharedDefaults.double(forKey: "savedYAxis")
        if widgetTextYAxis == 0 { widgetTextYAxis = 100 }
        
        widgetTextSize = sharedDefaults.double(forKey: "savedTextSize")
        if widgetTextSize == 0 { widgetTextSize = 50 }
        
        if let colorData = sharedDefaults.data(forKey: "savedTextColor"),
           let uiColor = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(colorData) as? UIColor {
            widgetTextColor = Color(uiColor)
        }
        
        if let bgColorData = sharedDefaults.data(forKey: "savedBGColor"),
           let uiBGColor = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(bgColorData) as? UIColor {
            widgetColor = Color(uiBGColor)
        }
    }
}


struct ExampleWidgetView: View {
    var WidgetImage: String
    @Binding var WidgetColor: Color
    @Binding var WidgetText: String
    @Binding var WidgetTextXAxis: Double
    @Binding var WidgetTextYAxis: Double
    @Binding var WidgetTextSize: Double
    @Binding var WidgetTextColor: Color
    @Binding var WidgetRandomQuote: Bool
    
    var body: some View {
        ZStack {
            VStack {
                Color(WidgetColor)
            }
            .frame(width: 342, height: 164)
            .clipShape(RoundedRectangle(cornerRadius: 21))
            .padding()
            if !WidgetImage.isEmpty {
                Image(WidgetImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 342, height: 164)
                    .clipShape(RoundedRectangle(cornerRadius: 21))
                    .padding()
            }
            if !WidgetText.isEmpty {
                Text(WidgetText)
                    .font(.system(size: CGFloat(WidgetTextSize)))
                    .foregroundColor(WidgetTextColor)
                    .multilineTextAlignment(.center)
                    .padding()
                    .frame(width: 342, height: 164)
                    .position(x: CGFloat(WidgetTextXAxis), y: CGFloat(WidgetTextYAxis))
                    .minimumScaleFactor(0.5)
            }
        }
    }
}

#Preview {
    HomeView()
}
