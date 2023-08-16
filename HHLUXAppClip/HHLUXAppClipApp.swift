//
//  HHLUXAppClipApp.swift
//  HHLUXAppClip
//
//  Created by vlad on 16/08/2023.
//

import SwiftUI
import SwiftData

@main
struct HHLUXAppClipApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Item.self)
    }
}
