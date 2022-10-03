//
//  SignupView.swift
//  App
//
//  Created by 日野森寛也 on 2022/10/03.
//

import SwiftUI
import ComposableArchitecture
import Focuser

struct SignupView: View {
    let store: Store<SignupStore.State, SignupStore.Action>
    @FocusStateLegacy var focusedField: SignupStore.State.Field?
    
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
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView(
            store: .init(
                initialState: .init(),
                reducer: SignupStore.reducer,
                environment: .init()
            )
        )
    }
}
