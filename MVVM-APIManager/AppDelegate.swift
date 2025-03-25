//
//  AppDelegate.swift
//  MVVM-APIManager
//
//  Created by Ghoshit.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //Set Api Environment
        AppConstants.setupAPI(env: .production)
        
        return true
    }

}

