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
        SwitchStore(store) {
            CaseLet(
                state: /Root.State.splash,
                action: Root.Action.splash
            ) { ViewFactory.create($0) }
            CaseLet(
                state: /Root.State.home,
                action: Root.Action.home
            ) { ViewFactory.create($0) }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(
            store: .init(
                initialState: .splash(.init()),
                reducer: Root()
            )
        )
    }
}
