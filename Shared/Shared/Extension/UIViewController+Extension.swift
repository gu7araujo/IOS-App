//
//  UIViewController+Extension.swift
//  Shared
//
//  Created by Gustavo Araujo Santos on 23/12/22.
//

import UIKit

extension UIViewController {

    public func setLoading() {
        restoreContent()
        let loadingViewController = LoadingViewController()
        loadingViewController.view.frame = view.bounds
        loadingViewController.willMove(toParent: self)
        addChild(loadingViewController)
        view.insertSubview(loadingViewController.view, at: view.subviews.count)
        loadingViewController.didMove(toParent: self)
    }

    public func restoreContent() {
        guard
            let loadingViewController = children.first(where: { $0 is LoadingViewController })
        else { return }
        loadingViewController.willMove(toParent: self)
        loadingViewController.removeFromParent()
        loadingViewController.view.removeFromSuperview()
        loadingViewController.didMove(toParent: self)
    }

    public func simpleAlert(
        title: String,
        message: String,
        buttonText: String? = nil,
        handler: (() -> Void)? = nil
    ) {
        var mainButtonText = buttonText
        if mainButtonText == nil {
            mainButtonText = "ok"
        }
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: mainButtonText, style: .default, handler: { _ in
            handler?()
        }))
        self.present(alert, animated: true)
    }

    public func simpleConfirmation(
        title: String,
        message: String,
        firstButtonText: String? = nil,
        handler: ((Bool) -> Void)? = nil,
        secondButtonText: String? = nil
    ) {
        var firstButtonText = firstButtonText
        if firstButtonText == nil {
            firstButtonText = "ok"
        }
        var secondButtonText = secondButtonText
        if secondButtonText == nil {
            secondButtonText = "cancel"
        }
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: firstButtonText, style: .default, handler: { _ in
            handler?(true)
        }))
        alert.addAction(UIAlertAction(title: secondButtonText, style: .default, handler: { _ in
            handler?(false)
        }))
        self.present(alert, animated: true)
    }

}
