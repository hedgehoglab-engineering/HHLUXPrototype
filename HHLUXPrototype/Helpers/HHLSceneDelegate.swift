//
//  HHLSceneDelegate.swift
//  HHLUXPrototype
//
//  Created by vlad on 21/08/2023.
//

import UIKit

class HHLSceneDelegate: NSObject, UIWindowSceneDelegate, ObservableObject {

    static var favoriteIdentifierInfoKey: String = "shortcutProtoId"
//
//    var shortcutItem: UIApplicationShortcutItem?

    func sceneWillEnterForeground(_ scene: UIScene) {

    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        makeShortcutItems()
    }

    func sceneWillResignActive(_ scene: UIScene) {
        makeShortcutItems()
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
//        /** Process the quick action if the user selected one to launch the app.
//            Grab a reference to the shortcutItem to use in the scene.
//        */
//        if let shortcutItem = connectionOptions.shortcutItem {
//            // Save it off for later when we become active.
//            self.shortcutItem = shortcutItem
//            print(shortcutItem)
//        }
    }

    func windowScene(_ windowScene: UIWindowScene, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        let handled = handleShortCutItem(shortcutItem)
        completionHandler(handled)
    }

    func handleShortCutItem(_ item: UIApplicationShortcutItem) -> Bool {
        if let type = Prototype(shortcut: item) {
            SimulatedBackendSingleton.sharedInstance.selection = type
            return true
        }
        return false
    }

    func makeShortcutItems() {
        let defaults = UserDefaults.standard
        guard let list = defaults.value(forKey: "shortcutItems") as? [String] else { return }
        var items = [Prototype]()
        for item in list {
            if let proto = Prototype(rawValue: item) {
                items.append(proto)
            }
        }
        UIApplication.shared.shortcutItems = items.map { item -> UIApplicationShortcutItem in
            return item.makeShortcut()
        }
    }

}
