//
//  SettingsView.swift
//  HHLUXPrototype
//
//  Created by vlad on 15/08/2023.
//

import SwiftUI

struct SettingsView: View {

    @ObservedObject private var backend = SimulatedBackendSingleton.sharedInstance

    @State private var shake: Bool = false

    var body: some View {
        Group {
            Toggle("Force light mode", isOn: $backend.lightMode)
            Toggle("Force backend failure", isOn: $backend.willFail)
            Toggle("Force backend timeout", isOn: $backend.willTimeout)
            stepper
            if #available(iOS 17.0, *) {
                label
                    .symbolEffect(.bounce.down, value: backend.delayValue)
            } else {
                label
            }
        }
        .tint(.blue.mix(with: .white, amount: 0.5))
    }

    var stepper: some View {
        Stepper {
            Text("Backend delay: \(Int(backend.delayValue)) sec")
        } onIncrement: {
            backend.delayValue += 1
        } onDecrement: {
            if backend.delayValue > 1 {
                backend.delayValue -= 1
            } else {
                withAnimation {
                    shake.toggle()
                }
            }
        }
        .modifier(ShakeEffect(shakes: shake ? 2 : 0))
    }

    var label: some View {
        Label("v1.0 build 6", systemImage: "app.dashed")
    }

}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            SettingsView()
            Menu(content: {
                SettingsView()
            }, label: {
                Label("Settings", systemImage: "gear")
            })
        }
    }
}

struct ShakeEffect: GeometryEffect {
    func effectValue(size: CGSize) -> ProjectionTransform {
        return ProjectionTransform(CGAffineTransform(translationX: -5 * sin(position * 2 * .pi), y: 0))
    }

    init(shakes: Int) {
        position = CGFloat(shakes)
    }

    var position: CGFloat
    var animatableData: CGFloat {
        get { position }
        set { position = newValue }
    }
}
