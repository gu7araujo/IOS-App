//
//  ProfileViewController.swift
//  Profile
//
//  Created by Gustavo Araujo Santos on 24/03/23.
//

import UIKit
import DesignSystem
import MSAL

class ProfileViewController: UIViewController {

    var application: MSALPublicClientApplication!
    var accessToken: String?

    private lazy var loggingButton: UIButton = {
        let button = UIButton()
        button.setTitle("Authorize", for: .normal)
        button.addTarget(self, action: #selector(tapAuthorize), for: .touchUpInside)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(.systemGray, for: .disabled)
        return button
    }()

    private lazy var refreshTokenButton: UIButton = {
        let button = UIButton()
        button.setTitle("Refresh Token", for: .normal)
        button.addTarget(self, action: #selector(tapRefreshToken), for: .touchUpInside)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(.systemGray, for: .disabled)
        button.isEnabled = false
        return button
    }()

    private lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Logout", for: .normal)
        button.addTarget(self, action: #selector(tapLogout), for: .touchUpInside)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(.systemGray, for: .disabled)
        button.isEnabled = false
        return button
    }()

    private lazy var feedbackText: UITextView = {
        let textView = UITextView()
        textView.textColor = Colors.black.rawValue
        textView.font = .systemFont(ofSize: 18)
        return textView
    }()

    init() {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .white
        buildTree()
        buildConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        do {
            let siginPolicyAuthority = try self.getAuthority(forPolicy: MSALConfigs.kSignupOrSigninPolicy)
            let pcaConfig = MSALPublicClientApplicationConfig(clientId: MSALConfigs.kClientID, redirectUri: MSALConfigs.kRedirectUri, authority: siginPolicyAuthority)
            pcaConfig.knownAuthorities = [siginPolicyAuthority]
            self.application = try MSALPublicClientApplication(configuration: pcaConfig)
        } catch {
            updateLoggingText(text: "Unable to create application \(error)")
        }
    }

    private func buildTree() {
        view.addSubview(loggingButton)
        view.addSubview(refreshTokenButton)
        view.addSubview(logoutButton)
        view.addSubview(feedbackText)
    }

    private func buildConstraints() {
        loggingButton.translatesAutoresizingMaskIntoConstraints = false
        refreshTokenButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        feedbackText.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            loggingButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            loggingButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            loggingButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),

            refreshTokenButton.topAnchor.constraint(equalTo: loggingButton.bottomAnchor, constant: 5),
            refreshTokenButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            refreshTokenButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),

            logoutButton.topAnchor.constraint(equalTo: refreshTokenButton.bottomAnchor, constant: 5),
            logoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            logoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),

            feedbackText.topAnchor.constraint(equalTo: logoutButton.bottomAnchor, constant: 5),
            feedbackText.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            feedbackText.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            feedbackText.heightAnchor.constraint(equalToConstant: 200)
        ])
    }

    private func getAuthority(forPolicy policy: String) throws -> MSALB2CAuthority {
        guard let authorityURL = URL(string: String(format: MSALConfigs.kEndpoint, MSALConfigs.kAuthorityHostName, MSALConfigs.kTenantName, policy)) else {
            throw NSError(domain: "SomeDomain",
                          code: 1,
                          userInfo: ["errorDescription": "Unable to create authority URL!"])
        }
        return try MSALB2CAuthority(url: authorityURL)
    }

    private func getAccountByPolicy (withAccounts accounts: [MSALAccount], policy: String) throws -> MSALAccount? {

        for account in accounts {
            // This is a single account sample, so we only check the suffic part of the object id,
            // where object id is in the form of <object id>-<policy>.
            // For multi-account apps, the whole object id needs to be checked.
            if let homeAccountId = account.homeAccountId, let objectId = homeAccountId.objectId {
                if objectId.hasSuffix(policy.lowercased()) {
                    return account
                }
            }
        }
        return nil
    }

    @objc private func tapAuthorize() {
        do {
            let authority = try self.getAuthority(forPolicy: MSALConfigs.kSignupOrSigninPolicy)
            let webViewParameters = MSALWebviewParameters(authPresentationViewController: self)
            let parameters = MSALInteractiveTokenParameters(scopes: MSALConfigs.kScopes, webviewParameters: webViewParameters)
            parameters.promptType = .selectAccount
            parameters.authority = authority
            application.acquireToken(with: parameters) { [weak self] (result, error) in

                guard let result = result else {
                    self?.updateLoggingText(text: "Could not acquire token: \(String(describing: error ?? "No error information" as? Error))")
                    return
                }

                self?.accessToken = result.accessToken
                self?.updateLoggingText(text: result.accessToken)

                self?.loggingButton.isEnabled = false
                self?.refreshTokenButton.isEnabled = true
                self?.logoutButton.isEnabled = true
            }
        } catch {
            updateLoggingText(text: "Unable to create authority \(error)")
        }
    }

    @objc private func tapRefreshToken() {
        do {
            let authority = try self.getAuthority(forPolicy: MSALConfigs.kSignupOrSigninPolicy)

            guard let thisAccount = try self.getAccountByPolicy(withAccounts: application.allAccounts(), policy: MSALConfigs.kSignupOrSigninPolicy) else {
                self.updateLoggingText(text: "There is no account available!")
                return
            }

            let parameters = MSALSilentTokenParameters(scopes: MSALConfigs.kScopes, account: thisAccount)
            parameters.authority = authority

            application.acquireTokenSilent(with: parameters) { (result, error) in
                if let error = error {

                    let nsError = error as NSError

                    // interactionRequired means we need to ask the user to sign-in. This usually happens
                    // when the user's Refresh Token is expired or if the user has changed their password
                    // among other possible reasons.

                    if nsError.domain == MSALErrorDomain {

                        if nsError.code == MSALError.interactionRequired.rawValue {

                            // Notice we supply the account here. This ensures we acquire token for the same account
                            // as we originally authenticated.

                            let webviewParameters = MSALWebviewParameters(authPresentationViewController: self)
                            let parameters = MSALInteractiveTokenParameters(scopes: MSALConfigs.kScopes, webviewParameters: webviewParameters)
                            parameters.account = thisAccount

                            self.application.acquireToken(with: parameters) { (result, error) in

                                guard let result = result else {
                                    self.updateLoggingText(text: "Could not acquire new token: \(String(describing: error ?? "No error information" as? Error))")
                                    return
                                }

                                self.accessToken = result.accessToken
                                self.updateLoggingText(text: "Access token is \(self.accessToken ?? "empty")")
                            }
                            return
                        }
                    }

                    self.updateLoggingText(text: "Could not acquire token: \(error)")
                    return
                }

                guard let result = result else {

                    self.updateLoggingText(text: "Could not acquire token: No result returned")
                    return
                }

                self.accessToken = result.accessToken
                self.updateLoggingText(text: "Refreshing token silently")
                self.updateLoggingText(text: "Refreshed access token is \(self.accessToken ?? "empty")")
            }
        } catch {
            updateLoggingText(text: "Unable to construct parameters before calling acquire token \(error)")
        }
    }

    @objc private func tapLogout() {
        do {
            let thisAccount = try getAccountByPolicy(withAccounts: application.allAccounts(), policy: MSALConfigs.kSignupOrSigninPolicy)

            if let accountToRemove = thisAccount {
                try application.remove(accountToRemove)
            } else {
                updateLoggingText(text: "There is no account to signing out!")
            }

            loggingButton.isEnabled = true
            refreshTokenButton.isEnabled = false
            logoutButton.isEnabled = false

            updateLoggingText(text: "Signed out")

        } catch {
            updateLoggingText(text: "Received error signing out: \(error)")
        }
    }

    private func updateLoggingText(text: String) {
        DispatchQueue.main.async {
            self.feedbackText.text = text
        }
    }
}
