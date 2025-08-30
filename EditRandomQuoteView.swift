//
//  EditRandomQuoteView.swift
//  Challenge2_WidgetStack
//
//  Created by Chan Yap Long on 30/8/25.
//
import SwiftUI
import Foundation
struct EditRandomQuoteView: View {
    @State var WidgetText: String = ""
    @State var WidgetTextXAxis: Double = 200
    @State var WidgetTextYAxis: Double = 100
    @State var WidgetTextSize: Double = 50
    @State var WidgetTextColor: Color = .black
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack{
                    ExampleWidgetView(WidgetText: $WidgetText, WidgetTextXAxis: $WidgetTextXAxis, WidgetTextYAxis: $WidgetTextYAxis, WidgetTextSize: $WidgetTextSize, WidgetTextColor: $WidgetTextColor)
                }
            }
        }
    }
}
#Preview {
    EditRandomQuoteView()
}
