//
//  Content.swift
//  App
//
//  Created by hiroya-hinomori on 2022/10/02.
//

import Foundation
import ComposableArchitecture

struct Content: ReducerProtocol {
    struct State: Equatable {
        var text = ""
    }
    
    enum Action {
        case onAppear
    }
    
    func reduce(into state: inout State, action: Action) -> ComposableArchitecture.EffectTask<Action> {
        switch action {
        case .onAppear:
            state.text = "Hello, world!!!"
            return .none
        }
    }
}
