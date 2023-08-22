//
//  HHLUXPrototypeApp.swift
//  HHLUXPrototype
//
//  Created by vlad on 10/08/2023.
//

import SwiftUI

@main
struct HHLUXPrototypeApp: App {

    private var dataModel = PrototypesList()
    @StateObject private var appSettings = AppSettings()
    @UIApplicationDelegateAdaptor var delegate: HHLAppDelegate

    var body: some Scene {
        WindowGroup("Prototypes List") {
            ContentView(model: dataModel)
                .environmentObject(appSettings)
                .task(priority: .medium) {
                    await appSettings.load()
                }
        }
        .commands {
            SidebarCommands()
        }
        WindowGroup("Prototypes Details", for: Prototype.ID.self) { $protoId in
            ProtoWindow(model: dataModel, protoId: $protoId)
        }
    }
}
