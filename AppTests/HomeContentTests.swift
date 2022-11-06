//
//  HomeContentTests.swift
//  AppTests
//
//  Created by 日野森寛也 on 2022/10/02.
//

import XCTest
@testable import App
import ComposableArchitecture

@MainActor
final class HomeContentTests: XCTestCase {

    func test_Content_Reducer() async {
        let store = TestStore(
            initialState: HomeContent.State(),
            reducer: HomeContent()
        )
        
        _ = await store.send(.onAppear) {
            $0.text = "Hello, world!!!"
        }
        _ = await store.send(.toggleShowSheet) {
            $0.optionalContent = .init()
        }
        _ = await store.send(.toggleShowSheet) {
            $0.optionalContent = nil
        }
    }

}
