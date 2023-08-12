//
//  ContentView.swift
//  HHLUXPrototype
//
//  Created by vlad on 10/08/2023.
//

import SwiftUI


struct ContentView: View {

    //    @EnvironmentObject private var appSettings: AppSettings
    //
    //    @SceneStorage("ContentView.selectedTab")

    @State private var columnVisibility: NavigationSplitViewVisibility = .all

    @State private var selection: Int?

    var body: some View {
        Group {
            NavigationSplitView(columnVisibility: $columnVisibility) {
                sidebarList
                    .navigationTitle("HHLUXPrototype")
            } detail: {

            }
        }
        .navigationSplitViewStyle(.balanced)
    }

    var sidebarList: some View {
        List (selection: $selection) {
            NavigationLink {
                SelectorsView()
            } label: {
                Label("Selectors", systemImage: "checklist")
            }
            NavigationLink {
                SwitchesView()
            } label: {
                Label("Switches, sliders, etc", systemImage: "switch.2")
            }
            NavigationLink {
                InputView()
            } label: {
                Label("TextInputs", systemImage: "rectangle.and.pencil.and.ellipsis")
            }
            NavigationLink {
                PopupsView()
            } label: {
                Label("Popups", systemImage: "rectangle.3.group.bubble.left.fill")
            }
            NavigationLink {
                ListsView()
            } label: {
                Label("Lists", systemImage: "list.bullet.rectangle")
            }
            NavigationLink {
                LoadView()
            } label: {
                Label("Loading", systemImage: "arrow.clockwise.icloud")
            }
            sidebarList1
        }
    }

    var sidebarList1: some View {
        Group {
            NavigationLink {
                MenuView()
            } label: {
                Label("Menus", systemImage: "filemenu.and.selection")
            }
            NavigationLink {
                HapticsView()
            } label: {
                Label("Haptics", systemImage: "hand.tap")
            }
            NavigationLink {
                cta
            } label: {
                Label("Feedback", systemImage: "rectangle.and.hand.point.up.left")
            }
            NavigationLink {
                StatesView()
            } label: {
                Label("States", systemImage: "checkmark.circle.trianglebadge.exclamationmark")
            }
            NavigationLink {
                SymbolsView()
            } label: {
                Label("Symbols", systemImage: "apple.logo")
            }
        }
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
                Text("- standard button with no state feedback (spammable)")
            }
            HStack {
                Image(systemName: "moon")
                Text("- button with slight blur on tap (non spammable)")
            }
            HStack {
                Image(systemName: "star")
                Text("- button with blur and scaling on tap (non spammable)")
            }
            HStack {
                Image(systemName: "sun.max")
                Text("- button with haptic feedback and progress bar (non spammable)")
            }
        }
        .font(.caption)
        .foregroundColor(.secondary)
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
