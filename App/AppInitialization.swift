//
//  AppInitialization.swift
//  App
//
//  Created by Gustavo Araujo Santos on 22/12/22.
//

import Foundation
import Shared

class AppInitialization {

    enum Environments {
        case DEV
        case TEST
        case PROD
    }

    func start(env: Environments) {
        if readTokens() == false {
            Task {
                await fetchMandatoryTokens()
            }
        }
        _ = RemoteConfigValues.standard
    }

    private func readTokens() -> Bool {
        guard
            let result = KeychainHelper.standard.read(service: "tokens", account: "domain.com", type: Tokens.self)
        else {
            return false
        }
        saveOnSession(tokens: result)
        return true
    }

    private func fetchMandatoryTokens() async {
        // get on API
        sleep(3)
        let tokens = Tokens(API: "xxx")
        persistOnKeychain(tokens: tokens)
        saveOnSession(tokens: tokens)
    }

    private func persistOnKeychain(tokens: Tokens) {
        KeychainHelper.standard.save(tokens, service: "tokens", account: "domain.com")
    }

    private func saveOnSession(tokens: Tokens) {
        Session.shared.currentTokens = tokens
    }

}
