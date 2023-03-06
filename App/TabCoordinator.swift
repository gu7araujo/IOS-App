//
//  TabCoordinator.swift
//  App
//
//  Created by Gustavo Araujo Santos on 13/12/22.
//

import UIKit
import Shared
import Home
import Menu

enum TabBarPage {
    case home
    case menu

    init?(index: Int) {
        switch index {
        case 0:
            self = .home
        case 1:
            self = .menu
        default:
            return nil
        }
    }

    func pageTitleValue() -> String {
        switch self {
        case .home:
            return "Home"
        case .menu:
            return "Menu"
        }
    }

    func pageOrderNumber() -> Int {
        switch self {
        case .home:
            return 0
        case .menu:
            return 1
        }
    }

    // Add tab icon value

    // Add tab icon selected / deselected color

    // etc
}

protocol TabCoordinatorProtocol: CoordinatorProtocol {
    var tabBarController: UITabBarController { get set }

    func selectPage(_ page: TabBarPage)
    func setSelectedIndex(_ index: Int)
    func currentPage() -> TabBarPage?
}

class TabCoordinator: NSObject, TabCoordinatorProtocol {

    var tabBarController: UITabBarController
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [CoordinatorProtocol] = []
    var type: CoordinatorType = .tab

    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.tabBarController = UITabBarController()
    }

    func start() {
        let pages: [TabBarPage] = [.home, .menu]
            .sorted(by: { $0.pageOrderNumber() < $1.pageOrderNumber() })

        let controllers: [UINavigationController] = pages.map({ getTabController($0) })

        prepareTabBarController(withTabControllers: controllers)
    }

    private func prepareTabBarController(withTabControllers tabControllers: [UIViewController]) {
        tabBarController.delegate = self
        tabBarController.setViewControllers(tabControllers, animated: true)
        tabBarController.selectedIndex = TabBarPage.home.pageOrderNumber()
        tabBarController.tabBar.backgroundColor = .lightGray
        tabBarController.tabBar.tintColor = .white
        navigationController.viewControllers = [tabBarController]
    }

    private func getTabController(_ page: TabBarPage) -> UINavigationController {
        let navController = UINavigationController()
        navController.setNavigationBarHidden(true, animated: false)

        navController.tabBarItem = UITabBarItem.init(title: page.pageTitleValue(),
                                                     image: nil,
                                                     tag: page.pageOrderNumber())

        switch page {
        case .home:
            let coordinator = MainCompositionRoot().buildHomeCoordinator(navController)
            coordinator.start()
        case .menu:
            let coordinator = MainCompositionRoot().buildMenuCoordinator(navController)
            coordinator.start()
        }

        return navController
    }

    func selectPage(_ page: TabBarPage) {
        tabBarController.selectedIndex = page.pageOrderNumber()
    }

    func setSelectedIndex(_ index: Int) {
        guard let page = TabBarPage.init(index: index) else { return }
        
        tabBarController.selectedIndex = page.pageOrderNumber()
    }

    func currentPage() -> TabBarPage? { TabBarPage(index: tabBarController.selectedIndex) }
    
}

extension TabCoordinator: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController,
                          didSelect viewController: UIViewController) {
        // Some implementation
    }
}
