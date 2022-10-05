//
//  RootStore.swift
//  App
//
//  Created by hiroya-hinomori on 2022/10/02.
//

import Foundation
import ComposableArchitecture
import Domain

public enum RootStore {
    struct State: Equatable {
        var splash = SplashStore.State()
        var signup = AuthenticationStore.State()
        var content = ContentStore.State()
    }
    
    enum Action: Equatable {
        case splash(SplashStore.Action)
        case signup(AuthenticationStore.Action)
        case content(ContentStore.Action)
    }
    
    public struct Dependency {
        var authentication: AuthenticationProtocol
        var queue: AnySchedulerOf<DispatchQueue>
        
        public init(
            authentication: AuthenticationProtocol,
            queue: AnySchedulerOf<DispatchQueue>
        ) {
            self.authentication = authentication
            self.queue = queue
        }
    }
    
    static let reducer = Reducer<State, Action, Dependency>.combine(
        .init { state, action, dependency in
            switch action {
            case let .signup(act):
                switch act {
                case let .fetchedUserInfo(userInfo):
                    state.content.userInfo = userInfo
                default:
                    break
                }
                return .none
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
        AuthenticationStore.reducer
            .pullback(
                state: \.signup,
                action: /RootStore.Action.signup,
                environment: { .init(authentication: $0.authentication) }
            ),
        ContentStore.reducer
            .pullback(
                state: \.content,
                action: /RootStore.Action.content,
                environment: { _ in .init() }
            )
    )
}
