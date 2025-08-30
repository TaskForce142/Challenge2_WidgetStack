//
//  EditTextView.swift
//  Challenge2_WidgetStack
//
//  Created by Chan Yap Long on 30/8/25.
//
import SwiftUI
import Foundation
struct EditTextView: View {
    @State var WidgetText: String = ""
    @State var WidgetTextXAxis: Double = 200
    @State var WidgetTextYAxis: Double = 100
    @State var WidgetTextSize: Double = 50
    var body: some View {
        NavigationStack{
        ScrollView {
        VStack {
                    
            ExampleWidgetView(WidgetText: $WidgetText, WidgetTextXAxis: $WidgetTextXAxis, WidgetTextYAxis: $WidgetTextYAxis, WidgetTextSize: $WidgetTextSize)
           
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
                }
            }
            .navigationTitle(Text("Edit Text"))
        }
    }
}

#Preview {
    EditTextView()
}
