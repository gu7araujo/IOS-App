//
//  AppInitialization.swift
//  App
//
//  Created by Gustavo Araujo Santos on 22/12/22.
//

import Foundation
import Shared

class AppInitialization {

    func start() {
        verifyAPITokens()
    }

    private func verifyAPITokens() {
        let tokensOnKeychain = fetchTokenOnKeychain()
        if let tokens = tokensOnKeychain {
            saveOnSessionAndContinue(tokens: tokens)
        } else {
            Task { await fetchTokensFromAPI() }
        }
    }

    private func fetchTokenOnKeychain() -> Tokens? {
        guard
            let result = KeychainHelper.standard.read(service: "tokens", account: "domain.com", type: Tokens.self)
        else {
            return nil
        }
        return result
    }

    private func fetchTokensFromAPI() async {
        // simulate fetch from API
        sleep(3)
        let tokens = Tokens(API: "xxx")
        persistOnKeychain(tokens: tokens)
        saveOnSessionAndContinue(tokens: tokens)
    }

    private func persistOnKeychain(tokens: Tokens) {
        KeychainHelper.standard.save(tokens, service: "tokens", account: "domain.com")
    }

    private func saveOnSessionAndContinue(tokens: Tokens) {
        Session.shared.currentTokens = tokens
    }

}
