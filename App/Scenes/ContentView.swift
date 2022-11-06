//
//  ContentView.swift
//  App
//
//  Created by hiroya-hinomori on 2022/10/02.
//

import SwiftUI
import ComposableArchitecture

extension ViewFactory {
    static func create(_ store: StoreOf<Content>) -> some View {
        ContentView(store: store)
    }
}

struct ContentView: View {
    let store: StoreOf<Content>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            VStack(spacing: 30) {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text(viewStore.text)
                Button("Optional Content") {
                    viewStore.send(.showOptionalContent)
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
                initialState: .init(),
                reducer: Content()
            )
        )
    }
}
