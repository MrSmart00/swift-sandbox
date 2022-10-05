//
//  RootView.swift
//  App
//
//  Created by hiroya-hinomori on 2022/10/02.
//

import SwiftUI
import ComposableArchitecture
import Domain

public struct RootView: View {
    public init(with dependency: RootStore.Dependency) {
        store = .init(
            initialState: .init(),
            reducer: RootStore.reducer
                .debug()
                .signpost(),
            environment: dependency
        )
    }
    
    let store: Store<RootStore.State, RootStore.Action>
    
    public var body: some View {
        WithViewStore(store) { viewStore in
            ZStack {
                if viewStore.splash.isCompleted {
                    IfLetStore(
                        store.scope(state: \.content.userInfo),
                        then: { _ in
                            ContentView(
                                store: store.scope(
                                    state: \.content,
                                    action: RootStore.Action.content
                                )
                            )
                        },
                        else: {
                            SignupView(
                                store: store.scope(
                                    state: \.signup,
                                    action: RootStore.Action.signup
                                )
                            )
                        }
                    )
                } else {
                    SplashView(
                        store: store.scope(
                            state: \.splash,
                            action: RootStore.Action.splash
                        )
                    )
                }
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    struct MockAuth: AuthenticationProtocol {
        func signup(email: String, password: String) async throws -> Domain.UserInfo {
            .init(userId: "USER ID!!!", email: .init(rawValue: "aaa@bbb.com")!)
        }
        
        func signin() async throws {
            
        }
    }

    static var previews: some View {
        RootView(with: .init(authentication: MockAuth(), queue: .main))
    }
}
