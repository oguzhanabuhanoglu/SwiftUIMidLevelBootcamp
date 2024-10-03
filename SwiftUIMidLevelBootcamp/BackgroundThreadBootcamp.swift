//
//  BackgroundThreadBootcamp.swift
//  SwiftUIMidLevelBootcamp
//
//  Created by Oğuzhan Abuhanoğlu on 3.10.2024.
//

import SwiftUI
// open the debug navigator from navigator inspector to see which thread you using.

class BackgroundThread: ObservableObject {
    
    @Published var dataArray: [String] = []
    
    func fetchData() {
        // Download data should work on backgroun thread to keep your app fast.
        DispatchQueue.global(qos: .background).async {
            let newData = self.downloadData()
            print("CHECK1: \(Thread.isMainThread)")
            print("CHECK1: \(Thread.current)")
            // But all the ui works should be on main thread. So download data and go back to main thread.
            DispatchQueue.main.async {
                self.dataArray = newData
                print("CHECK2: \(Thread.isMainThread)")
                print("CHECK2: \(Thread.current)")
            }
        }
        
        
        
    }
    
    func downloadData() -> [String] {
        var data: [String] = []
        for i in 1...100 {
            data.append("\(i)")
        }
        return data
    }
}

struct BackgroundThreadBootcamp: View {
    
    @StateObject var vm = BackgroundThread()
    
    var body: some View {
        ScrollView {
            LazyVStack {
                Text("LOAD DATA")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .onTapGesture {
                        vm.fetchData()
                    }
                
                ForEach(vm.dataArray, id: \.self) { item in
                    Text(item)
                        .font(.headline)
                        .foregroundStyle(Color.red)
                }
            }
        }
    }
}

#Preview {
    BackgroundThreadBootcamp()
}
