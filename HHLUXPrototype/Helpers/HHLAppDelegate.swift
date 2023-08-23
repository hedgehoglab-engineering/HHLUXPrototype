//
//  HHLAppDelegate.swift
//  HHLUXPrototype
//
//  Created by vlad on 21/08/2023.
//

import SwiftUI

class HHLAppDelegate: NSObject, UIApplicationDelegate, ObservableObject {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil  ) -> Bool {

        setDefaultItems()

        return true
    }

    func setDefaultItems() {
        let defaults = UserDefaults.standard
        let items = defaults.value(forKey: "shortcutItems")
        if items == nil {
            let list = PrototypesList()[category: .secondary].compactMap{ $0.rawValue }
            defaults.setValue(list, forKey: "shortcutItems")
        }
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

