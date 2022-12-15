//
//  HomeCoordinator.swift
//  Home
//
//  Created by Gustavo Araujo Santos on 13/12/22.
//

import UIKit
import Shared

public class HomeCoordinator: CoordinatorProtocol {

    weak public var finishDelegate: CoordinatorFinishDelegate?
    public var navigationController: UINavigationController
    public var childCoordinators: [CoordinatorProtocol] = []
    public var type: CoordinatorType = .home

    public required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    public func start() {
        let homeViewController = HomeViewController()
        navigationController.pushViewController(homeViewController, animated: true)
    }

}
