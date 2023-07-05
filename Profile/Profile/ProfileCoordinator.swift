//
//  ProfileCoordinator.swift
//  Profile
//
//  Created by Gustavo Araujo Santos on 24/03/23.
//

import UIKit
import Shared

public class ProfileCoordinator: CoordinatorProtocol {

    weak public var finishDelegate: CoordinatorFinishDelegate?
    public var navigationController: UINavigationController
    public var childCoordinators: [CoordinatorProtocol] = []
    public var type: CoordinatorType = .profile

    public required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    deinit {
        print("\(ProfileCoordinator.self) deinit")
    }

    public func start() {
        let profileViewController = ProfileCompositionRoot().buildProfileViewController()
        navigationController.pushViewController(profileViewController, animated: true)
    }
}
