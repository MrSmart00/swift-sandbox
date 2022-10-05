//
//  AuthenticationProtocol.swift
//  Domain
//
//  Created by 日野森寛也 on 2022/10/05.
//

import Foundation

public protocol AuthenticationProtocol {
    func signup(email: String, password: String) async throws -> UserInfo
    func signin() async throws -> Void
}
