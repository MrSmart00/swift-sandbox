//
//  SignupView.swift
//  App
//
//  Created by 日野森寛也 on 2022/10/03.
//

import SwiftUI
import ComposableArchitecture
import Focuser
import Domain

struct SignupView: View {
    let store: Store<AuthenticationStore.State, AuthenticationStore.Action>
    @FocusStateLegacy var focusedField: AuthenticationStore.State.Field?
    
    var body: some View {
        WithViewStore(store) { viewStore in
            VStack(spacing: 30) {
                TextField(
                    "E-Mail",
                    text: viewStore.binding(\.$email)
                )
                .focusedLegacy($focusedField, equals: .email)
                
                SecureField(
                    "Password",
                    text: viewStore.binding(\.$password)
                )
                .focusedLegacy($focusedField, equals: .password)
                
                Button("Sign Up") {
                    viewStore.send(.tappedSignUp)
                }
            }
            .padding()
            .textFieldStyle(.roundedBorder)
        }
        .alert(
            store.scope(state: \.alert),
            dismiss: .alertDismissed
        )
    }
}

struct SignupView_Previews: PreviewProvider {
    struct MockAuth: AuthenticationProtocol {
        func signup(email: String, password: String) async throws -> Domain.UserInfo {
            .init(userId: "USER ID", email: .init(rawValue: "aaa@bbb.com")!)
        }
        
        func signin() async throws {
            
        }
    }

    static var previews: some View {
        SignupView(
            store: .init(
                initialState: .init(),
                reducer: AuthenticationStore.reducer,
                environment: .init(authentication: MockAuth())
            )
        )
    }
}
