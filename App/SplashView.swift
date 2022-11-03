//
//  SplashView.swift
//  App
//
//  Created by 日野森寛也 on 2022/10/02.
//

import SwiftUI
import ComposableArchitecture

struct SplashView: View {
    let store: StoreOf<SplashStore>
    
    var body: some View {
        WithViewStore(store) { viewState in
            ZStack(alignment: .center) {
                Color(.black)
                    .opacity(0.3)
                    .ignoresSafeArea()
                VStack {
                    Text("Initializing...")
                    IndicatorView()
                }
            }
            .onAppear {
                viewState.send(.onAppear)
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView(
            store: .init(
                initialState: .init(),
                reducer: SplashStore.reducer,
                environment: .init(queue: .main)
            )
        )
    }
}
