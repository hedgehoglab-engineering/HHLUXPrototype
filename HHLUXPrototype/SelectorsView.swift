//
//  SelectorsView.swift
//  HHLUXPrototype
//
//  Created by vlad on 10/08/2023.
//

import SwiftUI

struct SelectorsView: View {

    @State private var selector = 0
    @State private var isShowingPop = false

    var inline: some View {
        Picker(selection: $selector, label: Text("Inline")) {
            Text("Thin").tag(0)
            Text("Regular").tag(1)
            Text("Bold").tag(2)
        }
        .pickerStyle(.inline)
    }

    var wheel: some View {
        Picker(selection: $selector, label: Text("Wheel")) {
            Text("Thin").tag(0)
            Text("Regular").tag(1)
            Text("Bold").tag(2)
        }
        .pickerStyle(.wheel)
    }

    var body: some View {
        NavigationStack {
            Form {
                wheel
                inline
                Picker(selection: $selector, label: Text("Segmented")) {
                    Text("Thin").tag(0)
                    Text("Regular").tag(1)
                    Text("Bold").tag(2)
                }
                .pickerStyle(.segmented)
                Section {
                    Picker(selection: $selector, label: Text("Navigation")) {
                        Text("Thin").tag(0)
                        Text("Regular").tag(1)
                        Text("Bold").tag(2)
                    }
                    .pickerStyle(.navigationLink)
                }
                Picker(selection: $selector, label: Text("Menu")) {
                    Text("Thin").tag(0)
                    Text("Regular").tag(1)
                    Text("Bold").tag(2)
                }
                .pickerStyle(.menu)
                Section {
                    Button("Popup") {
                        isShowingPop.toggle()
                    }
                    .sheet(isPresented: $isShowingPop) {
                        Form {
                            inline
                        }
                    }
                }
            }
        }
    }
}

struct SelectorsView_Previews: PreviewProvider {
    static var previews: some View {
        SelectorsView()
    }
}
