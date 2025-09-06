//
//  HomeView.swift
//  Challenge2_WidgetStack
//
//  Created by Chan Yap Long on 16/8/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
            NavigationStack {
                ScrollView{
                    NavigationLink() {
                        VStack{
                            ExampleWidgetView()
                            HStack{
                                Text("Layers")
                                    .padding()
                                    .foregroundStyle(Color.gray)
                                Spacer()
                                
                            }
                            Divider()
                            HStack{
                                Text("Text")
                                    .padding(.leading, 50)
                                
                                Spacer()
                                NavigationLink{
                                    EditTextView()
                                }label:{
                                    Image(systemName: "chevron.right")
                                        .padding(.trailing, 50)
                                        .foregroundStyle(Color.black)
                                }
                            }
                            Divider()
                            HStack{
                                Text("Image")
                                    .padding(.leading, 50)
                                
                                Spacer()
                                NavigationLink{
                                    EditImageView()
                                }label:{
                                    Image(systemName: "chevron.right")
                                        .padding(.trailing, 50)
                                        .foregroundStyle(Color.black)
                                }
                            }
                            Divider()
                            HStack{
                                Text("Clock")
                                    .padding(.leading, 50)
                                
                                Spacer()
                                NavigationLink{
                                    EditClockView()
                                }label:{
                                    Image(systemName: "chevron.right")
                                        .padding(.trailing, 50)
                                        .foregroundStyle(Color.black)
                                }
                                .navigationTitle("Edit")
                            }
                            Divider()
                            HStack{
                                Text("Random Quote")
                                    .padding(.leading, 50)
                                
                                Spacer()
                                NavigationLink{
                                    EditRandomQuoteView()
                                }label:{
                                    Image(systemName: "chevron.right")
                                        .padding(.trailing, 50)
                                        .foregroundStyle(Color.black)
                                }
                            }
                            
                        }
                        Spacer()
                    }
                label:
                    {
                        ExampleWidgetView()
                    }
                    .navigationTitle("Widgets Collection")
                    
                }
                .toolbar {
                    Button{
                        
                    }label:{
                        Image(systemName: "plus")
                        
                    }              }
                
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            }
        }
    }
    
    struct ExampleWidgetView: View {
        var body: some View {
            VStack{
                VStack{
                    Color.blue
                    
                }
                .frame(width: 342, height: 164)
                .clipShape(
                    RoundedRectangle(cornerRadius: 21)
                )
                .padding()
            }
        }
    }
    
    
}

struct ExampleWidgetView: View {
    @Binding var WidgetText: String
    @Binding var WidgetTextXAxis: Double
    @Binding var WidgetTextYAxis: Double
    @Binding var WidgetTextSize: Double
    @Binding var WidgetTextColor: Color
    @Binding var WidgetRandomQuote: Bool
    
    var body: some View {
        ZStack{
            VStack{
                Color.blue
                
            }
            .frame(width: 342, height: 164)
            .clipShape(
                RoundedRectangle(cornerRadius: 21)
            )
            .padding()
            Text(WidgetText)
                .frame(width: 342, height: 164)
                .minimumScaleFactor(0.5)
                .position(x: CGFloat((WidgetTextXAxis)), y: CGFloat((WidgetTextYAxis)))
                .font(.system(size: CGFloat(WidgetTextSize)))
                .foregroundColor(WidgetTextColor)
        }
    }
}
#Preview {
    HomeView()
}
