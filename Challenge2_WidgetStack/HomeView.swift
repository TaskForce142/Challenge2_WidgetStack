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
                NavigationLink("Tap Me") {
                    Text("Detail View")
                        .toolbar(.hidden, for: .tabBar)
                }
                .navigationTitle("Widgets Collection")
            }
            .tabItem {
                Label("Home", systemImage: "house")
            }
        }
    }
}

#Preview {
    HomeView()
}
