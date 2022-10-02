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
        var splash: SplashStore.State? = .init()
        var content = ContentStore.State()
    }
    
    enum Action {
        case splash(SplashStore.Action)
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
            case let .splash(childAction):
                switch childAction {
                case .onComplete:
                    state.splash = nil
                default:
                    break
                }
                return .none
            default:
                return .none
            }
        },
        SplashStore.reducer
            .optional()
            .pullback(
                state: \.splash,
                action: /RootStore.Action.splash,
                environment: { .init(queue: $0.queue) }
            ),
        ContentStore.reducer
            .pullback(
                state: \.content,
                action: /RootStore.Action.content,
                environment: { _ in .init() }
            )
    )
}
