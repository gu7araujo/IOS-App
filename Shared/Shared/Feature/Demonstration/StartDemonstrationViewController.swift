//
//  StartDemonstrationViewController.swift
//  Shared
//
//  Created by Gustavo Araujo Santos on 05/07/23.
//

import UIKit

protocol StartDemonstrationViewDelegate: AnyObject {
    func navigateToSecondScreen()
}

public class StartDemonstrationViewController: UIViewController {

    weak var delegate: StartDemonstrationViewDelegate?

    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Navigate to Second Screen", for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.setTitleColor(.link, for: .normal)
        return button
    }()

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        buildHierarchy()
        buildConstraints()
    }

    private func buildHierarchy() {
        view.addSubview(button)
    }

    private func buildConstraints() {
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc private func didTapButton() {
        delegate?.navigateToSecondScreen()
    }
}
