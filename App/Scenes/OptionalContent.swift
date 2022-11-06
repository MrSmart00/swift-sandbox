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
        var text: String {
            "Count \(count)"
        }
        var count: Int = 0
    }
    
    enum Action {
        case onAppear
        case increase
        case reset
    }
    
    func reduce(into state: inout State, action: Action) -> ComposableArchitecture.EffectTask<Action> {
        switch action {
        case .onAppear:
            return .none
        case .increase:
            state.count += 1
            return .none
        case .reset:
            state.count = 0
            return .none
        }
    }
}
