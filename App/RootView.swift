//
//  RootView.swift
//  App
//
//  Created by hiroya-hinomori on 2022/10/02.
//

import SwiftUI
import ComposableArchitecture

public struct RootView: View {
    public init(with dependency: RootStore.Dependency) {
        store = .init(
            initialState: .init(),
            reducer: RootStore.reducer
                .debug()
                .signpost(),
            environment: dependency
        )
    }
    
    let store: Store<RootStore.State, RootStore.Action>
    
    public var body: some View {
        WithViewStore(store) { viewStore in
            ZStack {
                if !viewStore.isReady {
                    VStack {
                        Text("Initializing...")
                    }
                } else {
                    ContentView(
                        store: store.scope(
                            state: \.content,
                            action: RootStore.Action.content
                        )
                    )
                }
            }
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(with: .init())
    }
}
