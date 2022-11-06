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
            Text(viewStore.text)
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
