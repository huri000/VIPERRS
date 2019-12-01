//
//  Router.swift
//  viperrs
//
//  Created by Daniel on 24/11/2019.
//  Copyright © 2019 Daniel Huri. All rights reserved.
//

import Foundation
import UIKit

protocol RouterAPI: class {
    func next()
    func previous()
}

final class Router: RouterAPI {
    
    enum State {
        case inactive
        case form
        
        mutating func increment() {
            switch self {
            case .inactive:
                self = .form
            case .form: // Do nothing - last screen
                self = .form
            }
        }
    }
    
    private var state = State.inactive
    private let navigator: NavigatorAPI
    
    init(navigator: NavigatorAPI) {
        self.navigator = navigator
    }
    
    // MARK: - RouterAPI
    
    func next() {
        state.increment()
        guard let viewController = self.viewController(by: state) else {
            return
        }
        navigator.next(to: viewController)
    }
    
    func previous() {
        /// Navigate backward
    }
    
    private func viewController(by state: State) -> UIViewController? {
        switch state {
        case .form:
            let presenter = FormPresenter(router: self)
            return FormViewController(presenter: presenter)
        case .inactive:
            return nil
        }
    }
}

