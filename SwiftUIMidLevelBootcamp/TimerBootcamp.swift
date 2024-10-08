//
//  TimerBootcamp.swift
//  SwiftUIMidLevelBootcamp
//
//  Created by Oğuzhan Abuhanoğlu on 8.10.2024.
//

import SwiftUI

struct TimerBootcamp: View {
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    // Current Date Timer
    /*
    @State var currentDate: Date = Date()
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        //formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter
    }
     */
    
    // Countdown
    /*
    @State var count: Int = 10
    @State var finishedText: String? = nil
    */
    
    // Countdown to date
    @State var timeRemaining: String = ""
    let futureDate: Date = Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
    
    func updateTimeRemaining() -> String {
        let remaining = Calendar.current.dateComponents([.hour, .minute, .second], from: Date(), to: futureDate)
        let hours = remaining.hour ?? 0
        let minute = remaining.minute ?? 0
        let second = remaining.second ?? 0
        timeRemaining = "\(hours):\(minute):\(second)"
        return timeRemaining
    }
    
    var body: some View {
        
        ZStack {
            RadialGradient(colors: [Color(#colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)), Color(#colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1)) ],
                           center: .center,
                           startRadius: 5,
                           endRadius: 500).ignoresSafeArea()
            
//            Text(dateFormatter.string(from: currentDate))
//            Text(finishedText ?? "\(count)")
            Text(timeRemaining)
                .font(.system(size: 100, weight: .semibold, design: .rounded))
                .foregroundStyle(.white)
                .lineLimit(1)
                .minimumScaleFactor(0.1)
        }
//        .onReceive(timer) { value in
//            currentDate = value
//        }
        
//        .onReceive(timer) { _ in
//            if count <= 1 {
//                finishedText = "WOW!"
//            } else {
//                count -= 1
//            }
//        }
        .onReceive(timer) { _ in
            updateTimeRemaining()
        }
    }
}

#Preview {
    TimerBootcamp()
}
