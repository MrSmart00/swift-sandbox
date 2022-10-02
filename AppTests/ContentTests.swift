//
//  ContentTests.swift
//  AppTests
//
//  Created by 日野森寛也 on 2022/10/02.
//

import XCTest
@testable import App
import ComposableArchitecture

@MainActor
final class ContentTests: XCTestCase {

    func test_Content_Reducer() async {
        let store = TestStore(
            initialState: ContentStore.State(),
            reducer: ContentStore.reducer,
            environment: ContentStore.Dependency()
        )
        
        _ = await store.send(.onAppear) {
            $0.text = "Hello, world!!!"
        }
    }

}
