//
//  CtaView.swift
//  HHLUXPrototype
//
//  Created by vlad on 10/08/2023.
//

import SwiftUI
import Combine


struct CtaView: View {

    @State private var timerValue = 0.0
    @State private var selectedColor = Color.red
    @State private var colors: [Color] = [.red, .blue, .green, .yellow, .orange, .purple, .cyan, .indigo, .mint, .pink]
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()

    @ObservedObject var favorite1 = FavoriteItem(icon: "heart")
    @ObservedObject var favorite2 = FavoriteItem(icon: "star")
    @ObservedObject var favorite3 = FavoriteItem(icon: "moon")
    @ObservedObject var favorite4 = FavoriteItem(icon: "sun.max")

    func changeColor(_ item: FavoriteItem) {
        guard !item.isLiked else { return }
        selectedColor = colors[Int(arc4random_uniform(10))]
    }

    var body: some View {
        HStack (spacing: 50) {
            fav1
                .environment(\.isEnabled, !favorite1.isDisabled)
            fav4
                .environment(\.isEnabled, !favorite4.isDisabled)
            fav3
                .environment(\.isEnabled, !favorite3.isDisabled)
            fav2
                .environment(\.isEnabled, !favorite2.isDisabled)
        }
        .nonSpammable()
        .padding()
        .font(.largeTitle)
    }

    var fav1: some View {
        Image(systemName: favorite1.icon)
            .onTapGesture() {
                changeColor(favorite1)
                Task { await favorite1.heartTapSpammable() }
            }
            .foregroundColor(favorite1.isLiked ? selectedColor : Color.black)
    }

    var fav2: some View {
        Image(systemName: favorite2.icon)
            .opacity(favorite2.isDisabled ? 0.2 : 1)
            .onTapGesture() {
                changeColor(favorite2)
                Task {
                    await favorite2.heartTap()
                    timerValue = 0.0
                }
            }
            .foregroundColor(favorite2.isLiked ? selectedColor : Color.black)
            .overlay{
                if favorite2.isDisabled {
                    progress
                        .offset(y: 2.5)
                }
            }
    }

    var progress: some View {
        VStack {
            Spacer()
            ProgressView(value: timerValue, total: 10)
                .onReceive(timer) { _ in
                    if timerValue < 10 {
                        timerValue += 1
                    }
                }
                .progressViewStyle(.linear)
                .tint(.gray)
        }
    }

    var fav3: some View {
        Button(action: {
            changeColor(favorite3)
            Task { await favorite3.heartTap() }
        }) {
            Image(systemName: favorite3.icon)
                .opacity(favorite3.isDisabled ? 0.2 : 1)
        }
        .buttonStyle(ScaleBlurButtonStyle())
        .foregroundColor(favorite3.isLiked ? selectedColor : Color.black)
    }

    var fav4: some View {
        Button(action: {
            changeColor(favorite4)
            Task { await favorite4.heartTap() }
        }) {
            Image(systemName: favorite4.icon)
                .opacity(favorite4.isDisabled ? 0.2 : 1)
        }
        .buttonStyle(BlurButtonStyle())
        .foregroundColor(favorite4.isLiked ? selectedColor : Color.black)
    }

}

struct CtaView_Previews: PreviewProvider {
    static var previews: some View {
        CtaView()
    }
}


struct AntiSpamModifier: ViewModifier {
    @Environment(\.isEnabled) var isEnabled
    func body(content: Content) -> some View {
        content
            .allowsHitTesting(isEnabled)
    }
}

extension View {
    func nonSpammable() -> some View {
        ModifiedContent(content: self, modifier: AntiSpamModifier())
    }
}

struct ScaleBlurButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .blur(radius: configuration.isPressed ? 1 : 0 )
    }
}

struct BlurButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .blur(radius: configuration.isPressed ? 1 : 0 )
    }
}

@MainActor
class FavoriteItem: ObservableObject {
    var icon: String = ""

    @Published var isLiked = false
    @Published var isDisabled = false

    init(icon: String, isLiked: Bool = false, isDisabled: Bool = false) {
        self.icon = icon
        self.isLiked = isLiked
        self.isDisabled = isDisabled
    }

    func heartTap() async {
        isDisabled = true
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        withAnimation(.easeIn) {
            isLiked.toggle()
            isDisabled = false
        }
    }

    func heartTapSpammable() async {
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        withAnimation(.easeIn) {
            isLiked.toggle()
        }
    }

}
