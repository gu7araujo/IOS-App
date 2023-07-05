//
//  DemonstrationCoordinator.swift
//  Shared
//
//  Created by Gustavo Araujo Santos on 05/07/23.
//

import UIKit

public class DemonstrationCoordinator: CoordinatorProtocol {

    weak public var finishDelegate: CoordinatorFinishDelegate?
    public var navigationController: UINavigationController
    public var childCoordinators: [CoordinatorProtocol] = []
    public var type: CoordinatorType = .demonstration
    var newNavigationController: UINavigationController = UINavigationController()

    public required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    deinit {
        print("\(DemonstrationCoordinator.self) deinit")
    }

    public func start() {
        let view = SharedCompositionRoot().buildStartDemonstrationViewController()
        view.delegate = self
        newNavigationController = UINavigationController(rootViewController: view)
        navigationController.present(newNavigationController, animated: true)
    }

}

extension DemonstrationCoordinator: StartDemonstrationViewDelegate {
    public func navigateToSecondScreen() {
        let view = SharedCompositionRoot().buildSecondDemonstrationViewController()
        view.delegate = self
        newNavigationController.pushViewController(view, animated: true)
    }
}

extension DemonstrationCoordinator: SecondDemonstrationViewDelegate {
    func finishFeature() {
        newNavigationController.dismiss(animated: true)
        finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
}
