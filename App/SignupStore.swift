//
//  SignupStore.swift
//  App
//
//  Created by 日野森寛也 on 2022/10/03.
//

import Foundation
import ComposableArchitecture
import Focuser
import FirebaseAuth

enum SignupStore {
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

            @available(iOS, introduced: 13.0, deprecated: 15.0)
            static var last: SignupStore.State.Field {
                .password
            }
            
            @available(iOS, introduced: 13.0, deprecated: 15.0)
            var next: SignupStore.State.Field? {
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
        case fetchedUserInfo(String)
        case failedUserInfo(Error)
        case alertDismissed
    }
    
    struct Dependency {
        
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
            return .run { [email = state.email, password = state.password] send in
                let userId = try await withCheckedThrowingContinuation { continuation in
                    Auth.auth().createUser(withEmail: email, password: password) { result, error in
                        if let user = result?.user {
                            print(user)
                            continuation.resume(returning: user.uid)
                        } else if let nsError = error as? NSError {
                            print(nsError.userInfo)
                            continuation.resume(throwing: Error(message: nsError.userInfo["NSLocalizedDescription"] as! String))
                        }
                    }
                }
                await send(.fetchedUserInfo(userId))
            } catch: { error, send in
                await send(.failedUserInfo(error as! SignupStore.Error))
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

