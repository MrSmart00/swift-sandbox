//
//  RootTests.swift
//  AppTests
//
//  Created by 日野森寛也 on 2022/10/02.
//

import XCTest
@testable import App
import ComposableArchitecture

@MainActor
final class RootTests: XCTestCase {

    func test_Root_Reducer_Splash() async {
        let testQueue = DispatchQueue.test
        let store = TestStore(
            initialState: Root.State(),
            reducer: Root(dependency: .init(queue: testQueue.eraseToAnyScheduler()))
        )
        _ = await store.send(.splash(.onAppear))
        await testQueue.advance(by: .seconds(1))
        await store.receive(.splash(.onComplete)) {
            $0.progress = .home
        }
    }

    func test_Root_Reducer_Content() async {
        let testQueue = DispatchQueue.test
        let store = TestStore(
            initialState: Root.State(),
            reducer: Root(dependency: .init(queue: testQueue.eraseToAnyScheduler()))
        )
        _ = await store.send(.home(.onAppear)) {
            $0.home.text = "Hello, world!!!"
        }
        _ = await store.send(.home(.toggleShowSheet)) {
            $0.home.optionalContent = .init()
        }
        _ = await store.send(.home(.toggleShowSheet)) {
            $0.home.optionalContent = nil
        }
    }

}
