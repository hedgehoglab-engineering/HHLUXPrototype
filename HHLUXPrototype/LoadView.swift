//
//  LoadView.swift
//  HHLUXPrototype
//
//  Created by vlad on 11/08/2023.
//

import SwiftUI

struct LoadView: View {

    @ObservedObject var viewModel = LoadViewModel(source: LoadViewSource(), threshold: 1, pageSize: 10)

    var body: some View {
        ScrollView {
            ForEach(viewModel.items) { item in
                CtaView()
                    .onAppear {
                        viewModel.onItemAppear(item)
                    }
            }
        }
        .refreshable { await viewModel.fetchAll() }
//        let index = page * 10
//        return ForEach(1..<index, id: \.self) { _ in
//            CtaView()
//        }
    }

    var loader: some View {
        LazyVStack(spacing: 12) {
            paginationLoader
            Spacer(minLength: 12)
        }
        .padding(12)
    }

    private var paginationLoader: some View {
        HStack {
            Spacer()
            ProgressView()
                .progressViewStyle(.circular)
                .task {
                    do {
                        try await viewModel.fetchNextIfNeeded()
                    } catch {
                        print(error)
                    }
                }
            Spacer()
        }
    }

}

struct LoadView_Previews: PreviewProvider {
    static var previews: some View {
        LoadView()
    }
}
