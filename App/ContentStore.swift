//
//  ContentStore.swift
//  App
//
//  Created by hiroya-hinomori on 2022/10/02.
//

import Foundation
import ComposableArchitecture

enum ContentStore {
    struct State: Equatable {
        var text = ""
    }
    
    enum Action {
        case onAppear
    }
    
    struct Dependency {
        
    }
    
    static let reducer = Reducer<State, Action, Dependency> { state, action, dependency in
        switch action {
        case .onAppear:
            state.text = "Hello, world!!!"
            return .none
        }
    }
}
