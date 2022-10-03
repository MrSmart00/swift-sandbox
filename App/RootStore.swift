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
        var splash = SplashStore.State()
        var signup = SignupStore.State()
        var content = ContentStore.State()
    }
    
    enum Action: Equatable {
        case splash(SplashStore.Action)
        case signup(SignupStore.Action)
        case content(ContentStore.Action)
    }
    
    public struct Dependency {
        var queue: AnySchedulerOf<DispatchQueue>
        
        public init(queue: AnySchedulerOf<DispatchQueue>) {
            self.queue = queue
        }
    }
    
    static let reducer = Reducer<State, Action, Dependency>.combine(
        .init { state, action, dependency in
            switch action {
            default:
                return .none
            }
        },
        SplashStore.reducer
            .pullback(
                state: \.splash,
                action: /RootStore.Action.splash,
                environment: { .init(queue: $0.queue) }
            ),
        SignupStore.reducer
            .pullback(
                state: \.signup,
                action: /RootStore.Action.signup,
                environment: { _ in .init() }
            ),
        ContentStore.reducer
            .pullback(
                state: \.content,
                action: /RootStore.Action.content,
                environment: { _ in .init() }
            )
    )
}
