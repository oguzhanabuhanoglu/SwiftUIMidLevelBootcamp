//
//  EscapingBootcamp.swift
//  SwiftUIMidLevelBootcamp
//
//  Created by Oğuzhan Abuhanoğlu on 4.10.2024.
//

import SwiftUI

class EscapingViewModel: ObservableObject {
    
    @Published var data: String = "DATA"
    
    func getData() {
//     1) let newData = downloadData()
//        data = newData
        
//     2) downloadData3 { returnedData in
//            data = returnedData
//        }
        
//      3)  downloadData4 { [weak self] returnedData in
//            self?.data = returnedData
//        }
        
        downloadData5 { [weak self] result in
            self?.data = result.data
        }
    }
    
    
    // 1) This is regular func.
    /*
     func downloadData() -> String {
        return "NEW DATA"
    }
     
     // We can not use this regualar return for async action. This example to see it.
     /*
     func downloadData2() -> String {
         DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
             return "NEW DATA 2"
         }
      }
      */
    */
     
    
    // 2) That's how to use completion handler but still we can not do anything async.
    /*
     func downloadData3(completionHandler: (_ data: String) -> Void) {
        completionHandler("NEW DATA")
    }
    */
    
    // 3) That's the way to make async with escaping.
    /*
     func downloadData4(completionHandler: @escaping (_ data: String) -> Void) {
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 2) {
            completionHandler("NEW DATA")
        }
    }
     */
    
    struct Model {
        let data: String
    }
    
    // if we have data model we can use like that.
    func downloadData5(completionHandler: @escaping (Model) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completionHandler(Model(data: "NEWDATA"))
        }
    }
    
    
    // Cleaner code with typealias.
    typealias DownloadCompletion = (Model) -> Void
    
    func downloadData6(completionHandler: @escaping DownloadCompletion) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completionHandler(Model(data: "NEWDATA"))
        }
    }
    
    
}

struct EscapingBootcamp: View {
    
    @StateObject var vm = EscapingViewModel()

    var body: some View {
        VStack {
            Text(vm.data)
                .foregroundStyle(.blue)
                .font(.largeTitle)
                .fontWeight(.semibold)
                .onTapGesture {
                    vm.getData()
                }
        }
    }
}

#Preview {
    EscapingBootcamp()
}
