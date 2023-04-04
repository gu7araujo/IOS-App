//
//  MSALConfigs.swift
//  Profile
//
//  Created by Gustavo Araujo Santos on 04/04/23.
//

import Foundation

struct MSALConfigs {
    static let kTenantName = "trainingiosapplication.onmicrosoft.com"
    static let kAuthorityHostName = "trainingiosapplication.b2clogin.com"
    static let kClientID = "5e73a91d-2ad4-4c5f-a458-205f4d4a93ca"
    static let kRedirectUri = "msauth.\(Bundle.main.bundleIdentifier ?? "")://auth"
    static let kSignupOrSigninPolicy = "B2C_1A_SIGNUP_SIGNIN"
    static let kEditProfilePolicy = ""
    static let kResetPasswordPolicy = ""
    static let kScopes: [String] = ["https://trainingiosapplication.onmicrosoft.com/ad4e91f4-dbe7-4f4b-bb50-9a0f9cb85410/user_impersonation"]
    static let kEndpoint = "https://%@/tfp/%@/%@"
}
