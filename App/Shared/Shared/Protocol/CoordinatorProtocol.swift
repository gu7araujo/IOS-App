//
//  CoordinatorProtocol.swift
//  Shared
//
//  Created by Gustavo Araujo Santos on 13/12/22.
//

import UIKit

public protocol CoordinatorProtocol: AnyObject {
    var finishDelegate: CoordinatorFinishDelegate? { get set }
    var navigationController: UINavigationController { get set }
    var childCoordinators: [CoordinatorProtocol] { get set }
    var type: CoordinatorType { get }

    func start()
    func finish()

    init(_ navigationController: UINavigationController)
}

public extension CoordinatorProtocol {
    func finish() {
        childCoordinators.removeAll()
        finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
}

public protocol CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: CoordinatorProtocol)
}

public enum CoordinatorType {
    case app, tab, home, menu
}
