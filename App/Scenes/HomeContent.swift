//
//  HomeContent.swift
//  App
//
//  Created by hiroya-hinomori on 2022/10/02.
//

import Foundation
import ComposableArchitecture

struct HomeContent: ReducerProtocol {
    struct State: Equatable {
        var text = ""
        var optionalContent: OptionalContent.State?
        var featureState: FirstFeature.State?
    }
    
    enum Action: Equatable {
        case onAppear
        case toggleShowSheet
        case optionalContent(OptionalContent.Action)
        case feature(FirstFeature.Action)
        case showFeature(isActive: Bool)
    }
    
    var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                state.text = "Hello, world!!!"
                return .none
            case .toggleShowSheet:
                state.optionalContent = state.optionalContent == nil ? .init() : nil
                return .none
            case .optionalContent:
                return .none
            case .showFeature(let isActive):
                state.featureState = isActive ? .init() : nil
                return .none
            default:
                return .none
            }
        }
        .ifLet(\.optionalContent, action: /Action.optionalContent) {
            OptionalContent(middleware: .init())
        }
        .ifLet(\.featureState, action: /Action.feature) {
            FirstFeature()
        }
    }
}
