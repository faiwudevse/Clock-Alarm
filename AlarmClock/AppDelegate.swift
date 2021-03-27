//
//  AppDelegate.swift
//  AlarmClock
//
//  Created by Fai Wu on 11/18/19.
//  Copyright © 2019 Fai Wu. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    let coreData = CoreDataStack(modelName: "Model")!
    // var permission = false
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // set app delegate as notification center delegate
        UNUserNotificationCenter.current().delegate = self
        let defaults = UserDefaults.standard
        
        defaults.bool(forKey: Constants.UserDefaultSetting.hasLauched)
        let center = UNUserNotificationCenter.current()

        center.requestAuthorization(options: [.alert, .badge, .sound]) { (grant, error) in
            if grant {
                defaults.set(true,  forKey: Constants.UserDefaultSetting.permission)
            } else {
                defaults.set(false, forKey: Constants.UserDefaultSetting.permission)
            }
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    // called when user interacts with notification (app not running in foreground)
    func userNotificationCenter(_ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse, withCompletionHandler
        completionHandler: @escaping () -> Void) {
        goToDismissViewController()
        completionHandler()
    }

    // called if app is running in foreground when the notification arrive
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent
        notification: UNNotification, withCompletionHandler completionHandler:
        @escaping (UNNotificationPresentationOptions) -> Void) {
        goToDismissViewController()
        completionHandler([.alert, .badge, .sound])
    }
    
    private func goToDismissViewController() {
        print("goToDismissViewController")
        let mdvc = MotivationDismissViewController()
        
        UIApplication.shared.windows.first { $0.isKeyWindow }?.rootViewController = mdvc
        //UIApplication.shared.windows.first?.rootViewController = mdvc
        UIApplication.shared.windows.first { $0.isKeyWindow }?.makeKeyAndVisible()
        
    }
}

