//
//  SplashTests.swift
//  AppTests
//
//  Created by 日野森寛也 on 2022/10/02.
//

import XCTest
@testable import App
import ComposableArchitecture

@MainActor
final class SplashTests: XCTestCase {

    func test_Splash_Reducer() async {
        let testQueue = DispatchQueue.test
        let store = TestStore(
            initialState: SplashStore.State(),
            reducer: SplashStore.reducer,
            environment: SplashStore.Dependency(queue: testQueue.eraseToAnyScheduler())
        )
        
        _ = await store.send(.onAppear)
        await testQueue.advance(by: .seconds(1))
        await store.receive(.onComplete)
    }
}
