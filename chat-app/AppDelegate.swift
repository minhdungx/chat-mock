//
//  AppDelegate.swift
//  chat-app
//
//  Created by DungHM on 30/12/24.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        let vc = LoginViewController()
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        
        return true
    }
}


