//
//  EditImageView.swift
//  Challenge2_WidgetStack
//
//  Created by Chan Yap Long on 30/8/25.
//
import SwiftUI
import Foundation
import PhotosUI
struct EditImageView: View {
    @State private var avatarItem: PhotosPickerItem?
    @State private var avatarImage: Image?
    @State private var WidgetText: String = ""
    @State private var WidgetTextXAxis: Double = 200
    @State private var WidgetTextYAxis: Double = 100
    @State private var WidgetTextSize: Double = 50
    @State private var WidgetTextColor: Color = .black
    @State private var WidgetRandomQuote: Bool = false
    var body: some View {
        ScrollView {
            VStack {
                ExampleWidgetView(WidgetText: $WidgetText, WidgetTextXAxis: $WidgetTextXAxis, WidgetTextYAxis: $WidgetTextYAxis, WidgetTextSize: $WidgetTextSize, WidgetTextColor: $WidgetTextColor, WidgetRandomQuote: $WidgetRandomQuote)
                PhotosPicker("Select Photo", selection: $avatarItem, matching: .images)
                
                avatarImage?
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
            }
            .onChange(of: avatarItem) {
                Task {
                    if let loaded = try? await avatarItem?.loadTransferable(type: Image.self) {
                        avatarImage = loaded
                    } else {
                        print("Failed")
                    }
                }
            }
        }
    }
}
#Preview {
    EditImageView()
}
