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
                        ExampleWidgetView()
                    }
                label:
                    {
                        ExampleWidgetView()
                    }
                    .navigationTitle("Widgets Collection")
                    NavigationLink() {
                        ExampleWidgetView()
                    }
                label:
                    {
                        ExampleWidgetView()
                    }
                    .navigationTitle("Widgets Collection")
                    NavigationLink() {
                        ExampleWidgetView()
                    }
                label:
                    {
                        ExampleWidgetView()
                    }
                    .navigationTitle("Widgets Collection")
                    NavigationLink() {
                        ExampleWidgetView()
                    }
                label:
                    {
                        ExampleWidgetView()
                    }
                    .navigationTitle("Widgets Collection")
                    NavigationLink() {
                        ExampleWidgetView()
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
#Preview {
    HomeView()
}
