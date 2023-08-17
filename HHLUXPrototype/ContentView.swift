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

    @State private var searchText = ""

    @ObservedObject private var backend = SimulatedBackendSingleton.sharedInstance

    var body: some View {
        Group {
            NavigationSplitView(columnVisibility: $columnVisibility) {
                VStack {
                    sidebarList
                    Spacer()
                    footer
                    Spacer()
                }
                .background(Color(UIColor.systemGroupedBackground))
                .navigationTitle("HHLUXPrototype")
                .navigationSplitViewStyle(.balanced)
                .navigationBarTitleDisplayMode(.inline)
            } detail: {

            }
        }
        .ifModifier(backend.lightMode) { view in
            view.colorScheme(.light)
        }
        .onAppear {
            UINavigationBar.appearance().titleTextAttributes = [.font : UIFont.systemFont(ofSize: 20, weight: .ultraLight)]
            UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont.systemFont(ofSize:34, weight: .ultraLight)]
        }
//        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search")
    }

    func determineGearIcon() -> String {
        let hour = Calendar.current.component(.hour, from: Date())
        
        if hour >= 0 && hour < 12 {
            return "gearshape"
        } else if hour >= 12 && hour < 17 {
            return "gear"
        } else {
            return "gearshape.2"
        }
    }

    var footer: some View {
        VStack {
            settingsMenu
                .font(.callout)
                .padding()
            Text("Copyright 2023 hedgehog lab")
                .font(.caption)
        }
        .foregroundColor(.black.mix(with: .white, amount: 0.7))
        .shadow(color: .white, radius: 0.1, x: 0, y: 1)
    }

    var settingsMenu: some View {
        Menu(content: {
            SettingsView()
        }, label: {
            Label("Settings", systemImage: determineGearIcon())
        })
    }


    var sidebarList: some View {
        List (selection: $selection) {
            Section {
                sidebarList1
            }
            Section {
                sidebarList2
            }
            Section {
                NavigationLink {
                    SymbolsView()
                } label: {
                    Label("SF Symbols", systemImage: "apple.logo")
                }
            }
        }
    }

    var sidebarList1: some View {
        Group {
            NavigationLink {
                CtaViewList()
            } label: {
                Label("Buttons", systemImage: "rectangle.and.hand.point.up.left")
            }
            NavigationLink {
                SelectorsView()
            } label: {
                Label("Selectors", systemImage: "checklist")
            }
            NavigationLink {
                SwitchesView()
            } label: {
                Label("Switches, sliders, gauges", systemImage: "switch.2")
            }
            NavigationLink {
                PickersView()
            } label: {
                Label("Pickers, Pages, share", systemImage: "eyedropper")
            }
            NavigationLink {
                InputView()
            } label: {
                Label("Text input", systemImage: "rectangle.and.pencil.and.ellipsis")
            }
            NavigationLink {
                PopupsView()
            } label: {
                Label("Popups", systemImage: "rectangle.on.rectangle.angled")
            }
            NavigationLink {
                PopupsView()
            } label: {
                Label("Tips", systemImage: "rectangle.3.group.bubble.left.fill")
            }
            NavigationLink {
                ListsView()
            } label: {
                Label("Lists", systemImage: "list.bullet.rectangle")
            }
        }
    }

    var sidebarList2: some View {
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
                LoadView()
            } label: {
                Label("Loading", systemImage: "arrow.clockwise.icloud")
            }
            NavigationLink {
                StatesView()
            } label: {
                Label("States", systemImage: "checkmark.circle.trianglebadge.exclamationmark")
            }
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
