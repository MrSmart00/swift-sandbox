//
//  ContentView.swift
//  App
//
//  Created by hiroya-hinomori on 2022/10/02.
//

import SwiftUI
import ComposableArchitecture

struct ContentView: View {
    
    let store: Store<ContentStore.State, ContentStore.Action>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text(viewStore.text)
                    .padding()
                if let userInfo = viewStore.userInfo {
                    Text(userInfo.email.rawValue)
                        .font(.caption)
                    Text(userInfo.userId)
                        .font(.caption)
                }
            }
            .padding()
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(
            store: .init(
                initialState: .init(
                    userInfo: .init(
                        userId: "hogehoge",
                        email: .init(rawValue: "aaa@bbb.com")!
                    )
                ),
                reducer: ContentStore.reducer,
                environment: .init()
            )
        )
    }
}
