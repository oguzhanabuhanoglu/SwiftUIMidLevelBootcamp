//
//  AnimationWithTimer.swift
//  SwiftUIMidLevelBootcamp
//
//  Created by Oğuzhan Abuhanoğlu on 8.10.2024.
//

import SwiftUI

struct AnimationWithTimer: View {
    
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    @State var count: Int = 1
    
    var body: some View {
        ZStack {
            RadialGradient(colors: [Color(#colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)), Color(#colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1))],
                           center: .center,
                           startRadius: 5,
                           endRadius: 500)
            .ignoresSafeArea()
            
            TabView(selection: $count) {
                Rectangle()
                    .foregroundStyle(.yellow)
                    .tag(1)
                Rectangle()
                    .foregroundStyle(.green)
                    .tag(2)
                Rectangle()
                    .foregroundStyle(.red)
                    .tag(3)
                Rectangle()
                    .foregroundStyle(.blue)
                    .tag(4)
                Rectangle()
                    .foregroundStyle(.pink)
                    .tag(5)
                
            }
            .frame(maxWidth: .infinity)
            .frame(height: 300)
            .tabViewStyle(.page)
        }
        .onReceive(timer) { _ in
            withAnimation(.spring()) {
                count = count == 5 ? 1 : count + 1
            }
            
        }
    }
    
    
    
}

#Preview {
    AnimationWithTimer()
}
