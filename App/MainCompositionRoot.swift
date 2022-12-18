//
//  MainCompositionRoot.swift
//  App
//
//  Created by Gustavo Araujo Santos on 18/12/22.
//

import UIKit
import Home
import Menu

final class MainCompositionRoot {

    func buildAppCoordinator(_ navigationController: UINavigationController) -> AppCoordinator {
        let coordinator = AppCoordinator(navigationController)
        return coordinator
    }

    func buildTabCoordinator(_ navigationController: UINavigationController) -> TabCoordinatorProtocol {
        let coordinator = TabCoordinator(navigationController)
        return coordinator
    }

    func buildHomeCoordinator(_ navigationController: UINavigationController) -> HomeCoordinator {
        let coordinator = HomeCoordinator(navigationController)
        return coordinator
    }

    func buildMenuCoordinator(_ navigationController: UINavigationController) -> MenuCoordinator {
        let coordinator = MenuCoordinator(navigationController)
        return coordinator
    }

}
