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
    var body: some View {
        VStack {
            Text("Edit Text")
                .font(.largeTitle)
                .bold()
                .padding(.trailing, 200)
            
            ExampleWidgetView()
            HStack {
                Text("Text")
                    .padding(.trailing, 30)
                TextField("Text", text: $WidgetText)
            }
            .padding(.leading, 50)
            Divider()
            
                .foregroundStyle(Color.black)
            
            Spacer()
        }
        
    }
    
}

#Preview {
    EditTextView()
}
