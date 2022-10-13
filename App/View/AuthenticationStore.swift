//
//  AuthenticationStore.swift
//  App
//
//  Created by 日野森寛也 on 2022/10/03.
//

import Foundation
import ComposableArchitecture
import Focuser
import Domain

enum AuthenticationStore {
    struct Error: Swift.Error, Equatable {
        let message: String
    }
    
    struct State: Equatable {
        @BindableState var focusedField: Field?
        @BindableState var password: String = ""
        @BindableState var email: String = ""
        var alert: AlertState<Action>?

        enum Field: String, Hashable, FocusStateCompliant {
            case email
            case password

            static var last: AuthenticationStore.State.Field {
                .password
            }
            
            var next: AuthenticationStore.State.Field? {
                switch self {
                case .email:
                    return .password
                default:
                    return nil
                }
            }
        }
    }
    
    enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case tappedSignUp
        case fetchedUserInfo(UserInfo)
        case failedUserInfo(Error)
        case alertDismissed
    }
    
    struct Dependency {
        var authentication: AuthenticationProtocol
    }
    
    static let reducer = Reducer<State, Action, Dependency> { state, action, dependency in
        enum CancelID {}
        
        switch action {
        case .binding:
            return .none
        case .alertDismissed:
            state.alert = nil
            return .none
        case .tappedSignUp:
            if state.email.isEmpty {
                state.focusedField = .email
            } else if state.password.isEmpty {
                state.focusedField = .password
            }
            return .task { [email = state.email, password = state.password] in
                let userId = try await dependency.authentication.signup(email: email, password: password)
                return .fetchedUserInfo(userId)
            } catch: {
                .failedUserInfo($0 as! AuthenticationStore.Error)
            }
            .cancellable(id: CancelID.self)
        case .fetchedUserInfo:
            return .none
        case let .failedUserInfo(error):
            state.alert = .init(title: .init(error.message))
            return .none
        }
    }.binding()
}

