//
//  HomeViewController.swift
//  Home
//
//  Created by Gustavo Araujo Santos on 13/12/22.
//

import UIKit
import Shared

class HomeViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .blue
        view.separatorStyle = .none
        view.delegate = self
        view.dataSource = self
        view.register(TableViewCellWithCollectionView.self, forCellReuseIdentifier: "cell")
        view.register(TableViewCellWithStackView.self, forCellReuseIdentifier: "cellStack")
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

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell?
        if indexPath.row == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCellWithCollectionView
        } else if indexPath.row == 1 {
            cell = tableView.dequeueReusableCell(withIdentifier: "cellStack", for: indexPath) as? TableViewCellWithStackView
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "cellButtons", for: indexPath) as? TableViewCellWithButtons
            cell?.selectionStyle = .none
        }

        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 100
        } else if indexPath.row == 1 {
            return 200
        } else {
            return 80
        }
    }
}

class TableViewCellWithCollectionView: UITableViewCell {

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = .blue
        view.showsHorizontalScrollIndicator = false
        view.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildTree()
        buildConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func buildTree() {
        contentView.addSubview(collectionView)
    }

    private func buildConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}

extension TableViewCellWithCollectionView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath)
        cell.backgroundColor = .red
        cell.layer.cornerRadius = 40
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 80)
    }
}

class TableViewCellWithStackView: UITableViewCell {

    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.backgroundColor  = .blue
        view.axis = .horizontal
        view.distribution = .equalSpacing
        view.alignment = .center
        return view
    }()

    private lazy var image1: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .red
        view.heightAnchor.constraint(equalToConstant: 120).isActive = true
        view.widthAnchor.constraint(equalToConstant: 120).isActive = true
        return view
    }()

    private lazy var image2: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .white
        view.heightAnchor.constraint(equalToConstant: 160).isActive = true
        view.widthAnchor.constraint(equalToConstant: 120).isActive = true
        return view
    }()

    private lazy var image3: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .purple
        view.heightAnchor.constraint(equalToConstant: 100).isActive = true
        view.widthAnchor.constraint(equalToConstant: 100).isActive = true
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildTree()
        buildConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func buildTree() {
        addSubview(stackView)
        stackView.addArrangedSubview(image1)
        stackView.addArrangedSubview(image2)
        stackView.addArrangedSubview(image3)
    }

    private func buildConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

}

class TableViewCellWithButtons: UITableViewCell {

    private lazy var button1: UIButton = {
        let button = UIButton()
        button.setTitle(RemoteConfigValues.standard.string(forKey: .homeScreenButton1Text), for: .normal)
        button.addTarget(self, action: #selector(pressed), for: .touchUpInside)
        return button
    }()

    private lazy var button2: UIButton = {
        let button = UIButton()
        button.setTitle(RemoteConfigValues.standard.string(forKey: .homeScreenButton2Text), for: .normal)
        button.addTarget(self, action: #selector(pressed), for: .touchUpInside)
        return button
    }()

    private lazy var button3: UIButton = {
        let button = UIButton()
        button.setTitle(RemoteConfigValues.standard.string(forKey: .homeScreenButton3Text), for: .normal)
        button.addTarget(self, action: #selector(pressed), for: .touchUpInside)
        return button
    }()

    @objc private func pressed() {
        debugPrint("Button tapped")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .blue
        buildTree()
        buildConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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

}
