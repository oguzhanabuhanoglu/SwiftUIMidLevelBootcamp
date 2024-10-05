//
//  DownloadDataW:Escaping.swift
//  SwiftUIMidLevelBootcamp
//
//  Created by Oğuzhan Abuhanoğlu on 4.10.2024.
//

import SwiftUI

struct PostModel: Codable, Identifiable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class DownloadDataViewModel: ObservableObject {
    
    @Published var posts: [PostModel] = []
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        downloadData(url: url) { returnedData in
            if let data = returnedData {
                // Decoding
                let decoder = JSONDecoder()
                guard let newPosts = try? decoder.decode([PostModel].self, from: data) else { return }
                // View codes should be on main thread.
                DispatchQueue.main.async { [weak self] in
                    self?.posts = newPosts
                }
            }
        }
        
    }
    

    
    func downloadData(url: URL, completionHandler: @escaping (_ data: Data?) -> ()) {
        
        // .dataTask is automaticlly goes on background thread.
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300,
                error == nil
            else {
                completionHandler(nil)
                print("Error downloading data.")
                return
            }
            
            completionHandler(data)
        }
        .resume()
    }
    
    
}

struct DownloadDataWithEscaping: View {

    @StateObject var vm = DownloadDataViewModel()

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
    DownloadDataWithEscaping()
}
