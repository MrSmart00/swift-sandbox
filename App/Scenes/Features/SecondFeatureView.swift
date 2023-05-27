//
//  SecondFeatureView.swift
//  App
//
//  Created by 日野森寛也 on 2022/11/09.
//

import SwiftUI
import ComposableArchitecture

struct SecondFeatureView: View {
    let store: StoreOf<SecondFeature>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            NavigationLink(
                destination: IfLetStore(
                store.scope(
                    state: \.thirdState,
                    action: SecondFeature.Action.third
                ),
                then: { ThirdFeatureView(store: $0) }),
                isActive: viewStore.binding(
                    get: { $0.thirdState != nil },
                    send: SecondFeature.Action.tappedThird(isActive:)
                )
            ) { Text("Third") }
        }
        .navigationTitle("Second")
    }
}

struct SecondFeatureView_Previews: PreviewProvider {
    static var previews: some View {
        SecondFeatureView(store: .init(initialState: .init(), reducer: SecondFeature(middleware: .init())))
    }
}
