//
//  AppCoordinator.swift
//  App
//
//  Created by Gustavo Araujo Santos on 13/12/22.
//

import UIKit
import Shared

class AppCoordinator: CoordinatorProtocol {

    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators = [CoordinatorProtocol]()
    var type: CoordinatorType = .app

    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    deinit {
        print("\(AppCoordinator.self) deinit")
    }

    func start() {
        let tabCoordinator = MainCompositionRoot().buildTabCoordinator(navigationController)
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
