//
//  AppDelegate.swift
//  Video_Player
//
//  Created by Hsiao Ai LEE on 19/01/2018.
//  Copyright © 2018 Hsiao Ai LEE. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Setup rootViewController
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        let viewController = ViewController()
        let navigationViewController = UINavigationController(rootViewController: viewController)
        window?.rootViewController = navigationViewController
        
        // Setup IQKeyboard
        IQKeyboardManager.sharedManager().enable = true
        
        return true
    }
    
}
