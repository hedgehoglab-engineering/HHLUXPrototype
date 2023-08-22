//
//  HHLSceneDelegate.swift
//  HHLUXPrototype
//
//  Created by vlad on 21/08/2023.
//

import UIKit

class HHLSceneDelegate: NSObject, UIWindowSceneDelegate, ObservableObject {

    static var favoriteIdentifierInfoKey: String = "shortcutProtoId"

    var shortcutItem: UIApplicationShortcutItem?

    func sceneWillEnterForeground(_ scene: UIScene) {

    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        makeShortcutItems()
    }

    func sceneWillResignActive(_ scene: UIScene) {
        makeShortcutItems()
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        /** Process the quick action if the user selected one to launch the app.
            Grab a reference to the shortcutItem to use in the scene.
        */
        if let shortcutItem = connectionOptions.shortcutItem {
            // Save it off for later when we become active.
            self.shortcutItem = shortcutItem
            print(shortcutItem)
        } else {
            dump(connectionOptions)
        }
    }

    func windowScene(_ windowScene: UIWindowScene, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        let handled = handleShortCutItem()
        completionHandler(handled)
    }

    func makeShortcutItems() {
        let list = PrototypesList()[category: .secondary]
        UIApplication.shared.shortcutItems = list.map { item -> UIApplicationShortcutItem in
            return item.makeShortcut()
        }
    }

    func handleShortCutItem() -> Bool {
        dump(shortcutItem)
        return true
    }

}
