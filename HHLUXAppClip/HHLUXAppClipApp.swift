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

    private var dataModel = PrototypesList()

    var body: some Scene {
        WindowGroup {
            ContentView(model: dataModel)
//            SwiftDataExample()
        }
//        .modelContainer(for: Item.self)
    }
}
