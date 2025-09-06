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
                    NavigationLink {
                        VStack {
                            SimpleExampleWidgetView()
                            
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
                                    // Fixed: Pass an actual string value
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
                        // Use the simple widget view for the navigation link label
                        SimpleExampleWidgetView()
                    }
                    .navigationTitle("Widgets Collection")
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

// Simple widget view for display purposes (no bindings required)
struct SimpleExampleWidgetView: View {
    var body: some View {
        VStack {
            Color.blue
        }
        .frame(width: 342, height: 164)
        .clipShape(RoundedRectangle(cornerRadius: 21))
        .padding()
    }
}

// Full-featured widget view for editing (requires bindings)
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
            // Background
            VStack {
                Color(WidgetColor)
            }
            .frame(width: 342, height: 164)
            .clipShape(RoundedRectangle(cornerRadius: 21))
            .padding()
            
            // Image layer (if you want to show an image)
            if !WidgetImage.isEmpty {
                Image(WidgetImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 342, height: 164)
                    .clipShape(RoundedRectangle(cornerRadius: 21))
                    .padding()
            }
            
            // Text overlay
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
