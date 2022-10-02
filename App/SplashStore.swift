//
//  SplashStore.swift
//  App
//
//  Created by 日野森寛也 on 2022/10/02.
//

import Foundation
import ComposableArchitecture

enum SplashStore {
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
    
    static let reducer = Reducer<State, Action, Dependency> { state, action, dependency in
        enum CancelID {}
        
        switch action {
        case .onAppear:
            return .task {
                try await dependency.queue.sleep(for: 1)
                return .onComplete
            }
            .cancellable(id: CancelID.self, cancelInFlight: true)
        case .onComplete:
            return .none
        }
    }
}
