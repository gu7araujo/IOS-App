//
//  AppCoordinator.swift
//  App
//
//  Created by Gustavo Araujo Santos on 13/12/22.
//

import UIKit
import Shared

class AppCoordinator: CoordinatorProtocol {

    var finishDelegate: CoordinatorFinishDelegate? = nil
    var navigationController: UINavigationController
    var childCoordinators = [CoordinatorProtocol]()
    var type: CoordinatorType = .app

    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        showMainFlow()
    }

    private func showMainFlow() {
        let tabCoordinator = TabCoordinator(navigationController)
        tabCoordinator.finishDelegate = self
        tabCoordinator.start()
        childCoordinators.append(tabCoordinator)
    }

}

extension AppCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: CoordinatorProtocol) {
        childCoordinators = childCoordinators.filter({ $0.type != childCoordinator.type })
    }
}
