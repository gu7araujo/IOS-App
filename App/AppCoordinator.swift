//
//  AppCoordinator.swift
//  App
//
//  Created by Gustavo Araujo Santos on 13/12/22.
//

import Combine
import UIKit
import Shared

class AppCoordinator: CoordinatorProtocol {

    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators = [CoordinatorProtocol]()
    var type: CoordinatorType = .app

    private var cancellables: [AnyCancellable] = []

    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        bindPublishers()
    }

    private func bindPublishers() {
        RemoteConfigValues.standard.$fetchComplete
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] _ in
                self?.verificationToContinue()
            }).store(in: &cancellables)
        Session.shared.$currentTokens
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] _ in
                self?.verificationToContinue()
            }).store(in: &cancellables)
    }

    private func verificationToContinue() {
        if Session.shared.currentTokens == nil || RemoteConfigValues.standard.fetchComplete == false {
            if !navigationController.isLoading() {
                navigationController.setLoading()
            }
        } else {
            navigationController.restoreContent()
            navigateToMainFlow()        }
    }

    private func navigateToMainFlow() {
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
