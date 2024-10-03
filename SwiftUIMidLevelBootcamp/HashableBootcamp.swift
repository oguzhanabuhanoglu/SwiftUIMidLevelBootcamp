//
//  HashableBootcamp.swift
//  SwiftUIMidLevelBootcamp
//
//  Created by Oğuzhan Abuhanoğlu on 3.10.2024.
//

import SwiftUI


// MARK: MODELS
struct MyCustomModel2: Hashable {
    let title: String
}

struct MyCustomModel: Identifiable {
    let id = UUID().uuidString
    let title: String
}



struct HashableBootcamp: View {
    
    let hashableData: [MyCustomModel2] = [
        MyCustomModel2(title: "ONE"),
        MyCustomModel2(title: "TWO"),
        MyCustomModel2(title: "THREE"),
        MyCustomModel2(title: "FOUR"),
        MyCustomModel2(title: "FIVE")
    ]
    
    let identifiableData: [MyCustomModel] = [
        MyCustomModel(title: "ONE"),
        MyCustomModel(title: "TWO"),
        MyCustomModel(title: "THREE"),
        MyCustomModel(title: "FOUR"),
        MyCustomModel(title: "FIVE")
    ]
    
    let stringData: [String] = [
        "ONE", "TWO", "THREE", "FOUR", "FIVE"
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 100) {
                
                // customModel should comform to hashable. it's actually works like identifiable.
                VStack{
                    ForEach(hashableData, id: \.self) { item in
                        Text(item.title)
                            .font(.headline)
                    }
                }
                
                
            
                // identifiable
                VStack {
                    ForEach(identifiableData) { item in
                        Text(item.title)
                            .font(.headline)
                    }
                }
                

                
                // it works because [String] is already comform to HASHABLE.
                VStack {
                    ForEach(stringData, id: \.self) { item in
                        Text(item)
                            .font(.headline)
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    HashableBootcamp()
}
