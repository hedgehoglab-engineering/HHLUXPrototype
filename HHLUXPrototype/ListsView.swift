//
//  ListsView.swift
//  HHLUXPrototype
//
//  Created by vlad on 10/08/2023.
//

import SwiftUI

struct ListsView: View {

    @State private var legend = LegendView()

    @ObservedObject private var backend = SimulatedBackendSingleton.sharedInstance

    @ViewBuilder func makeLegend(label: String, types: [LegendView.Types] = [.style, .color]) -> some View {
        legend.makeLegend(label: "List with "+label, types: types)
    }

    var body: some View {
        List {
            Section (header: makeLegend(label: "no sections")) {
                List {
                    Text("one")
                    Text("two")
                }
                .frame(height: 150)
                .listRowBackground(Color.clear)
            }
            Section (header: makeLegend(label: "no sections plain")) {
                List {
                    Text("one")
                    Text("two")
                }
                .listStyle(.plain)
                .frame(height: 150)
                .listRowBackground(Color.clear)
            }
            Section (header: makeLegend(label: "sections")) {
                List {
                    Section("section one") {
                        Text("one")
                    }
                    Section("section two") {
                        Text("two")
                    }
                }
                .listStyle(.insetGrouped)
                .frame(height: 200)
                .listRowBackground(Color.clear)
            }
            Section (header: makeLegend(label: "inset sections")) {
                List {
                    Section("section one") {
                        Text("one")
                    }
                    Section("section two") {
                        Text("two")
                    }
                }
                .listStyle(.inset)
                .frame(height: 200)
                .listRowBackground(Color.clear)
            }
            Section (header: makeLegend(label: "plain sections")) {
                List {
                    Section("section one") {
                        Text("one")
                    }
                    Section("section two") {
                        Text("two")
                    }
                }
                .listStyle(.plain)
                .frame(height: 200)
                .listRowBackground(Color.clear)
            }
        }
        .ifModifier(backend.orangeTint) { view in
            view.tint(.orange)
        }
    }
}

struct ListsView_Previews: PreviewProvider {
    static var previews: some View {
        ListsView()
    }
}
