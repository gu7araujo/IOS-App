//
//  HomeCoordinator.swift
//  Home
//
//  Created by Gustavo Araujo Santos on 13/12/22.
//

import UIKit
import Shared

public protocol HomeCoordinatorDelegate: AnyObject {
    func increaseBadge()
    func decreaseBadge()
}

public class HomeCoordinator: CoordinatorProtocol {

    weak public var finishDelegate: CoordinatorFinishDelegate?
    public var navigationController: UINavigationController
    public var childCoordinators: [CoordinatorProtocol] = []
    public var type: CoordinatorType = .home

    public weak var delegate: HomeCoordinatorDelegate?

    public required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    deinit {
        print("\(HomeCoordinator.self) deinit")
    }

    public func start() {
        let homeViewController = HomeCompositionRoot().buildHomeViewController()
        homeViewController.delegate = self
        navigationController.pushViewController(homeViewController, animated: true)
    }

}

extension HomeCoordinator: HomeViewDelegate {
    func addItem() {
        delegate?.increaseBadge()
    }

    func removeItem() {
        delegate?.decreaseBadge()
    }

    func navigateToDemonstration() {
        let demonstrationCoordinator = SharedCompositionRoot().buildDemonstrationCoordinator(navigationController)
        demonstrationCoordinator.finishDelegate = self
        demonstrationCoordinator.start()
        childCoordinators.append(demonstrationCoordinator)
    }
}

extension HomeCoordinator: CoordinatorFinishDelegate {
    public func coordinatorDidFinish(childCoordinator: CoordinatorProtocol) {
        childCoordinators = childCoordinators.filter({ $0.type != childCoordinator.type })
    }
}
