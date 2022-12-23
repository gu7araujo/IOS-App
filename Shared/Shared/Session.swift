//
//  Session.swift
//  Shared
//
//  Created by Gustavo Araujo Santos on 22/12/22.
//

import Combine

public struct Tokens: Codable {
    public let API: String

    public init(API: String) {
        self.API = API
    }
}

public class Session {

    public static var shared: Session = {
        let instance = Session()
        return instance
    }()

    private init() { }

    @Published public var currentTokens: Tokens?
}
