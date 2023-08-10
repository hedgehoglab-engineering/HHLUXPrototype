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
                Image(systemName: "sun.max")
                Text("- cta with slight feedback (non spammable)")
            }
            HStack {
                Image(systemName: "moon")
                Text("- cta with noted feedback (non spammable)")
            }
            HStack {
                Image(systemName: "star")
                Text("- cta with progress bar (non spammable)")
            }
        }
        .font(.caption)
        .foregroundColor(.secondary)
    }

    var body: some View {
        TabView(selection: $selection) {
            SymbolsView()
                .tabItem {
                    Label("Symbols", systemImage: "apple.logo")
                }
                .tag(Tab.symbols)
            cta
            .tabItem {
                Label("CTA", systemImage: "hand.tap")
            }
            .tag(Tab.cta)
            MenuView()
                .tabItem {
                    Label("Menus", systemImage: "filemenu.and.selection")
                }
                .tag(Tab.menus)
            SelectorsView()
                .tabItem {
                    Label("Selectors", systemImage: "checklist")
                }
                .tag(Tab.selectors)
            ListsView()
                .tabItem {
                    Label("Lists", systemImage: "list.bullet.rectangle")
                }
                .tag(Tab.lists)
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
