//
//  FirstFeature.swift
//  App
//
//  Created by 日野森寛也 on 2022/11/09.
//

import Foundation
import ComposableArchitecture

struct FirstFeature: ReducerProtocol {
    struct State: Equatable {
        var secondState: SecondFeature.State?
    }
    
    enum Action: Equatable {
        case second(SecondFeature.Action)
        case showSecond(isActive: Bool)
    }
    
    var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .showSecond(let isActive):
                state.secondState = isActive ? .init() : nil
                return .none
            case .second(.third(.dismissToFirst)):
                return .init(value: .showSecond(isActive: false))
            default:
                return .none
            }
        }
        .ifLet(\.secondState, action: /Action.second) {
            SecondFeature()
        }
    }
}
