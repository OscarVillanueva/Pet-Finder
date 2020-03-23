//
//  AppDelegate.swift
//  Pet-Finder
//
//  Created by Oscar Villanueva on 21/03/20.
//  Copyright © 2020 Oscar Villanueva. All rights reserved.
//

import UIKit

// Toma el ciclo de vida de la app

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private let solar = Solar(for: Date(), latitude: 20.4887879, longitude: -100.9604602)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        initThemes()
        return true
    }
    
    func initThemes() {
        if solar!.isDaytime {
            Theme.current.apply()
            scheduleThemeTimer()
        }
        else {
            Theme.dark.apply()
        }
    }
    
    func scheduleThemeTimer(){
        let timer = Timer(fire: solar!.sunset!, interval: 0, repeats: false) { [weak self] _ in
            Theme.dark.apply()
            
            self?.window?.subviews.forEach({ (view: UIView) in
                view.removeFromSuperview()
                self?.window?.addSubview(view)
            })
        }
        
        RunLoop.main.add(timer, forMode: RunLoop.Mode.common)
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

