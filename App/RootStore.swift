//
//  RootStore.swift
//  App
//
//  Created by hiroya-hinomori on 2022/10/02.
//

import Foundation
import ComposableArchitecture

public enum RootStore {
    struct State: Equatable {
        var isReady = false
        var content = ContentStore.State()
    }
    
    enum Action {
        case onAppear
        case content(ContentStore.Action)
    }
    
    public struct Dependency {
        public init() { }
    }
    
    static let reducer = Reducer<State, Action, Dependency>.combine(
        .init { state, action, dependency in
            switch action {
            case .onAppear:
                state.isReady = true
                return .none
            case let .content(contentAction):
                print(contentAction)
                return .none
            }
        },
        ContentStore.reducer
            .pullback(
                state: \.content,
                action: /RootStore.Action.content,
                environment: { _ in .init() }
            )
    )
}
