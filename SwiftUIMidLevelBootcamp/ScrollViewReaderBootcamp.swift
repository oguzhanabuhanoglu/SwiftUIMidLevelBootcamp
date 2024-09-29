//
//  ScrollViewReader.swift
//  SwiftUIMidLevelBootcamp
//
//  Created by Oğuzhan Abuhanoğlu on 29.09.2024.
//

import SwiftUI

struct ScrollViewReaderBootcamp: View {
    
    @State var textFieldText: String = ""
    @State var scrollToIndex: Int = 0
    
    
    var body: some View {
        VStack {
            
            TextField("Enter a # here", text: $textFieldText)
                .frame(height: 55)
                .border(Color.gray)
                .padding()
                .keyboardType(.numberPad)
            
            
            Button("Click Here To Scroll") {
                withAnimation(.spring()) {
                    if let index = Int(textFieldText) {
                        scrollToIndex = index
                    }
                }
            }
            
            ScrollView {
                ScrollViewReader { proxy in
                    
                    ForEach(1..<50) { index in
                        Text("This is index #\(index)")
                            .font(.headline)
                            .frame(height: 200)
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(15)
                            .padding()
                            .shadow(radius: 10)
                            .id(index)
                    }
                    .onChange(of: scrollToIndex) { newValue in
                        withAnimation(.spring()) {
                            proxy.scrollTo(newValue, anchor: .top)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ScrollViewReaderBootcamp()
}
