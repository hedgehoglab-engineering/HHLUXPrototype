//
//  HHLUXPrototypeApp.swift
//  HHLUXPrototype
//
//  Created by vlad on 10/08/2023.
//

import SwiftUI

@main
struct HHLUXPrototypeApp: App {

    @StateObject private var appSettings = AppSettings()
    @UIApplicationDelegateAdaptor var delegate: HHLAppDelegate

    var body: some Scene {
        WindowGroup("Prototypes List") {
            ContentView()
                .environmentObject(appSettings)
                .task(priority: .medium) {
                    await appSettings.load()
                }
        }
        .commands {
            SidebarCommands()
        }
        WindowGroup("Prototypes Details", for: Proto.ID.self) { $protoId in
            ProtoWindow(protoId: $protoId)
        }
    }
}

struct ProtoWindow: View {
    @Binding var protoId: Proto.ID?

    var body: some View {
        if let protoId = protoId{
            Text(protoId.description)
        }
    }

}
