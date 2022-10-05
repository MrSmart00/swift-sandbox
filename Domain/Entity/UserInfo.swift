//
//  UserInfo.swift
//  Domain
//
//  Created by 日野森寛也 on 2022/10/05.
//

import Foundation

public struct UserInfo: Equatable {
    public let userId: String
    public let email: Email
    
    public init(userId: String, email: Email) {
        self.userId = userId
        self.email = email
    }
}
