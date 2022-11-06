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
    
    enum Action {
        case onAppear
        case onComplete
    }
    
    struct Dependency {
        var queue: AnySchedulerOf<DispatchQueue>
        
        public init(queue: AnySchedulerOf<DispatchQueue>) {
            self.queue = queue
        }
    }
    
    let dependency: Dependency
    
    func reduce(into state: inout State, action: Action) -> ComposableArchitecture.EffectTask<Action> {
        enum CancelID {}
        
        switch action {
        case .onAppear:
            return .task {
                try await dependency.queue.sleep(for: 1)
                return .onComplete
            }
            .cancellable(id: CancelID.self)
        case .onComplete:
            return .none
        }
    }
}
