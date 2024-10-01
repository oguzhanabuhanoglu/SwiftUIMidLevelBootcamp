//
//  HapticsBootcamp.swift
//  SwiftUIMidLevelBootcamp
//
//  Created by Oğuzhan Abuhanoğlu on 1.10.2024.
//

import SwiftUI

class HapticManager {
    
    static let shared = HapticManager()
    
    func natification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}

struct HapticsBootcamp: View {
    var body: some View {
        VStack(spacing: 40) {
            Button("success") { HapticManager.shared.natification(type: .success) }
            Button("warning") { HapticManager.shared.natification(type: .warning) }
            Button("error") { HapticManager.shared.natification(type: .error) }
            Divider()
            Button("heavy") { HapticManager.shared.impact(style: .heavy) }
            Button("light") { HapticManager.shared.impact(style: .light) }
            Button("medium") { HapticManager.shared.impact(style: .medium) }
            Button("rigid") { HapticManager.shared.impact(style: .rigid) }
            Button("soft") { HapticManager.shared.impact(style: .soft) }
            
        }
    }
}

#Preview {
    HapticsBootcamp()
}
