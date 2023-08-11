//
//  ContentView.swift
//  HHLUXPrototype
//
//  Created by vlad on 10/08/2023.
//

import SwiftUI

struct ContentView: View {

    @EnvironmentObject private var appSettings: AppSettings

    @SceneStorage("ContentView.selectedTab")

    private var selection: Tab = .cta

    enum Tab: String {
        case symbols
        case cta
        case lists
        case menus
        case selectors
        case input
        case states
        case load
    }

    var cta: some View {
        Form {
            List {
                ForEach(1..<7) { _ in
                    CtaView()
                }
            }
            HStack {
                Image(systemName: "heart")
                Text("- standard cta with no state feedback (spammable)")
            }
            HStack {
                Image(systemName: "moon")
                Text("- cta with slight blur (non spammable)")
            }
            HStack {
                Image(systemName: "star")
                Text("- cta with blur and scaling (non spammable)")
            }
            HStack {
                Image(systemName: "sun.max")
                Text("- cta with haptic feedback and progress bar (non spammable)")
            }
        }
        .font(.caption)
        .foregroundColor(.secondary)
    }

    var body: some View {
        TabView(selection: $selection) {
            cta
            .tabItem {
                Label("CTA", systemImage: "hand.tap")
            }
            .tag(Tab.cta)
            SelectorsView()
                .tabItem {
                    Label("Selectors", systemImage: "checklist")
                }
                .tag(Tab.selectors)
            SymbolsView()
                .tabItem {
                    Label("Symbols", systemImage: "apple.logo")
                }
                .tag(Tab.symbols)
            StatesView()
                .tabItem {
                    Label("States", systemImage: "checkmark.circle.trianglebadge.exclamationmark")
                }
                .tag(Tab.states)
            MenuView()
                .tabItem {
                    Label("Menus", systemImage: "filemenu.and.selection")
                }
                .tag(Tab.menus)
            InputView()
                .tabItem {
                    Label("Inputs", systemImage: "rectangle.and.pencil.and.ellipsis")
                }
                .tag(Tab.input)
            ListsView()
                .tabItem {
                    Label("Lists", systemImage: "list.bullet.rectangle")
                }
                .tag(Tab.lists)
            LoadView()
                .tabItem {
                    Label("Load", systemImage: "arrow.clockwise.icloud")
                }
                .tag(Tab.load)

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .environment(\.colorScheme, .light)
                .previewDisplayName("Default")

            ContentView()
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Dark Mode")

        }
        .environmentObject(AppSettings())
    }
}
