//
//  Root.swift
//  App
//
//  Created by hiroya-hinomori on 2022/10/02.
//

import Foundation
import ComposableArchitecture

struct Root: ReducerProtocol {
    enum Progress {
        case splash
        case content
    }
    
    struct State: Equatable {
        var progress: Progress = .splash
        var splash = Splash.State()
        var content = Content.State()
    }
    
    enum Action: Equatable {
        case splash(Splash.Action)
        case content(Content.Action)
    }
    
    struct Dependency {
        let queue: AnySchedulerOf<DispatchQueue>
    }
    let dependency: Dependency
    
    var body: some ReducerProtocol<State, Action> {
        Scope(state: \.splash, action: /Action.splash) {
            Splash(dependency: .init(queue: dependency.queue))
        }
        
        Scope(state: \.content, action: /Action.content) {
            Content()
        }
        
        Reduce { state, action in
            switch action {
            case .splash(let child) where child == .onComplete:
                state.progress = .content
            default:
                break
            }
            return .none
        }
    }
}
