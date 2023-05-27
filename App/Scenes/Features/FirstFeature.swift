//
//  FirstFeature.swift
//  App
//
//  Created by 日野森寛也 on 2022/11/09.
//

import Foundation
import ComposableArchitecture
import Combine

class SharedValueMiddleware {
    private var cancellables = Set<AnyCancellable>()
    private var currentCount = CurrentValueSubject<Int, Never>(0)
    
    func send(count: Int) {
        currentCount.send(count)
    }
    
    func respondsEvent() async -> Int {
        await withCheckedContinuation { continuation in
            currentCount
                .sink {
                    continuation.resume(returning: $0)
                }
                .store(in: &cancellables)
        }
    }
}

struct FirstFeature: ReducerProtocol {
    let middleware = SharedValueMiddleware()
    
    struct State: Equatable {
        var secondState: SecondFeature.State?
    }
    
    enum Action: Equatable {
        case onAppear
        case onCatchCount(Int)
        case second(SecondFeature.Action)
        case showSecond(isActive: Bool)
    }
    
    var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .run { sender in
                    let count = await middleware.respondsEvent()
                    await sender.send(.onCatchCount(count))
                }
            case .onCatchCount(let count):
                print("#### \(count)")
                return .none
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
            SecondFeature(middleware: middleware)
        }
    }
}
