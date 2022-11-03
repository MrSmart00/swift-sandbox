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
    
    let store: StoreOf<RootStore>
    
    public var body: some View {
        WithViewStore(store) { viewStore in
            ZStack {
                switch viewStore.state.progress {
                case .splash:
                    ViewFactory.create(
                        store.scope(
                            state: \.splash,
                            action: RootStore.Action.splash
                        )
                    )
                case .content:
                    ViewFactory.create(
                        store.scope(
                            state: \.content,
                            action: RootStore.Action.content
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
