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
                if viewStore.splash.isCompleted {
                    ContentView(
                        store: store.scope(
                            state: \.content,
                            action: RootStore.Action.content
                        )
                    )
                } else {
                    SplashView(
                        store: store.scope(
                            state: \.splash,
                            action: RootStore.Action.splash
                        )
                    )
                }
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(with: .init(queue: .main))
    }
}
