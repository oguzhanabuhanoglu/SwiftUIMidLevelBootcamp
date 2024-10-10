//
//  CacheBootcamp.swift
//  SwiftUIMidLevelBootcamp
//
//  Created by Oğuzhan Abuhanoğlu on 9.10.2024.
//

import SwiftUI

class CacheManager {

    static let instance = CacheManager()
    
    private init() {}
    
    var imageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 100
        return cache
    }()
    
    func save(image: UIImage, name: String) -> String {
        imageCache.setObject(image, forKey: name as NSString)
        return "Succesfully saved."
    }
    
    func remove(name: String) -> String {
        imageCache.removeObject(forKey: name as NSString)
        return "Succesfully removed."
    }
    
    func get(name: String) -> UIImage? {
        imageCache.object(forKey: name as NSString)
    }
    
    
}

class CacheViewModel: ObservableObject {
    
    @Published var manager = CacheManager.instance
    @Published var startingImage: UIImage? = nil
    @Published var cachedImage: UIImage? = nil
    @Published var infoMessage: String = ""
    let imageName: String = "me"
    
    init() {
        getImageFromAssets()
    }
    
    func getImageFromAssets() {
        startingImage = UIImage(named: imageName)
    }
    
    func saveToCache() {
        guard let image = startingImage else { return }
        infoMessage = manager.save(image: image, name: imageName)
    }
    
    func removeFromCache() {
        infoMessage = manager.remove(name: imageName)
    }
    
    func getFromCache() {
        if let returnedImage = manager.get(name: imageName) {
            cachedImage = returnedImage
            infoMessage = "Image retrieved from cache"
        } else {
            infoMessage = "Failed when get image from cache"
        }
    }
    
    
}

struct CacheBootcamp: View {
    
    @StateObject var vm = CacheViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if let image = vm.startingImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .cornerRadius(10)
                }
                
                HStack {
                    Button {
                        vm.saveToCache()
                    } label: {
                        Text("Save to Cache")
                            .font(.headline)
                            .foregroundStyle(.white)
                            .padding()
                            .background(Color.blue.cornerRadius(10))
                    }
                    
                    Button {
                        vm.removeFromCache()
                    } label: {
                        Text("Delete From Cache")
                            .font(.headline)
                            .foregroundStyle(.white)
                            .padding()
                            .background(Color.red.cornerRadius(10))
                    }
                }
                
                Button {
                    vm.getFromCache()
                } label: {
                    Text("Get From Cache")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .padding()
                        .background(Color.green.cornerRadius(10))
                }
                
                Text(vm.infoMessage)
                    .font(.largeTitle)
                    .foregroundStyle(.purple)

                if let image = vm.cachedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .cornerRadius(10)
                }
                
                Spacer()
            }
            .navigationTitle("Cache Bootcamp")
        }
    }
}

#Preview {
    CacheBootcamp()
}
