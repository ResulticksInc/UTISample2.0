//
//  AppDelegate.swift
//  TestProject
//
//  Created by Rajaram on 26/02/20.
//  Copyright © 2020 Rajaram. All rights reserved.
//

import UIKit
import REIOSSDK
import UserNotifications
import Firebase

//@available(iOS 10.0, *)
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, REiosSmartLinkReceiver, REiosNotificationReceiver {

var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "nav")
        window?.rootViewController = controller
        window?.makeKeyAndVisible()

//        UNUserNotificationCenter.current().delegate = self
//        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
//        UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { (isAllow, error) in
//
//            if isAllow {
//                self.setDelegateFunctions()
//            }
//
//        }
        
//        UIApplication.shared.registerForRemoteNotifications()
        setDelegateFunctions()
        initResulticksSdk()
        
        return true
    }
    
    private func setDelegateFunctions() {
        
        UNUserNotificationCenter.current().delegate = self
        Messaging.messaging().delegate = self as? MessagingDelegate
        REiosHandler.smartLinkDelegate = self
        REiosHandler.notificationDelegate = self
    }
    
    override init() {
        super.init()
        /* Firebase Init */
        FirebaseApp.configure()
    }
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        
        setDelegateFunctions()
        initResulticksSdk()

        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

extension AppDelegate {
    
    //MARK: - Open link delegate
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        
        print(url)
        
        return true
    }
    func applicationDidBecomeActive(_ application: UIApplication) {

    }
}




