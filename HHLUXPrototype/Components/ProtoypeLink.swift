//
//  ProtoypeLink.swift
//  HHLUXPrototype
//
//  Created by vlad on 22/08/2023.
//

import SwiftUI

struct ProtoypeLink: View {

    @Environment(\.supportsMultipleWindows) private var supportsMultipleWindows
    @Environment(\.openWindow) private var openWindow

    @State var type: Prototype

    var body: some View {
        NavigationLink {
            type.view
        } label: {
            Label(type.title, systemImage: type.iconName)
        }
        .ifModifier(supportsMultipleWindows) { view in
            view.contextMenu {
                Label("multitasking", systemImage: "rectangle.badge.plus")
                Button {
                    openWindow(value: type)
                } label: {
                    Label("Open in New Window", systemImage: "rectangle.righthalf.inset.filled")
                }
                Button {
                    openWindow(value: type)
                } label: {
                    Label("Open in Center Window", systemImage: "rectangle.center.inset.filled")
                }
                Label("shortcuts", systemImage: "apps.iphone")
                Toggle("App icon shortcut", isOn: .constant(true))
            }
        }
    }

}

struct ProtoypeLink_Previews: PreviewProvider {
    static var previews: some View {
        List {
            ProtoypeLink(type: .buttons)
            ProtoypeLink(type: .input)
            ProtoypeLink(type: .haptics)
        }
    }
}
