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
#Preview {
    HomeView()
}
