//
//  ThirdFeature.swift
//  App
//
//  Created by 日野森寛也 on 2022/11/09.
//

import Foundation
import ComposableArchitecture

struct ThirdFeature: ReducerProtocol {
    let middleware: SharedValueMiddleware

    struct State: Equatable {
        var optionalState: OptionalContent.State?
        var count: Int = 0
        var isSheetPresented: Bool { optionalState != nil }
    }
    
    enum Action: Equatable {
        case setSheet(isPresented: Bool)
        case dismissToFirst
        case optionalContent(OptionalContent.Action)
    }
    
    var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .setSheet(let isPresented):
                state.optionalState = isPresented ? .init() : nil
                return .none
            case .dismissToFirst:
                return .none
            case .optionalContent:
                state.count = state.optionalState?.count ?? 0
                return .none
            }
        }
        .ifLet(\.optionalState, action: /Action.optionalContent) {
            OptionalContent(middleware: middleware)
        }
    }
}
