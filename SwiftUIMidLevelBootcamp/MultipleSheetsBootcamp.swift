//
//  MultipleSheetsBootcamp.swift
//  SwiftUIMidLevelBootcamp
//
//  Created by Oğuzhan Abuhanoğlu on 30.09.2024.
//

import SwiftUI

struct RandomModel: Identifiable {
    let id = UUID().uuidString
    let name: String
}

struct MultipleSheetsBootcamp: View {
    
    @State var selectedModel: RandomModel? = nil
    
    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                ForEach(1..<30) { index in
                    Button("Button: \(index)") {
                        selectedModel = RandomModel(name: "\(index)")
                    }
                }
            }
            .sheet(item: $selectedModel) { model in
                Text("\(model.name)")
            }
        }
    }
}

#Preview {
    MultipleSheetsBootcamp()
}
