//
//  SceneDelegate.swift
//  VisionBankNew
//
//  Created by Sivakumar R on 21/10/20.
//

import UIKit
import REIOSSDK


@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
//        if let userActivity = connectionOptions.userActivities.first {
//            self.scene(scene, continue: userActivity)
//        }
        
        guard let _ = (scene as? UIWindowScene) else { return }
        
        if let windowScene = scene as? UIWindowScene {
            
            window = UIWindow(windowScene: windowScene)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "nav")
            window?.rootViewController = controller
            window?.makeKeyAndVisible()
        }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    func scene(_ scene: UIScene, willContinueUserActivityWithType userActivityType: String) {
        
        print("User activity type \(userActivityType)")
    }
    
    func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
        print("User activity type \(String(describing: userActivity.webpageURL))")
        
        REiosHandler.handleDynamicLinkWith(userActivity: userActivity, successHandler: { data in
            print("Universal link data received \(data)")
            
        }) { error in
            print("Universal link data error \(error)")
        }
        
    }
    
    func scene(_ scene: UIScene, didFailToContinueUserActivityWithType userActivityType: String, error: Error) {
        print("deeplink error \(error)")
    }
    
    func scene(_ scene: UIScene, didUpdate userActivity: NSUserActivity) {
        print("deeplink update \(userActivity.activityType)")
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        print("open url \(String(describing: scene.userActivity?.webpageURL))")
    }
}

