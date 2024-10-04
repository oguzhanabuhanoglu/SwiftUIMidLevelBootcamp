//
//  LongPressGestureBootcamp.swift
//  SwiftUIMidLevelBootcamp
//
//  Created by Oğuzhan Abuhanoğlu on 29.09.2024.
//

import SwiftUI

struct LongPressGestureBootcamp: View {
    
    @State var isCompleted: Bool = false
    @State var isSuccess: Bool = false
    
    var body: some View {
        
        // MARK: Reel word example
        
        VStack {
            RoundedRectangle(cornerRadius: 0)
                .fill(isSuccess ? .green : .red)
                .frame(maxWidth: isCompleted ? .infinity : 0)
                .frame(height: 55)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.gray)
            
            HStack {
                Text("Long Press")
                    .foregroundStyle(.white)
                    .padding()
                    .padding(.horizontal)
                    .background(Color.black)
                    .cornerRadius(10)
                    .onLongPressGesture(minimumDuration: 1, maximumDistance: 50) { isPressing in
                        // start of press -> min duration
                        if isPressing {
                            withAnimation(.easeInOut(duration: 1.0)) {
                                isCompleted = true
                            }
                        } else {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                if !isSuccess {
                                    withAnimation(.easeInOut(duration: 1.0)) {
                                        isCompleted = false
                                    }
                                }
                                
                            }
                        }
                    } perform: {
                        // at the min duration
                        withAnimation(.easeInOut) {
                            isSuccess.toggle()
                        }
                        
                    }
                
                
                Text("Reset")
                    .foregroundStyle(.white)
                    .padding()
                    .padding(.horizontal)
                    .background(Color.black)
                    .cornerRadius(10)
                    .onTapGesture {
                        isSuccess = false
                        isCompleted = false
                    }
            }
                
                
        }
        
        
        // MARK: Basic usage
//        Text(isCompleted ? "Completed" : "Not Completed")
//            .padding()
//            .padding(.horizontal)
//            .background(isCompleted ? Color.green : Color.gray)
//            .cornerRadius(10)
////            .onTapGesture {
////                isCompleted.toggle()
////            }
//            .onLongPressGesture(minimumDuration: 2, maximumDistance: 30 perform: {
//                    isCompleted.toggle()
//            })
    }
}

#Preview {
    LongPressGestureBootcamp()
}
