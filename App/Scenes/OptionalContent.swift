//
//  OptionalContent.swift
//  App
//
//  Created by 日野森寛也 on 2022/11/06.
//

import Foundation
import ComposableArchitecture

struct OptionalContent: ReducerProtocol {
    struct State: Equatable {
        var text: String = "Count -"
        var count: Int = 0
    }
    
    enum Action {
        case onAppear
        case countUp
        case resetCount
    }
    
    func reduce(into state: inout State, action: Action) -> ComposableArchitecture.EffectTask<Action> {
        switch action {
        case .onAppear:
            state.text = "Count \(state.count)"
            return .none
        case .countUp:
            state.count += 1
            return .none
        case .resetCount:
            state.count = 0
            return .none
        }
    }
}
