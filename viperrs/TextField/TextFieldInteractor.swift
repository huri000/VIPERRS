//
//  TextFieldInteractor.swift
//  viperrs
//
//  Created by Daniel on 24/11/2019.
//  Copyright © 2019 Daniel Huri. All rights reserved.
//

import Foundation
import RxRelay
import RxSwift

final class TextFieldInteractor {
    
    /// The interaction state
    enum State {
        
        /// Possible errors
        enum StateError: Error {
            case empty
            case mismatch
        }
        
        case valid
        case invalid(StateError)
        
        var isValid: Bool {
            switch self {
            case .valid:
                return true
            case .invalid:
                return false
            }
        }
    }

    /// Expose an observable that streams the current state
    var state: Observable<State> {
        return stateRelay.asObservable()
    }
    
    private let stateRelay = BehaviorRelay(value: State.invalid(.empty))
    
    let contentRelay = BehaviorRelay(value: "")
    
    private let validationService: InputValidationServiceAPI
        
    private let disposeBag = DisposeBag()
    
    init(validationService: InputValidationServiceAPI) {
        self.validationService = validationService
        
        /// 1. Stream `next` only once content changes
        let content = contentRelay
            .distinctUntilChanged()
            .map { $0.trimmingCharacters(in: .whitespaces) }
        
        /// 2. Validate the input using a proxy service that can be reused
        let isValid = content
            .flatMapLatest { [unowned self] input -> Observable<Bool> in
                return self.validationService.validate(input: input).asObservable()
            }

        /// 3. `zip` the input and its validation result, map both into `State`
        /// and bind to `stateRelay`.
        Observable
            .zip(content, isValid)
            .map { (input, isValid) -> State in
                guard !input.isEmpty else {
                    return .invalid(.empty)
                }
                return isValid ? .valid : .invalid(.mismatch)
            }
            .bind(to: stateRelay)
            .disposed(by: disposeBag)
    }
}
