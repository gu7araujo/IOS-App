//
//  MenuCoordinator.swift
//  Menu
//
//  Created by Gustavo Araujo Santos on 13/12/22.
//

import UIKit
import Shared
import SwiftUI

public class MenuCoordinator: CoordinatorProtocol {

    weak public var finishDelegate: CoordinatorFinishDelegate?
    public var navigationController: UINavigationController
    public var childCoordinators: [CoordinatorProtocol] = []
    public var type: CoordinatorType = .menu

    public required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    deinit {
        print("\(MenuCoordinator.self) deinit")
    }

    public func start() {
        let childView = UIHostingController(rootView: MenuCompositionRoot().buildMenuView())        
        navigationController.pushViewController(childView, animated: true)
    }

}
