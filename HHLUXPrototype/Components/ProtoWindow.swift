//
//  ProtoWindow.swift
//  HHLUXPrototype
//
//  Created by vlad on 22/08/2023.
//

import SwiftUI

struct ProtoWindow: View {
    @ObservedObject var model: PrototypesList
    @Binding var protoId: Prototype.ID?

    var body: some View {
        if let protoId = protoId, let proto = model[item: protoId] {
            proto.view
        } else {
            Label("Nothing selected", systemImage: "exclamationmark.square.fill")
                .font(.title)
                .foregroundStyle(.tertiary)
        }
    }
}

struct ProtoWindow_Previews: PreviewProvider {
    static var previews: some View {
        let model = PrototypesList()
        Group {
            ProtoWindow(model: model, protoId: .constant(nil))
            ProtoWindow(model: model, protoId: .constant(.buttons))
        }
    }
}
