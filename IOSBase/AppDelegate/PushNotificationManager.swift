//
//  PushNotificationManager.swift
//  WholesaleBox
//
//  Created by Dinesh Saini on 7/27/17.
//  Copyright © 2017 Wholesalebox. All rights reserved.
//

import UIKit
import UserNotifications

struct DeviceToken {
    let data: Data
    
    init(data: Data) {
        self.data = data
    }
}

extension DeviceToken: CustomStringConvertible {
    public var description: String {
        return data.map { String(format: "%.2hhx", $0) }.joined()
    }
}

struct PushNotificationManager {

    static func allowToPushNotification(with appDelegate: AppDelegate) {
        let application = UIApplication.shared
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.delegate = appDelegate
            center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
                if let error = error {
                    print(error)
                    return
                }
                
                if granted {
                    print("Push notification is granted")
                    application.registerForRemoteNotifications()
                } else {
                    print("Push notification is NOT granted")
                }
            }
        }
        else {
            let type: UIUserNotificationType = [.alert, .badge, .sound]
            let setting = UIUserNotificationSettings(types: type, categories: nil)
            application.registerUserNotificationSettings(setting)
        }
    }
    
    static func send(_ token: DeviceToken) {
        //Send device token to server        
        
    }

    static func handlePushNotification(_ userInfo: [AnyHashable: Any], state: UIApplicationState) {
        switch state {
        case .inactive:
            // Launch via push notification
            break
        case .active:
            break
        case .background:
            break
        }
    }

}

// MARK: - Push Notification
extension AppDelegate {
    
    // for iOS 9
        func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
            print(error)
        }
    //
    //    func application(_ application: UIApplication, didRegister notificationSettings: UIUserNotificationSettings) {
    //        application.registerForRemoteNotifications()
    //    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let token = DeviceToken(data: deviceToken)
        print(token)
        
        PushNotificationManager.send(token)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        print(userInfo)
        PushNotificationManager.handlePushNotification(userInfo, state: application.applicationState)
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse,withCompletionHandler completionHandler: @escaping () -> Void) {
        print("push notification is open")
        completionHandler()
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        if notification.request.trigger is UNPushNotificationTrigger {
            print("receive a push notification on foreground")
        } else {
            print("receive a local notification on foreground")
        }
        
        switch notification.request.identifier {
        case "alert":
            completionHandler([.alert])
        case "both":
            completionHandler([.alert, .sound])
        default: ()
        }
    }
}
