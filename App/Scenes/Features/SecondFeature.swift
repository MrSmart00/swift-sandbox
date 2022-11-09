//
//  SecondFeature.swift
//  App
//
//  Created by 日野森寛也 on 2022/11/09.
//

import Foundation
import ComposableArchitecture

struct SecondFeature: ReducerProtocol {
    struct State: Equatable {
        var thirdState: ThirdFeature.State?
    }
    
    enum Action: Equatable {
        case third(ThirdFeature.Action)
        case tappedThird(isActive: Bool)
    }
    
    var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .tappedThird(let isActive):
                state.thirdState = isActive ? .init() : nil
                return .none
            default:
                return .none
            }
        }
        .ifLet(\.thirdState, action: /Action.third) {
            ThirdFeature()
        }
    }
}
