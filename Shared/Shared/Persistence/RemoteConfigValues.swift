//
//  RemoteConfigValues.swift
//  Shared
//
//  Created by Gustavo Araujo Santos on 23/01/23.
//

import Combine
import FirebaseRemoteConfig

public class RemoteConfigValues {

    public enum ValueKey: String {
        case homeScreenButton1Text
        case homeScreenButton2Text
        case homeScreenButton3Text
    }

    @Published public var fetchComplete = false

    public static let standard = RemoteConfigValues()

    private init() {
        loadDefaultValues()
        fetchCloudValues()
    }

    private func loadDefaultValues() {
        let appDefaults: [String: Any?] = [
            ValueKey.homeScreenButton1Text.rawValue: "text default",
            ValueKey.homeScreenButton2Text.rawValue: "text default",
            ValueKey.homeScreenButton3Text.rawValue: "text default"
        ]
        RemoteConfig.remoteConfig().setDefaults(appDefaults as? [String: NSObject])
    }

    private func activateDebugMode() {
        let settings = RemoteConfigSettings()
        // WARNING: Don't actually do this in production!
        settings.minimumFetchInterval = 0
        RemoteConfig.remoteConfig().configSettings = settings
    }

    private func fetchCloudValues() {
//        activateDebugMode()
        RemoteConfig.remoteConfig().fetch { [weak self] _, error in
            if let error = error {
                debugPrint("Uh-oh. Got an error fetching remote values \(error)")
                return
            }

            RemoteConfig.remoteConfig().activate { _, _ in
                debugPrint("Retrieved values from the cloud!")
                self?.fetchComplete = true
            }
        }
    }

    public func bool(forKey key: ValueKey) -> Bool {
        RemoteConfig.remoteConfig()[key.rawValue].boolValue
    }

    public func string(forKey key: ValueKey) -> String {
        RemoteConfig.remoteConfig()[key.rawValue].stringValue ?? ""
    }

    public func double(forKey key: ValueKey) -> Double {
        RemoteConfig.remoteConfig()[key.rawValue].numberValue.doubleValue
    }

}
