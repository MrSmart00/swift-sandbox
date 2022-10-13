//
//  AuthenticationService.swift
//  Sandbox
//
//  Created by 日野森寛也 on 2022/10/05.
//

import Foundation
import Domain
import FirebaseAuth

struct AuthenticationService: AuthenticationProtocol {    
    func signup(email: String, password: String) async throws -> Domain.UserInfo {
        try await withCheckedThrowingContinuation { continuation in
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                if let user = result?.user, let email = Email(rawValue: user.email ?? "") {
                    continuation.resume(returning: Domain.UserInfo(userId: user.uid, email: email))
                } else if let nsError = error as? NSError {
                    print(nsError.userInfo)
                    continuation.resume(throwing: AuthenticationError(message: nsError.userInfo["NSLocalizedDescription"] as! String))
                }
            }
        }
    }
    
    func signin() async throws {
        
    }
    
    
}
