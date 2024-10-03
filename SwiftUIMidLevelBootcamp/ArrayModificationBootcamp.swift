//
//  ArrayModificationBootcamp.swift
//  SwiftUIMidLevelBootcamp
//
//  Created by Oğuzhan Abuhanoğlu on 3.10.2024.
//

import SwiftUI
// This bootcamp inlude how to user sort, filter, map, compactMap in same function. Uncomment the line an try each of them.

struct UserModel: Identifiable {
    let id = UUID().uuidString
    let name: String?
    let points: Int
    let isVerified: Bool
}

class ArrayModificationViewModel: ObservableObject {
    
    @Published var users: [UserModel] = []
    @Published var filteredUsers: [UserModel] = []
    @Published var mappedUsers: [String] = []
    
    init() {
        getUsers()
        updateFilteredArray()
    }
    
    func getUsers() {
        let user1 = UserModel(name: "Oğuzhan", points: 70, isVerified: true)
        let user2 = UserModel(name: "Yaren", points: 40, isVerified: false)
        let user3 = UserModel(name: nil, points: 30, isVerified: false)
        let user4 = UserModel(name: "Hakan", points: 100, isVerified: true)
        let user5 = UserModel(name: "Arda", points: 10, isVerified: false)
        let user6 = UserModel(name: "Dobi", points: 130, isVerified: true)
        let user7 = UserModel(name: "Yusuf", points: 60, isVerified: true)
        let user8 = UserModel(name: "Mehmet", points: 23, isVerified: false)
        let user9 = UserModel(name: "Hamza", points: 74, isVerified: true)
        let user10 = UserModel(name: "Akif", points: 45, isVerified: false)
        users.append(contentsOf: [user1, user2, user3, user4, user5, user6, user7, user8, user9, user10])
    }
    
    func updateFilteredArray() {
        // MARK: SORT
        /*
         filteredUsers = users.sort { user1, user2 in
            return user1.points > user2.points
        }
    
        //advance verison
         filteredUsers = users.sort(by: { $0.points > $1.points })
        */
        
        // MARK: FILTER
        /*
        filteredUsers = users.filter { user in
            return user.points > 100
        }
        
        // advance
        filteredUsers = users.filter({ $0.points > 50})
        */
        
        // MARK: MAP -> Convert data type.
        /*
        mappedUsers = users.map { user in
            return user.name
        }
        
        mappedUsers = users.map({ $0.name })
         */
        
        // MARK: COMPACT MAP -> if name is optional in userModel, user compatMap for mapping.
        mappedUsers = users.compactMap({ $0.name })
        
        
        
    }
}

struct ArrayModificationBootcamp: View {
    
    @ObservedObject var vm = ArrayModificationViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
//                ForEach(vm.filteredUsers) { user in
//                    VStack(alignment: .leading) {
//                        Text(user.name)
//                            .font(.headline)
//                            .fontWeight(.semibold)
//                        
//                        HStack {
//                            Text("Points: \(user.points)")
//                            Spacer()
//                            if user.isVerified {
//                                Image(systemName: "flame.fill")
//                            }
//                        }
//                        
//                    }
//                    .foregroundStyle(Color.white)
//                    .padding()
//                    .background(Color.blue)
//                    .cornerRadius(10)
//                    .padding(.horizontal)
//                    
//                }
                
                ForEach(vm.mappedUsers, id: \.self) { name in
                    Text(name)
                        .font(.largeTitle)
                }
            }
        }
    }
}

#Preview {
    ArrayModificationBootcamp()
}
