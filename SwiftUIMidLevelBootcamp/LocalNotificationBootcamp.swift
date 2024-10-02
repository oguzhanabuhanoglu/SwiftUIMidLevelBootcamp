//
//  LocalNotificationBootcamp.swift
//  SwiftUIMidLevelBootcamp
//
//  Created by Oğuzhan Abuhanoğlu on 2.10.2024.
//

import SwiftUI
import NotificationCenter
import CoreLocation

class NotificationManager {
    
    static let instance = NotificationManager()
    
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if success {
                print("success")
            } else {
                print("ERROR: \(error?.localizedDescription ?? "ERROR") ")
            }
        }
    }
    
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "This is my firt notification!"
        content.subtitle = "It was sooo easy..."
        content.sound = .default
        content.badge = 1
        
        // MARK: TIME
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
        
        // MARK: CALENDAR
        var dateComponent = DateComponents()
        dateComponent.hour = 23
        dateComponent.minute = 14
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: true)
        
        // MARK: LOCATION
//        let coordinate = CLLocationCoordinate2D(latitude: 41.0385, longitude: 28.9785)
//        let region = CLCircularRegion(center: coordinate, radius: 100, identifier: UUID().uuidString)
//        region.notifyOnEntry = true
//        region.notifyOnExit = true
//        let trigger = UNLocationNotificationTrigger(region: region, repeats: true)
//        
        
        
        
        let request = UNNotificationRequest(identifier: UUID().uuidString,
                                            content: content,
                                            trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
    func cancelNotification() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
    
    func setBadgeCount() {
        UNUserNotificationCenter.current().setBadgeCount(0) { error in
            guard let error else {
              return
            }
            print(error)
        }
    }
    
}

struct LocalNotificationBootcamp: View {
    var body: some View {
        VStack {
            Button("Local Notification") {
                NotificationManager.instance.scheduleNotification()
            }
            
            Button("Cancel Notification") {
                NotificationManager.instance.cancelNotification()
            }
        }
        .onAppear {
            NotificationManager.instance.requestAuthorization()
//            UIApplication.shared.applicationIconBadgeNumber = 0 // Deprecated
            NotificationManager.instance.setBadgeCount()
            
        }
    }
}

#Preview {
    LocalNotificationBootcamp()
}
