//
//  StoreProtocol.swift
//  App
//
//  Created by 日野森寛也 on 2022/11/03.
//

import Foundation
import ComposableArchitecture

typealias StoreOf<P: StoreProtocol> = Store<P.State, P.Action>

protocol StoreProtocol {
    associatedtype State: Equatable
    associatedtype Action
    associatedtype Dependency
    
    static var reducer: Reducer<State, Action, Dependency> { get }
}
