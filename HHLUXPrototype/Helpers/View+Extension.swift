//
//  View+Extension.swift
//  HHLUXPrototype
//
//  Created by vlad on 12/08/2023.
//

import SwiftUI

extension View {
    @ViewBuilder func `ifModifier`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
