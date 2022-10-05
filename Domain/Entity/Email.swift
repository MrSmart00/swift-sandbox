//
//  Email.swift
//  Domain
//
//  Created by 日野森寛也 on 2022/10/05.
//

import Foundation

public struct Email: RawRepresentable, Equatable {
    public let rawValue: String
    private static let regex = "^[\\p{L}0-9!#$%&'*+\\/=?^_`{|}~-][\\p{L}0-9.!#$%&'*+\\/=?^_`{|}~-]{0,63}@[\\p{L}0-9-]+(?:\\.[\\p{L}0-9-]{2,7})*$"

    public init?(rawValue: String) {
        let evalResult = NSPredicate(
            format: "SELF MATCHES %@",
            Email.regex
        ).evaluate(with: rawValue)

        if evalResult == true {
            self.rawValue = rawValue
        } else {
            return nil
        }
    }
}

