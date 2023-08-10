//
//  ListsView.swift
//  HHLUXPrototype
//
//  Created by vlad on 10/08/2023.
//

import SwiftUI

struct ListsView: View {
    var body: some View {
            VStack {
                Text("Default list")
                List {
                    Text("one")
                    Text("two")
                }
                Text("List with sections")
                List {
                    Section("section one") {
                        Text("one")
                    }
                    Section("section two") {
                        Text("two")
                    }
                }
                Text("List with sections grouped")
                List {
                    Section("section one") {
                        Text("one")
                    }
                    Section("section two") {
                        Text("two")
                    }
                }
                .listStyle(.grouped)
            }
            .padding()
    }
}

struct ListsView_Previews: PreviewProvider {
    static var previews: some View {
        ListsView()
    }
}
