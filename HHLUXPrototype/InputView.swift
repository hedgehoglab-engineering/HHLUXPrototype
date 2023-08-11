//
//  InputView.swift
//  HHLUXPrototype
//
//  Created by vlad on 10/08/2023.
//

import SwiftUI

struct InputView: View {
    var body: some View {
        List {
            Section("Empty state") {
                FloatingTextField(title: "Username placeholder", text: .constant(""), error: .constant(""))
            }
            Section("Ready state") {
                FloatingTextField(title: "Username", text: .constant("something"), error: .constant(""))
            }
            Section("Error state") {
                FloatingTextField(title: "Username", text: .constant("invalid"), error: .constant("some error"))
            }
        }

    }
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView()
    }
}

