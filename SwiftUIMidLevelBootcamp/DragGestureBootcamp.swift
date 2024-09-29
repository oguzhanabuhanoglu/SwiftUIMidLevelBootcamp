//
//  DragGestureBootcamp.swift
//  SwiftUIMidLevelBootcamp
//
//  Created by Oğuzhan Abuhanoğlu on 29.09.2024.
//

import SwiftUI

struct DragGestureBootcamp: View {
    
    @State var offset: CGSize = .zero
    
    var body: some View {
        // MARK: Real word example - like tinder
        ZStack {
            VStack {
                Text("Offset: \(offset.width)")
                Spacer()
            }
                RoundedRectangle(cornerRadius: 20)
                    .fill()
                    .frame(width: 300, height: 500)
                    .offset(offset)
                    .scaleEffect(getScaleAmount())
                    .rotationEffect(Angle(degrees: getRotationAmount()))
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                withAnimation(.spring()) {
                                    offset = value.translation
                                }
                            }
                            .onEnded { value in
                                withAnimation(.spring()) {
                                    offset = .zero
                            }
                        }
                )
        }
        
        // MARK: Basic usage
//        RoundedRectangle(cornerRadius: 10)
//            .frame(width: 100, height: 100)
//            .offset(offset)
//            .gesture(
//                DragGesture()
//                    .onChanged { value in
//                        offset = value.translation
//                    }
//                    .onEnded { value in
//                        withAnimation(.spring()) {
//                            offset = .zero
//                        }
//                    }
//            )
        
    }
    
    func getScaleAmount() -> CGFloat {
        let max = UIScreen.main.bounds.width / 2
        // abs değeri mutlak değer yapar.
        let currentAmount = abs(offset.width)
        let percentage = currentAmount / max
        return 1.0 - min(percentage, 0.3)
    }
    
    func getRotationAmount() -> Double {
        let max = UIScreen.main.bounds.width / 2
        let currentAmount = offset.width
        let percaentage = currentAmount / max
        let percentageAsDouble: Double = Double(percaentage)
        let maxAngle: Double = 10
        return percentageAsDouble * maxAngle
    }
    
    
}

#Preview {
    DragGestureBootcamp()
}
