//
//  ButtonStyles.swift
//  HHLUXPrototype
//
//  Created by vlad on 11/08/2023.
//

import SwiftUI

struct StandardButtonStyle: ButtonStyle {
    let backgroundColor: Color
    let foregroundColor: Color
    let font: Font?

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal)
            .padding(.vertical, 4)
            .background(configuration.isPressed ? backgroundColor.opacity(0.8) : backgroundColor)
            .foregroundColor(foregroundColor)
            .font(font)
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

extension ButtonStyle where Self == StandardButtonStyle {
    static var standardPrimary: StandardButtonStyle {
        StandardButtonStyle(
            backgroundColor: .blue,
            foregroundColor: .white,
            font: .body)
    }
    static var standardPrimaryDisabled: StandardButtonStyle {
        StandardButtonStyle(
            backgroundColor: .blue,
            foregroundColor: .secondary,
            font: .body)
    }
}