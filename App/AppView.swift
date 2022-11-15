//
//  AppView.swift
//  App
//
//  Created by 日野森寛也 on 2022/11/06.
//

import SwiftUI
import CombineSchedulers

public struct AppView: View {
    public init() { }

    public var body: some View {
        RootView(
            store: .init(
                initialState: .splash(.init()),
                reducer: Root()
                .signpost()
                ._printChanges()
            )
        )
        .modifier(DebugPresentationModifier())
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
