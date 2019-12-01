//
//  LoginService.swift
//  viperrs
//
//  Created by Daniel on 24/11/2019.
//  Copyright © 2019 Daniel Huri. All rights reserved.
//

import Foundation

protocol ServiceAPI: class {
    func action(completion: @escaping () -> Void)
}

final class Service: ServiceAPI {
    func action(completion: @escaping () -> Void) {
        /// Perform an asynchronuous operation and call `completion`
        completion()
    }
}
