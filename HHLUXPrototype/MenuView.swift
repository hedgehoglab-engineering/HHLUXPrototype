//
//  MenuView.swift
//  HHLUXPrototype
//
//  Created by vlad on 10/08/2023.
//

import SwiftUI

struct MenuView: View {

    @State var presentEdit = false
    @State var buttonTap = false

    var body: some View {
        ScrollView {
            ForEach(1..<4) { _ in
                item
                    .padding(40)
                    .contextMenu {
                        testContextMenu
                    }
            }
        }
    }

    var item: some View {
        Text("Tap and hold for menu")
            .padding(40)
            .background(Color(UIColor.secondarySystemBackground))
            .clipShape(backgroundRectangle)
            .contentShape(.contextMenuPreview, backgroundRectangle)
            .sheet(isPresented: $presentEdit) {
                Text("Editor")
            }
    }

}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}

private extension MenuView {

    @ViewBuilder var testContextMenu: some View {
        Menu("Nested Menu") {
            Button("Nested #1") {}
            Button("Nested #2") {}
            Button("Nested #3") {}
        }
        Button {
            presentEdit.toggle()
        } label: {
            Label("Edit", systemImage: "pencil")
        }

        Button {
            //open url
        } label: {
            Label("Open in Safari", systemImage: "safari")
        }

        ShareLink(item: URL(string: "http://apple.com")!)

        Button(role: .destructive) {
            //delete bookmark
        } label: {
            Label("Delete", systemImage: "minus.circle")
        }
    }

    private var backgroundRectangle: RoundedRectangle {
        RoundedRectangle(cornerRadius: 12)
    }

}
