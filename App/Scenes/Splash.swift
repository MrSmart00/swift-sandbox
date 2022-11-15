//
//  Splash.swift
//  App
//
//  Created by 日野森寛也 on 2022/10/02.
//

import Foundation
import ComposableArchitecture

struct Splash: ReducerProtocol {
    struct State: Equatable {
        
    }
    
    enum Action: Equatable {
        case onAppear
        case onComplete
    }
    
    @Dependency(\.mainQueue) var queue
    
    func reduce(into state: inout State, action: Action) -> ComposableArchitecture.EffectTask<Action> {
        enum CancelID {}
        
        switch action {
        case .onAppear:
            return .task {
                try await queue.sleep(for: 1)
                return .onComplete
            }
            .cancellable(id: CancelID.self)
        case .onComplete:
            return .none
        }
    }
}
