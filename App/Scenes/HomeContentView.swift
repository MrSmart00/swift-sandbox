//
//  HomeContentView.swift
//  App
//
//  Created by hiroya-hinomori on 2022/10/02.
//

import SwiftUI
import ComposableArchitecture

extension ViewFactory {
    static func create(_ store: StoreOf<HomeContent>) -> some View {
        HomeContentView(store: store)
    }
}

struct HomeContentView: View {
    let store: StoreOf<HomeContent>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            NavigationView {
                VStack(spacing: 30) {
                    Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundColor(.accentColor)
                    Text(viewStore.text)
                    Button("Optional Content") {
                        viewStore.send(.toggleShowSheet)
                    }
                    
                    NavigationLink(
                        destination: IfLetStore(
                            store.scope(
                                state: \.featureState,
                                action: HomeContent.Action.feature
                            ), then: { FirstFeatureView(store: $0) }
                        ),
                        isActive: viewStore.binding(
                            get: { $0.featureState != nil },
                            send: HomeContent.Action.showFeature(isActive:)
                        )
                    ) { Text("Navigation Content") }
                }
            }
            .navigationViewStyle(.stack)
            .onAppear { viewStore.send(.onAppear) }
            .sheet(isPresented: viewStore.binding(
                get: { $0.optionalContent != nil },
                send: HomeContent.Action.toggleShowSheet
            )) {
                IfLetStore(
                    store.scope(
                        state: \.optionalContent,
                        action: HomeContent.Action.optionalContent
                    )
                ) { ViewFactory.create($0) }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeContentView(
            store: .init(
                initialState: .init(),
                reducer: HomeContent()
            )
        )
    }
}
