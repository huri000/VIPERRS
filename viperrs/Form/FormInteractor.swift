//
//  ScreenInteractor.swift
//  viperrs
//
//  Created by Daniel on 24/11/2019.
//  Copyright © 2019 Daniel Huri. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

// 1. Define a state type
enum FormState {
    case valid
    case invalid
    
    var isValid: Bool {
        switch self {
        case .valid:
            return true
        case .invalid:
            return false
        }
    }
}

final class FormInteractor {
            
    // 2. Define a state
    var state: Observable<FormState> {
        return reducer.state
    }
    
    // 3. Declare reducer property
    private let reducer: Reducer
    
    /// Keep a service as dependency
    private let loginService: ServiceAPI
    
    let emailTextFieldInteractor: TextFieldInteractor
    let firstNameTextFieldInteractor: TextFieldInteractor
    let lastNameTextFieldInteractor: TextFieldInteractor
    let phoneTextFieldInteractor: TextFieldInteractor

    init(dependencies: Dependencies = Dependencies()) {
        self.loginService = dependencies.loginService
        emailTextFieldInteractor = TextFieldInteractor(
            validationService: dependencies.emailValidationService
        )
        firstNameTextFieldInteractor = TextFieldInteractor(
            validationService: dependencies.nameValidationService
        )
        lastNameTextFieldInteractor = TextFieldInteractor(
            validationService: dependencies.nameValidationService
        )
        phoneTextFieldInteractor = TextFieldInteractor(
            validationService: dependencies.phoneValidationService
        )
        
        reducer = Reducer(
            states: emailTextFieldInteractor.state,
                    firstNameTextFieldInteractor.state,
                    lastNameTextFieldInteractor.state,
                    phoneTextFieldInteractor.state
        )
    }
}

extension FormInteractor {
    
    /// Form dependeencies container
    struct Dependencies {
        let loginService: ServiceAPI
        let nameValidationService: InputValidationServiceAPI
        let emailValidationService: InputValidationServiceAPI
        let phoneValidationService: InputValidationServiceAPI
        
        /// A designated initializer that defaults services
        init(loginService: ServiceAPI = Service(),
             nameValidationService: InputValidationServiceAPI = NameValidationService(),
             emailValidationService: InputValidationServiceAPI = EmailValidationService(),
             phoneValidationService: InputValidationServiceAPI = PhoneValidationService()) {
            self.loginService = loginService
            self.nameValidationService = nameValidationService
            self.emailValidationService = emailValidationService
            self.phoneValidationService = phoneValidationService
        }
    }
}

extension FormInteractor {

    final class Reducer {
    
        var state: Observable<FormState> {
            return stateRelay.asObservable()
        }
        
        private let stateRelay = BehaviorRelay(value: FormState.invalid)
        
        private let disposeBag = DisposeBag()
        
        convenience init(states: Observable<TextFieldInteractor.State>...) {
            self.init(states: states)
        }
        
        init(states: [Observable<TextFieldInteractor.State>]) {
            Observable
                .combineLatest(states)
                .map(reduce)
                .bind(to: stateRelay)
                .disposed(by: disposeBag)
        }
        
        private func reduce(states: [TextFieldInteractor.State]) -> FormState {
            return states.contains(where: { !$0.isValid }) ? .invalid : .valid
        }
    }
}
