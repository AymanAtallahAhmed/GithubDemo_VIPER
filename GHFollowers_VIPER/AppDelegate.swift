//
//  AppDelegate.swift
//  GHFollowers_VIPER
//
//  Created by Ayman Ata on 4/24/21.
//  Copyright © 2021 Ayman Ata. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow.init()
        
        //let navController: UINavigationController = .init()
        let homeVC = SearchRouter.createModule()
        
        window?.rootViewController = homeVC
        window?.makeKeyAndVisible()
        return true
    }

}

