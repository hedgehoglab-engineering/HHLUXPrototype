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

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appSettings)
                .task(priority: .medium) {
                    await appSettings.load()
                }
        }
    }
}
