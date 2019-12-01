//
//  Navigator.swift
//  viperrs
//
//  Created by Daniel on 24/11/2019.
//  Copyright © 2019 Daniel Huri. All rights reserved.
//

import UIKit

// An object that has control over the navigation stack
final class Navigator: NavigatorAPI {
    
    private lazy var navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.setNavigationBarHidden(false, animated: false)
        return navigationController
    }()
    
    private unowned let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func replaceRoot() {
        window.rootViewController = navigationController
    }
    
    func mountAsModal() {
        window.rootViewController!.present(
            navigationController,
            animated: true,
            completion: nil
        )
    }
    
    func next(to viewController: UIViewController) {
        if window.rootViewController == nil {
            window.rootViewController = navigationController
        }
        if navigationController.viewControllers.isEmpty {
            navigationController.viewControllers = [viewController]
        } else {
            navigationController.pushViewController(
                viewController,
                animated: true
            )
        }
    }
    
    func previous() {
        navigationController.popViewController(animated: true)
    }
}

protocol NavigatorAPI: class {
    func replaceRoot()
    func mountAsModal()
    func next(to viewController: UIViewController)
    func previous()
}
