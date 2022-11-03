//
//  RootStore.swift
//  App
//
//  Created by hiroya-hinomori on 2022/10/02.
//

import Foundation
import ComposableArchitecture

public enum RootStore: StoreProtocol {
    enum Progress {
        case splash
        case content
    }
    
    struct State: Equatable {
        var progress: Progress = .splash
        var splash = SplashStore.State()
        var content = ContentStore.State()
    }
    
    enum Action: Equatable {
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
            case .splash(let child) where child == .onComplete:
                state.progress = .content
            default:
                break
            }
            return .none
        },
        SplashStore.reducer
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
