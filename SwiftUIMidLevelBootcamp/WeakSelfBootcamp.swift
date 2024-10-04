//
//  WeakSelfBootcamp.swift
//  SwiftUIMidLevelBootcamp
//
//  Created by Oğuzhan Abuhanoğlu on 3.10.2024.
//

import SwiftUI

struct WeakSelfBootcamp: View {
    
    @AppStorage("count") var count: Int = 0
    
    var body: some View {
        
        NavigationView {
            NavigationLink("Navigate") {
                SecondScreen()
            }
            .navigationTitle("Screen 1")
        }
        .overlay(
            Text("\(count)")
                .font(.largeTitle)
                .padding()
                .background(.green)
                .padding(.top),
            alignment: .topTrailing
        )

    }
}

struct SecondScreen: View {
    
    @StateObject var vm = SecondScreenViewModel()
    
    var body: some View {
        VStack {
            Text("Second Screen")
                .font(.largeTitle)
            
            if let data = vm.data {
                Text(data)
                    .foregroundStyle(.red)
            }
        }
        
        
            
        
    }
}

class SecondScreenViewModel: ObservableObject {
    
    @Published var data : String? = nil
    
    init() {
        print("INITILIAZE NOW")
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentCount + 1, forKey: "count")
        getData()
    }
    
    deinit {
        print("DEINITIALIZE NOW")
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentCount - 1, forKey: "count")
    }
    
    func getData() {
        // if we use self here, that's mean is this view will stay open until closure complete. It' not gonna deinit.
        
//        DispatchQueue.global().async {
//            self.data = "NEW DATA!!!"
//        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 500) { [weak self] in
            self?.data = "NEW DATA!!!"
        }
       
    }
    
}

#Preview {
    WeakSelfBootcamp()
}
