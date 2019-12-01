//
//  ButtonPresenter.swift
//  viperrs
//
//  Created by Daniel on 24/11/2019.
//  Copyright © 2019 Daniel Huri. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol ButtonPresenterAPI: class {
    var isEnabled: Driver<Bool> { get }
}

final class ButtonPresenter: ButtonPresenterAPI {
    
    let isEnabledRelay = BehaviorRelay(value: false)
    var isEnabled: Driver<Bool> {
        return isEnabledRelay
            .asDriver()
            .do(onNext: { isEnabled in
                print("isEnabled: \(isEnabled)")
            })
    }
}
