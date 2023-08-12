//
//  LegendView.swift
//  HHLUXPrototype
//
//  Created by vlad on 13/08/2023.
//

import SwiftUI

struct LegendView: View {

    enum Types {
        case label
        case scale
        case style
        case color
    }

    @State private var isShowingLegend = false
    @State private var legendText = ""

    @ViewBuilder func makeLegend(label: String, types: [Types]) -> some View {
        HStack {
            Text(label)
            Spacer()
            ForEach (types, id: \.self) { type in
                if type == .label { buttonLabel }
                if type == .scale { buttonScale }
                if type == .style { buttonStyle }
                if type == .color { buttonColor }
            }
            Spacer()
        }
    }

    var body: some View {
        HStack {
            buttonLabel
            buttonScale
            buttonStyle
            buttonColor
        }
        .sheet(isPresented: $isShowingLegend) {
            Text(legendText)
            .presentationDetents([.medium, .large])
        }
    }

    var buttonLabel: some View {
        Button(action: {
            legendText = "A textual label available for the component is fully customisable in that it can be shown/hidden"
            isShowingLegend.toggle()
        }) {
            Image(systemName: "l.square.fill")
                .opacity(0.5)
        }
    }

    var buttonScale: some View {
        Button(action: {
            legendText = "The component can be scaled"
            isShowingLegend.toggle()
        }) {
            Image(systemName: "square.arrowtriangle.4.outward")
                .opacity(0.5)
        }
    }

    var buttonStyle: some View {
        Button(action: {
            legendText = "Text style is fully customisable"
            isShowingLegend.toggle()
        }) {
            Image(systemName: "textformat.size")
                .opacity(0.5)
        }
    }

    var buttonColor: some View {
        Button(action: {
            legendText = "Color is fully customisable"
            isShowingLegend.toggle()
        }) {
            Image(systemName: "paintpalette.fill")
                .opacity(0.5)
        }
    }

}

struct LegendView_Previews: PreviewProvider {
    static var previews: some View {
        LegendView()
    }
}
