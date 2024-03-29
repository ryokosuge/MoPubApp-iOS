//
//  AppDelegate.swift
//  MoPubApp
//
//  Created by ryokosuge on 2020/03/19.
//  Copyright © 2020 ryokosuge. All rights reserved.
//

import UIKit
import MoPubSDK
import AppTrackingTransparency

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { [weak self] _ in
                self?.initializeMoPub()
            }
        } else {
            // Fallback on earlier versions
            initializeMoPub()
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

extension AppDelegate {

    private func initializeMoPub() {
        // Initialize MoPub
        let sdkConfig = MPMoPubConfiguration(adUnitIdForAppInitialization: Consts.AdUnitID.initialize)
        sdkConfig.loggingLevel = .debug
        sdkConfig.allowLegitimateInterest = true
        MoPub.sharedInstance().initializeSdk(with: sdkConfig, completion: nil)
    }
}
