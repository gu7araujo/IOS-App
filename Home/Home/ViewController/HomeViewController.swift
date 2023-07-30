//
//  HomeViewController.swift
//  Home
//
//  Created by Gustavo Araujo Santos on 13/12/22.
//

import UIKit
import Shared
import DesignSystem

protocol HomeViewDelegate: AnyObject {
    func navigateToDemonstration()
    func addItem()
    func removeItem()
}

class HomeViewController: UIViewController {

    weak var delegate: HomeViewDelegate?

    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .blue
        view.separatorStyle = .none
        view.delegate = self
        view.dataSource = self
        view.register(TableViewCellWithButtons.self, forCellReuseIdentifier: "cellButtons")
        return view
    }()

    init() {
        super.init(nibName: nil, bundle: nil)
        buildTree()
        buildConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func buildTree() {
        view.addSubview(tableView)
    }

    private func buildConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellButtons", for: indexPath) as? TableViewCellWithButtons
        cell?.didSendEventClosure = { [weak self] event in
            switch event {
            case .navigateToDemonstrationFeature:
                self?.delegate?.navigateToDemonstration()
            case .addItem:
                self?.delegate?.addItem()
            case .removeItem:
                self?.delegate?.removeItem()
            }
        }
        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
}

class TableViewCellWithButtons: UITableViewCell {

    enum Event {
        case navigateToDemonstrationFeature
        case addItem
        case removeItem
    }

    public var didSendEventClosure: ((TableViewCellWithButtons.Event) -> Void)?

    // MARK: - UI Elements -

    private lazy var button1: UIButton = {
        let button = UIButton()
        button.setTitle("Navigate to Demonstration Feature", for: .normal)
        button.addTarget(self, action: #selector(button1Pressed), for: .touchUpInside)
        button.titleLabel?.font = Typography.h3Bold.rawValue
        return button
    }()

    private lazy var button2: UIButton = {
        let button = UIButton()
        button.setTitle("Adicionar Item", for: .normal)
        button.addTarget(self, action: #selector(button2Pressed), for: .touchUpInside)
        button.titleLabel?.font = Typography.h3Bold.rawValue
        return button
    }()

    private lazy var button3: UIButton = {
        let button = UIButton()
        button.setTitle("Remover Item", for: .normal)
        button.addTarget(self, action: #selector(button3Pressed), for: .touchUpInside)
        button.titleLabel?.font = Typography.h3Bold.rawValue
        return button
    }()

    // MARK: - Initializer -

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .blue
        buildTree()
        buildConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Codable -

    private func buildTree() {
        contentView.addSubview(button1)
        contentView.addSubview(button2)
        contentView.addSubview(button3)
    }

    private func buildConstraints() {
        button1.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button1.leadingAnchor.constraint(equalTo: leadingAnchor),
            button1.topAnchor.constraint(equalTo: topAnchor),
            button1.trailingAnchor.constraint(equalTo: trailingAnchor),
            button1.heightAnchor.constraint(equalToConstant: 20)
        ])

        button2.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button2.leadingAnchor.constraint(equalTo: leadingAnchor),
            button2.topAnchor.constraint(equalTo: button1.bottomAnchor, constant: 10),
            button2.trailingAnchor.constraint(equalTo: trailingAnchor),
            button2.heightAnchor.constraint(equalToConstant: 20)
        ])

        button3.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button3.leadingAnchor.constraint(equalTo: leadingAnchor),
            button3.topAnchor.constraint(equalTo: button2.bottomAnchor, constant: 10),
            button3.trailingAnchor.constraint(equalTo: trailingAnchor),
            button3.heightAnchor.constraint(equalToConstant: 20)
        ])
    }

    // MARK: - Private Methods -

    @objc private func button1Pressed() {
        didSendEventClosure?(.navigateToDemonstrationFeature)
    }

    @objc private func button2Pressed() {
        didSendEventClosure?(.addItem)
    }

    @objc private func button3Pressed() {
        didSendEventClosure?(.removeItem)
    }
}
