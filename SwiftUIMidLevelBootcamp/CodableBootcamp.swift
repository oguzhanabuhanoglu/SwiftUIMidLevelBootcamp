//
//  CodableBootcamp.swift
//  SwiftUIMidLevelBootcamp
//
//  Created by Oğuzhan Abuhanoğlu on 4.10.2024.
//

// MARK: NOTES
/*
 ENCODE -> Swift Object to JSON or Other Format
 let jsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: [])
 
 DECODE -> JSON or Other Format to Swift Object
 let decoder = JSONDecoder()

 if let user = try? decoder.decode(User.self, from: jsonData) {
     print(user)  // User(id: "1", name: "Oğuzhan", points: 100, isPremium: true)
 }
 */

import SwiftUI

struct CustomerModel: Identifiable, Codable /*Decodable, Encodable*/ {
    let id: String
    let name: String
    let points: Int
    let isPremium: Bool
    
    // MARK: When we use juct CODABLE Protocol instead of use DECODABLE OR ENCODABLE we do not need all of theese anymore.
//    init(id: String, name: String, points: Int, isPremium: Bool) {
//        self.id = id
//        self.name = name
//        self.points = points
//        self.isPremium = isPremium
//    }
//    
//    enum CodingKeys: CodingKey {
//        case id
//        case name
//        case points
//        case isPremium
//    }
//    
//    init(from decoder: any Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.id = try container.decode(String.self, forKey: .id)
//        self.name = try container.decode(String.self, forKey: .name)
//        self.points = try container.decode(Int.self, forKey: .points)
//        self.isPremium = try container.decode(Bool.self, forKey: .isPremium)
//    }
//    
//    func encode(to encoder: any Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(self.id, forKey: .id)
//        try container.encode(self.name, forKey: .name)
//        try container.encode(self.points, forKey: .points)
//        try container.encode(self.isPremium, forKey: .isPremium)
//    }
    
}

class CodableViewModel: ObservableObject {
    
    @Published var customer: CustomerModel? = nil
    
    init() {
        getData()
    }
    
    func getData() {
        guard let data = getMockJson() else { return }
        
        do {
            self.customer = try? JSONDecoder().decode(CustomerModel.self, from: data)
        } catch let error {
            print("error decoding: \(error)")
        }
        
        // MARK: Decodin manually
        // This for before decoder init.
        //        if
        //            let localData = try? JSONSerialization.jsonObject(with: data, options: []),
        //            let dictionary = localData as? [String: Any],
        //
        //            let id = dictionary["id"] as? String,
        //            let name = dictionary["name"] as? String,
        //            let points = dictionary["points"] as? Int,
        //            let isPremium = dictionary["isPremium"] as? Bool {
        //
        //            let newCustomer = CustomerModel(id: id, name: name, points: points, isPremium: isPremium)
        //            customer = newCustomer
        //         }
    }
    
    func getMockJson() -> Data? {
        let customer = CustomerModel(id: "2", name: "yaren", points: 123, isPremium: false)
        let jsonData = try? JSONEncoder().encode(customer)
        
        // MARK: Encoding manually
//        let dictionary: [String: Any] = [
//            "id": "1",
//            "name": "Oğuzhan",
//            "points": 100,
//            "isPremium": true
//        ]
//        let jsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: [])
        return jsonData
    }
}

    
    
    


struct CodableBootcamp: View {
    
    @StateObject var vm = CodableViewModel()
    
    var body: some View {
        VStack {
            if let customer = vm.customer {
                Text(customer.id)
                Text(customer.name)
                Text("\(customer.points)")
                Text(customer.isPremium.description)
            }
            
        }
    }
}

#Preview {
    CodableBootcamp()
}
