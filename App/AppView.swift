//
//  AppView.swift
//  App
//
//  Created by 日野森寛也 on 2022/11/06.
//

import SwiftUI
import CombineSchedulers

public struct AppInjection {
    let queue: DispatchQueue
    
    public init(queue: DispatchQueue) {
        self.queue = queue
    }
}

public struct AppView: View {
    let injection: AppInjection
    
    public init(injection: AppInjection) {
        self.injection = injection
    }

    public var body: some View {
        RootView(
            store: .init(
                initialState: .init(),
                reducer: Root(
                    dependency: .init(queue: injection.queue.eraseToAnyScheduler())
                )
                .signpost()
                ._printChanges()
            )
        )
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView(injection: .init(queue: .main))
    }
}
