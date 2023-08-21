//
//  HHLAppDelegate.swift
//  HHLUXPrototype
//
//  Created by vlad on 21/08/2023.
//

import SwiftUI

class HHLAppDelegate: NSObject, UIApplicationDelegate, ObservableObject {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil  ) -> Bool {
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let sceneConfig = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        sceneConfig.delegateClass = HHLSceneDelegate.self
        return sceneConfig
    }
}

