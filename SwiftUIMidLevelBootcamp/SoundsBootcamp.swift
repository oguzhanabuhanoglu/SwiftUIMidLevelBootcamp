//
//  SoundsBootcamp.swift
//  SwiftUIMidLevelBootcamp
//
//  Created by Oğuzhan Abuhanoğlu on 1.10.2024.
//

import SwiftUI
import AVKit

class SoundManager {
    static let shared = SoundManager() // singleton
    
    var player: AVAudioPlayer?
    
    enum SoundOptions: String {
        case bruh
        case goat
    }
    
    func playSound(soundOptions: SoundOptions) {
        
        guard let url = Bundle.main.url(forResource: soundOptions.rawValue, withExtension: ".mp3") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print(error.localizedDescription)
        }
    }
    
}

struct SoundsBootcamp: View {
    var body: some View {
        VStack(spacing: 40) {
            Button("Sound 1") {
                SoundManager.shared.playSound(soundOptions: .bruh)
            }
            
            Button("Sound 2") {
                SoundManager.shared.playSound(soundOptions: .goat)
            }
        }
    }
}

#Preview {
    SoundsBootcamp()
}
