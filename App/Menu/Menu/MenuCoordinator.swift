//
//  MenuCoordinator.swift
//  Menu
//
//  Created by Gustavo Araujo Santos on 13/12/22.
//

import UIKit
import Shared

public class MenuCoordinator: CoordinatorProtocol {

    weak public var finishDelegate: CoordinatorFinishDelegate?
    public var navigationController: UINavigationController
    public var childCoordinators: [CoordinatorProtocol] = []
    public var type: CoordinatorType = .menu

    public required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    public func start() {
        let menuViewController = MenuViewController()
        navigationController.pushViewController(menuViewController, animated: true)
    }

}
