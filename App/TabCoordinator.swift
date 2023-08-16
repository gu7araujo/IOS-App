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
import Profile
import Combine

protocol TabCoordinatorProtocol: CoordinatorProtocol {
    var tabBarController: UITabBarController { get set }
    var badgeValue: Int { get set }

    func selectPage(_ page: TabBarPage)
    func setSelectedIndex(_ index: Int)
    func currentPage() -> TabBarPage?
}

enum TabBarPage {
    case home
    case menu
    case profile

    init?(index: Int) {
        switch index {
        case 0:
            self = .home
        case 1:
            self = .menu
        case 2:
            self = .profile
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
        case .profile:
            return "Profile"
        }
    }

    func pageOrderNumber() -> Int {
        switch self {
        case .home:
            return 0
        case .menu:
            return 1
        case .profile:
            return 2
        }
    }

    func pageIcon() -> UIImage? {
        switch self {
        case .home:
            return UIImage(named: "home")
        case .menu:
            return UIImage(named: "menu")
        case .profile:
            return UIImage(named: "profile")
        }
    }

    func pageSelectedIcon() -> UIImage? {
        switch self {
        case .home:
            return UIImage(named: "homeSelected")
        case .menu:
            return UIImage(named: "menuSelected")
        case .profile:
            return UIImage(named: "profileSelected")
        }
    }
}

class TabCoordinator: NSObject, TabCoordinatorProtocol {

    var tabBarController: UITabBarController
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [CoordinatorProtocol] = []
    var type: CoordinatorType = .tab

    var badgeValue = 0

    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.tabBarController = UITabBarController()
    }

    deinit {
        print("\(TabCoordinator.self) deinit")
    }

    func start() {
        let pages: [TabBarPage] = [.home, .menu, .profile]
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
        tabBarController.tabBar.items?[0].badgeValue = "\(badgeValue)"
        navigationController.viewControllers = [tabBarController]
    }

    private func getTabController(_ page: TabBarPage) -> UINavigationController {
        let navController = UINavigationController()
        navController.setNavigationBarHidden(true, animated: false)

        navController.tabBarItem = UITabBarItem(title: page.pageTitleValue(),
                                                image: page.pageIcon(),
                                                selectedImage: page.pageSelectedIcon())
        navController.tabBarItem.tag = page.pageOrderNumber()

        switch page {
        case .home:
            let coordinator = MainCompositionRoot().buildHomeCoordinator(navController)
            coordinator.delegate = self
            childCoordinators.append(coordinator)
            coordinator.start()
        case .menu:
            let coordinator = MainCompositionRoot().buildMenuCoordinator(navController)
            childCoordinators.append(coordinator)
            coordinator.start()
        case .profile:
            let coordinator = MainCompositionRoot().buildProfileCoordinator(navController)
            childCoordinators.append(coordinator)
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

extension TabCoordinator: HomeCoordinatorDelegate {
    func increaseBadge() {
        badgeValue += 1
        tabBarController.tabBar.items?[0].badgeValue = "\(badgeValue)"
    }

    func decreaseBadge() {
        if badgeValue == 0 { return }
        badgeValue -= 1
        tabBarController.tabBar.items?[0].badgeValue = "\(badgeValue)"
    }
}
