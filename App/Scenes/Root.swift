//
//  Root.swift
//  App
//
//  Created by hiroya-hinomori on 2022/10/02.
//

import Foundation
import ComposableArchitecture

struct Root: ReducerProtocol {
    enum State: Equatable {
        case splash(Splash.State)
        case home(HomeContent.State)
    }

    enum Action: Equatable {
        case splash(Splash.Action)
        case home(HomeContent.Action)
    }
    
    var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .splash(.onComplete):
                state = .home(.init())
            default:
                break
            }
            return .none
        }
        .ifCaseLet(/State.splash, action: /Action.splash) {
            Splash()
        }
        .ifCaseLet(/State.home, action: /Action.home) {
            HomeContent()
        }
    }
}
