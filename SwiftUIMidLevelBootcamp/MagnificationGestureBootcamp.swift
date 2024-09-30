//
//  MagnificationGestureBootcamp.swift
//  SwiftUIMidLevelBootcamp
//
//  Created by Oğuzhan Abuhanoğlu on 29.09.2024.
//

import SwiftUI

struct MagnificationGestureBootcamp: View {
    
    @State var currentAmount: CGFloat = 0
    @State var lastAmount: CGFloat = 0
    
    var body: some View {
        // MARK: Reel word example
        VStack(spacing: 10) {
            HStack {
                Circle()
                    .fill()
                    .frame(width: 35, height: 35)
                Text("Oğuzhan Abuhanoğlu")
                    .fontWeight(.semibold)
                Spacer()
                Image(systemName: "ellipsis")
            }
            .padding(.horizontal)
            
            Rectangle()
                .fill()
                .frame(height: 400)
                .scaleEffect(1 + currentAmount)
                .gesture(
                    MagnificationGesture()
                        .onChanged { value in
                            currentAmount = value - 1
                        }
                        .onEnded { value in
                            withAnimation(.spring()) {
                                currentAmount = 0
                            }
                            
                        }
                )
            
            HStack {
                Image(systemName: "heart.fill")
                Image(systemName: "text.bubble.fill")
                Spacer()
            }
            .font(.headline)
            .padding(.horizontal)
            
            Text("This is the caption for my post!")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
        }
        
        
        // MARK: Basic usage
//        Text("Hello, World!")
//            .font(.title)
//            .padding(40)
//            .background(Color.red.cornerRadius(10))
//            .scaleEffect(1 + currentAmount + lastAmount)
//            .gesture(
//                MagnificationGesture()
//                    .onChanged{ value in
//                        currentAmount = value - 1
//                    }
//                    .onEnded{ value in
//                        lastAmount += currentAmount
//                        currentAmount = 0
//                    }
//            )
    }
}

#Preview {
    MagnificationGestureBootcamp()
}
