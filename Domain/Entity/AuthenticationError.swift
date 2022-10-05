//
//  AuthenticationError.swift
//  Domain
//
//  Created by 日野森寛也 on 2022/10/05.
//

import Foundation

public struct AuthenticationError: Swift.Error, Equatable {
    public let message: String
    
    public init(message: String) {
        self.message = message
    }
}
