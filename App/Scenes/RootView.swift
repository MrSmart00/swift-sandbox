//
//  RootView.swift
//  App
//
//  Created by hiroya-hinomori on 2022/10/02.
//

import SwiftUI
import ComposableArchitecture

public struct RootView: View {
    let store: StoreOf<Root>
    
    public var body: some View {
        WithViewStore(store) { viewStore in
            ZStack {
                switch viewStore.state.progress {
                case .splash:
                    ViewFactory.create(
                        store.scope(
                            state: \.splash,
                            action: Root.Action.splash
                        )
                    )
                case .home:
                    ViewFactory.create(
                        store.scope(
                            state: \.home,
                            action: Root.Action.home
                        )
                    )
                }
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(
            store: .init(
                initialState: .init(),
                reducer: Root(dependency: .init(queue: .main))
            )
        )
    }
}
