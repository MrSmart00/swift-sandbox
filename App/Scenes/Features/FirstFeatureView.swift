//
//  FirstFeatureView.swift
//  App
//
//  Created by 日野森寛也 on 2022/11/09.
//

import SwiftUI
import ComposableArchitecture

struct FirstFeatureView: View {
    let store: StoreOf<FirstFeature>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            NavigationLink(
                destination: IfLetStore(
                store.scope(
                    state: \.secondState,
                    action: FirstFeature.Action.second
                ),
                then: { SecondFeatureView(store: $0) }),
                isActive: viewStore.binding(
                    get: { $0.secondState != nil },
                    send: FirstFeature.Action.showSecond(isActive:)
                )
            ) { Text("Second") }
        }
        .navigationTitle("First")
    }
}

struct FirstFeatureView_Previews: PreviewProvider {
    static var previews: some View {
        FirstFeatureView(store: .init(initialState: .init(), reducer: FirstFeature()))
    }
}
