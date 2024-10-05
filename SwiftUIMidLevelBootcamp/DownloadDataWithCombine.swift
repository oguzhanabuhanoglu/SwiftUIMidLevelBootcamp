//
//  DownloadDataWithCombine.swift
//  SwiftUIMidLevelBootcamp
//
//  Created by Oğuzhan Abuhanoğlu on 5.10.2024.
//

import SwiftUI
import Combine

struct PostModelC: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class CombineViewModel: ObservableObject {
    
    @Published var posts: [PostModelC] = []
    var cancellables = Set<AnyCancellable>()
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        // MARK: Combine discussion
        /*
        // 1. sign up for monthly subscription for package to be delivered.
        // 2. the company would make the package behind the scene
        // 3. receive the package at your front door.
        // 4. make sure the box is not damaged.
        // 5. open and make sure the item is correct
        // 6. use the item!!
        // 7. cancellable at any time.
        
        // 1. create the publisher.
        // 2. .subscribe publisher on background thread.
        // 3. .receive on main thread
        // 4. .tryMap (check that the data is good)
        // 5. .decode (decode data into model)
        // 6. .sink (put the item into app)
        // 7. .store (cancel subscription if needed)
        */
        
        URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: [PostModelC].self, decoder: JSONDecoder())
            .replaceError(with: []) // if there is an error show blank array to handle the completion
            .sink(receiveValue: { [weak self] returnedPosts in
                self?.posts = returnedPosts
            })
            .store(in: &cancellables)
        
        // Same code with explanations.
        /*
        URLSession.shared.dataTaskPublisher(for: url)
            //.subscribe(on: DispatchQueue.global(qos: .background)) // publisher already did this by itself.
            .receive(on: DispatchQueue.main)
//            .tryMap { (data, response) -> Data in
//                guard let response = response as? HTTPURLResponse,
//                      response.statusCode < 300 && response.statusCode >= 200 else {
//                    throw URLError(.badServerResponse)
//                }
//                return data
//            }
            .tryMap(handleOutput)
            .decode(type: [PostModelC].self, decoder: JSONDecoder())
//            .sink { (completion) in
//                switch completion {
//                case .finished:
//                    print("finished")
//                case .failure(let error):
//                    print("Error: \(error)")
//                }
//            } receiveValue: { [weak self] returnedPosts in
//                self?.posts = returnedPosts
//            }
            .replaceError(with: []) // if there is an error show blank array to handle the completion
            .sink(receiveValue: { [weak self] returnedPosts in
                self?.posts = returnedPosts
            })
            .store(in: &cancellables)
         */
    }
    
    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode < 300 && response.statusCode >= 200 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
    
}

struct DownloadDataWithCombine: View {
    
    @StateObject var vm = CombineViewModel()
    
    var body: some View {
        List {
            ForEach(vm.posts) { post in
                VStack(alignment: .leading) {
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
                        .foregroundStyle(.gray)
                }
            }
        }
    }
}

#Preview {
    DownloadDataWithCombine()
}
