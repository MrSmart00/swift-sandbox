//
//  OptionalContentView.swift
//  App
//
//  Created by 日野森寛也 on 2022/11/06.
//

import SwiftUI
import ComposableArchitecture

extension ViewFactory {
    static func create(_ store: StoreOf<OptionalContent>) -> some View {
        OptionalContentView(store: store)
    }
}

struct OptionalContentView: View {
    let store: StoreOf<OptionalContent>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            VStack(spacing: 30) {
                Text(viewStore.text)
                Button("Incrase") {
                    viewStore.send(.increase)
                }
                Button("Reset") {
                    viewStore.send(.reset)
                }
            }
        }
    }
}

struct OptionalContentView_Previews: PreviewProvider {
    static var previews: some View {
        OptionalContentView(
            store: .init(
                initialState: .init(),
                reducer: OptionalContent()
            )
        )
    }
}
