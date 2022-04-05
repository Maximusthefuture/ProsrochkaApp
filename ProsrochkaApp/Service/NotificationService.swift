//
//  NotificationService.swift
//  ProsrochkaApp
//
//  Created by Maximus on 05.04.2022.
//

import Foundation
import UserNotifications

class NotificationService {
    
    static let shared = NotificationService()
    
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                completion(granted)
            }
    }
    
    func scheduleNotification(time: Date?, product: Product) {
        var trigger: UNCalendarNotificationTrigger?
        let content = UNMutableNotificationContent()
        content.title = product.name ?? "Title"
        content.body = product.productDescription ?? "Body"
        content.categoryIdentifier = "CategoryHere"
        if let date = time {
  
         trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents(
            [.month, .day, .year, .hour, .minute], from:  date), repeats: false)
        }
        
        let request = UNNotificationRequest(identifier: product.description, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error in adding notification", error)
            }
        }
    }
    
}
