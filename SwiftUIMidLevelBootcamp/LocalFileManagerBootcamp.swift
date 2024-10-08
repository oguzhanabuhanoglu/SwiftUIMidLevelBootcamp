//
//  LocalFileManagerBootcamp.swift
//  SwiftUIMidLevelBootcamp
//
//  Created by Oğuzhan Abuhanoğlu on 8.10.2024.
//

import SwiftUI

class LocalFileManager {
    
    static let instance = LocalFileManager()
    var folderName: String = "MyApp_Images"
    
    init() {
        createFolderIfNeeded()
    }
    
    func createFolderIfNeeded() {
        guard let path = FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appending(path: folderName)
            .path  else {
            return
        }
        
        if !FileManager.default.fileExists(atPath: path) {
            do {
                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
                print("Successfully created folder.")
            } catch let error {
                print("Error creating folder: \(error)")
            }
        }
        
    }
    
    func saveImage(image: UIImage, name: String) -> String {
        
        guard let data = image.jpegData(compressionQuality: 0.5),
              let path = getPathForImage(name: name) else {
            return "Error getting image."
        }
        
        // MARK: Directory types.
        /*
//       Documents Directory: Uzun süreli ve kullanıcı tarafından oluşturulan veriler.
       let directory2 = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

//       Temporary Directory: Kısa süreli, sadece geçici olarak gerekli olan veriler.
        let directory3 = FileManager.default.temporaryDirectory
        */
        
        // Caches Directory: Yeniden üretilebilecek geçici veriler.
        /*
        let directory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
        let path = directory?.appending(path: "\(name).jpeg")
        */
        
        do {
            try data.write(to: path)
            return "Success saving."
        } catch let error {
            return "Error saving"
        }
        
    }
    
    
    func getImage(name: String) -> UIImage? {
        guard let path = getPathForImage(name: name)?.path(),
              FileManager.default.fileExists(atPath: path) else {
            return nil
        }
        return UIImage(contentsOfFile: path)
    }
    
    
    func deleteImage(name: String) -> String {
        guard let path = getPathForImage(name: name)?.path(),
              FileManager.default.fileExists(atPath: path) else {
            return "Error getting path"
        }
        
        do {
            try FileManager.default.removeItem(atPath: path)
            return "Successfully deleted."
        } catch let error {
            return "Error deleting image."
        }
        
    }
    
    
    
    func getPathForImage(name: String) -> URL? {
        guard let path = FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appending(path: "\(name).jpeg") else {
            print("Error getting path")
            return nil
        }
        return path
    }
}



class FileManagerViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    let imageName: String = "me"
    let manager = LocalFileManager.instance
    @Published var infoMessage: String = ""
    
    init() {
        getImageFromAssets()
        //getImageFromFM()
    
    }
    
    func getImageFromAssets() {
        image = UIImage(named: imageName)
    }
    
    func saveImage() {
        guard let image = image else { return }
        infoMessage = manager.saveImage(image: image, name: imageName)
    }
    
    func getImageFromFM() {
        manager.getImage(name: imageName)
    }
    
    func deleteImageFromFM() {
        infoMessage = manager.deleteImage(name: imageName)
    }
    
}


struct LocalFileManagerBootcamp: View {
    
    @StateObject var vm = FileManagerViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if let image = vm.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .cornerRadius(10)
                }
                
                HStack {
                    Button {
                        vm.saveImage()
                    } label: {
                        Text("Save to FM")
                            .foregroundStyle(.white)
                            .font(.headline)
                            .padding(20)
                            .padding(.horizontal)
                            .background(Color.blue.cornerRadius(10))
                    }
                    
                    Button {
                        vm.deleteImageFromFM()
                    } label: {
                        Text("Delete Image")
                            .foregroundStyle(.white)
                            .font(.headline)
                            .padding(20)
                            .padding(.horizontal)
                            .background(Color.red.cornerRadius(10))
                    }
                }
                
                Text(vm.infoMessage)
                    .font(.largeTitle)
                    .foregroundStyle(.purple)
                Spacer()
            }
            .navigationTitle("Local FileManager")
        }
    }
}

#Preview {
    LocalFileManagerBootcamp()
}
