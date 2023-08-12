//
//  SwitchesView.swift
//  HHLUXPrototype
//
//  Created by vlad on 14/08/2023.
//

import SwiftUI

struct SwitchesView: View {

    @State private var isColored = false

    let start = Date().addingTimeInterval(-360)
    let end = Date().addingTimeInterval(360)

    @State private var value = 0.0

    @State private var speed = 50.0
    @State private var isEditing = false

    @Environment(\.calendar) var calendar
    @State var dates: Set<DateComponents> = []

    var body: some View {
        List {
            Section {
                Toggle("Toggle (orange tint)", isOn: $isColored)
                    .ifModifier(isColored) { view in
                        view.tint(.orange)
                    }
            }
            Section {
                stepper
            }
            Section {
                slider
            }
            Section {
                progress
            }
            Section ("Page control horizontal") {
                pages
            }
            Section ("Page control vertical"){
                pagesRotated
            }
            Section ("Variable Symbols"){
                symbols
            }
            Section ("Share links"){
                ShareLink(item: URL(string: "http://apple.com")!)
                ShareLink(item: URL(string: "http://apple.com")!) {
                    Label("Custom icon share", systemImage: "rectangle.3.group.bubble.left.fill")
                }
            }
            Section ("Multi Date picker") {
                VStack {
                    MultiDatePicker("Select your preferred dates", selection: $dates)
                    Text(summary)
                }
                .padding()
                .ifModifier(isColored) { view in
                    view.tint(.orange)
                }
            }
        }
        .onAppear {
            UIPageControl.appearance().currentPageIndicatorTintColor = .black
            UIPageControl.appearance().pageIndicatorTintColor = .lightGray
        }
    }

    var symbols: some View {
        VStack {
            HStack {
                Image(systemName: "bell.badge.waveform", variableValue: value)
                Image(systemName: "aqi.low", variableValue: value)
                Image(systemName: "wifi", variableValue: value)
                Image(systemName: "chart.bar.fill", variableValue: value)
                Image(systemName: "shareplay", variableValue: value)
                Image(systemName: "waveform", variableValue: value)
                Image(systemName: "timelapse", variableValue: value)
                Image(systemName: "cloud.rainbow.half", variableValue: value)
            }
            Slider(value: $value)
        }
        .font(.title)
        .padding()
        .ifModifier(isColored) { view in
            view.tint(.orange)
        }
    }

    var summary: String {
        dates.compactMap { components in
            calendar.date(from: components)?.formatted(date: .long, time: .omitted)
        }.formatted()
    }

    var pages: some View {
        TabView {
            Group {
                ForEach(1..<7) { c in
                    Text("Page \(c)")
                }
            }
        }
        .tabViewStyle(.page)
        .frame(width: 400, height: 100)
    }

    var pagesRotated: some View {
        TabView {
            Group {
                ForEach(1..<7) { c in
                    Text("Page \(c)")
                }
            }
            .rotationEffect(Angle(degrees: -90))
            .offset(y: -20)

        }
        .rotationEffect(Angle(degrees: 90))
        .frame(width: 400, height: 100)
        .tabViewStyle(.page)
    }

    var stepper: some View {
        Stepper {
            Text("Stepper: \(value)")
        } onIncrement: {
            value += 1
        } onDecrement: {
            value -= 1
        }
        .ifModifier(isColored) { view in
            view.tint(.orange)
        }
    }

    var slider: some View {
        HStack {
            Text("Slider: \(Int(speed))")
                .foregroundColor(isEditing ? .gray : .black)
            Slider(
                value: $speed,
                in: 0...100,
                onEditingChanged: { editing in
                    isEditing = editing
                }
            )
            .ifModifier(isColored) { view in
                view.tint(.orange)
            }
        }
    }

    var progress: some View {
        ProgressView(timerInterval: start...end,
                     countsDown: false) {
            Text("Progress bar")
        } currentValueLabel: {
            Text(start...end)
        }
        .ifModifier(isColored) { view in
            view.tint(.orange)
        }
    }

}

struct SwitchesView_Previews: PreviewProvider {
    static var previews: some View {
        SwitchesView()
    }
}
