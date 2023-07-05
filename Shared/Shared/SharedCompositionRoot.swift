//
//  SharedCompositionRoot.swift
//  Shared
//
//  Created by Gustavo Araujo Santos on 05/07/23.
//

import UIKit

public class SharedCompositionRoot {

    public init() { }

    public func buildDemonstrationCoordinator(_ navigationController: UINavigationController) -> DemonstrationCoordinator {
        let coordinator = DemonstrationCoordinator(navigationController)
        return coordinator
    }

    func buildStartDemonstrationViewController() -> StartDemonstrationViewController {
        let view = StartDemonstrationViewController()
        return view
    }

    func buildSecondDemonstrationViewController() -> SecondDemonstrationViewController {
        let view = SecondDemonstrationViewController()
        return view
    }

}
