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
        case home
    }
    
    struct State: Equatable {
        var progress: Progress = .splash
        var splash = Splash.State()
        var home = HomeContent.State()
    }
    
    enum Action: Equatable {
        case splash(Splash.Action)
        case home(HomeContent.Action)
    }
    
    struct Dependency {
        let queue: AnySchedulerOf<DispatchQueue>
    }
    let dependency: Dependency
    
    var body: some ReducerProtocol<State, Action> {
        Scope(state: \.splash, action: /Action.splash) {
            Splash(dependency: .init(queue: dependency.queue))
        }
        
        Scope(state: \.home, action: /Action.home) {
            HomeContent()
        }
        
        Reduce { state, action in
            switch action {
            case .splash(let child) where child == .onComplete:
                state.progress = .home
            default:
                break
            }
            return .none
        }
    }
}
