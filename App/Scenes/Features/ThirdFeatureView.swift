//
//  ThirdFeatureView.swift
//  App
//
//  Created by 日野森寛也 on 2022/11/09.
//

import SwiftUI
import ComposableArchitecture

struct ThirdFeatureView: View {
    let store: StoreOf<ThirdFeature>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            VStack(spacing: 30) {
                Text("Count \(viewStore.count)")
                Button("Dismis to 1st") {
                    viewStore.send(.dismissToFirst)
                }
                Button("Modal") {
                    viewStore.send(.setSheet(isPresented: true))
                }
            }
            .sheet(
                isPresented: viewStore.binding(
                    get: \.isSheetPresented,
                    send: ThirdFeature.Action.setSheet(isPresented:)
                )
            ) {
                IfLetStore(
                    self.store.scope(
                        state: \.optionalState,
                        action: ThirdFeature.Action.optionalContent
                    )
                ) { OptionalContentView(store: $0) }
            }
        }
        .navigationTitle("Third")
    }
}

struct ThirdFeatureView_Previews: PreviewProvider {
    static var previews: some View {
        ThirdFeatureView(store: .init(initialState: .init(), reducer: ThirdFeature(middleware: .init())))
    }
}
