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

    @ObservedObject var model: PrototypesList

    @State private var columnVisibility: NavigationSplitViewVisibility = .all

    @State private var selection: Int?

    @State private var searchText = ""

    @ObservedObject private var backend = SimulatedBackendSingleton.sharedInstance

    @State private var shake: Bool = false

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
                if #available(iOS 17.0, *) {
                    shakeButton
                        .symbolEffect(.bounce.byLayer, value: shake)
                } else {
                    shakeButton
                }
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

    var shakeButton: some View {
        Button (action: {
            withAnimation {
                shake.toggle()
            }
        }) {
            Image(systemName: "square.stack.3d.forward.dottedline.fill", variableValue: shake ? 0.5 : 0.7)
        }
        .modifier(ShakeEffect(shakes: shake ? 2 : 0))
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
                ForEach (model[category: .primary]) {
                    ProtoypeLink(type: $0)
                }
            }
            Section {
                ForEach (model[category: .secondary]) {
                    ProtoypeLink(type: $0)
                }
            }
            Section {
                ForEach (model[category: .extra]) {
                    ProtoypeLink(type: $0)
                }
            }
            if UIDevice.current.userInterfaceIdiom == .pad {
                Section {
                    ForEach (model[category: .ipad]) {
                        ProtoypeLink(type: $0)
                    }
                }
            }
            if UIDevice.current.userInterfaceIdiom == .phone {
                Section {
                    ProtoypeLink(type: .haptics)
                }
            }
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let model = PrototypesList()
        Group {
            ContentView(model: model)
                .environment(\.colorScheme, .light)
                .previewDisplayName("Default")

            ContentView(model: model)
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Dark Mode")

        }
        .environmentObject(AppSettings())
    }
}
