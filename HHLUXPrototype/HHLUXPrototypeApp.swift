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
            if delegate.sideLoad != nil {
                content
            } else if delegate.centerLoad != nil {
                ProtoWindow(model: dataModel, proto: .constant(delegate.centerLoad))
                    .environmentObject(appSettings)
                    .onAppear {
                        delegate.centerLoad = nil
                    }
            } else {
                content
            }
        }
        .handlesExternalEvents(matching: ["texturl://open"])
        .commands {
            SidebarCommands()
        }
        WindowGroup("Prototypes Details", for: Prototype.self) { $proto in
            ProtoWindow(model: dataModel, proto: $proto)
                .environmentObject(appSettings)
        }
    }

    var content: some View {
        ContentView(model: dataModel)
            .environmentObject(appSettings)
            .task(priority: .medium) {
                await appSettings.load()
            }
    }

}
