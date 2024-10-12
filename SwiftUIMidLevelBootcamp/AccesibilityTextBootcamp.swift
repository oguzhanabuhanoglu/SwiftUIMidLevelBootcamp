//
//  AccesibilityTextBootcamp.swift
//  SwiftUIMidLevelBootcamp
//
//  Created by Oğuzhan Abuhanoğlu on 12.10.2024.
//

import SwiftUI

struct AccesibilityTextBootcamp: View {
    var body: some View {
        NavigationStack {
            List {
                ForEach(1..<10) { _ in
                    VStack(alignment: .leading){
                        HStack {
                            Image(systemName: "heart.fill")
                            Text("Welcome to SwiftUI")
                        }
                        .font(.title)
                        
                        Text("This is some longer text that expands to multiple lines.")
                            .font(.subheadline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .lineLimit(3)
                            .minimumScaleFactor(0.8)
                    }
                    .background(Color.red)
                }
            }
            .navigationTitle("Accesiblity Text")
            .listStyle(PlainListStyle())
        }
    }
}

#Preview {
    AccesibilityTextBootcamp()
}
