//
//  NotificatiionExt.swift
//  VisionBank
//
//  Created by Sivakumar R on 21/04/20.
//  Copyright © 2020 Interakt. All rights reserved.
//

import Foundation
import UserNotifications
import REIOSSDK
import Firebase


@available(iOS 10.0, *)

extension AppDelegate {
    
     public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        REiosHandler.setForegroundNotification(data: notification) { handler in
            completionHandler(handler)
        }
    }
    
     public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        REiosHandler.setNotificationAction(response: response)
        completionHandler()
    }
}

extension AppDelegate {
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase registration token: \n \(fcmToken)")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        if let _userInfo = userInfo as? [String: Any] {
            REiosHandler.setCustomNotification(userInfo: _userInfo)
        }
        completionHandler(.newData)
    }
}


// MARK:- Push notification
extension AppDelegate {
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("**** \n Filed to register \( error.localizedDescription) \n **** End ")
    }
    
    func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
        print("**** \n FCM refresh token \n \(fcmToken) \n **** End ")
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        Messaging.messaging().apnsToken = deviceToken
        
        let tokenString = deviceToken.reduce("") { string, byte in
            string + String(format: "%02X", byte)
        }
        print("**** \n Apns token: \n \(tokenString) \n **** End ")
        
        if let _fcmToken = Messaging.messaging().fcmToken {
            print("**** \n Fcm token: \n \(_fcmToken) \n **** End ")
        }
    }
}




