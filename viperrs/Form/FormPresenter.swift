//
//  ScreenPresenter.swift
//  viperrs
//
//  Created by Daniel on 24/11/2019.
//  Copyright © 2019 Daniel Huri. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

final class FormPresenter {
    
    let screenTitle = "Example Project"
    let textFieldPresenters: [TextFieldPresenter]
    let buttonPresenter: ButtonPresenter
    
    private let router: RouterAPI
    private let interactor: FormInteractor
    
    private let disposeBag = DisposeBag()
    
    init(router: RouterAPI, interactor: FormInteractor = FormInteractor()) {
        self.router = router
        self.interactor = interactor
                
        textFieldPresenters = [
            TextFieldPresenter(
                interactor: interactor.emailTextFieldInteractor,
                content: .init(
                    placeholder: "Email address",
                    hint: "Email is not valid",
                    style: .init(validColor: .black, invalidColor: .red)
                )
            ),
            TextFieldPresenter(
                interactor: interactor.firstNameTextFieldInteractor,
                content: .init(
                    placeholder: "First name",
                    hint: "Enter a valid first name",
                    style: .init(validColor: .black, invalidColor: .red)
                )
            ),
            TextFieldPresenter(
                interactor: interactor.lastNameTextFieldInteractor,
                content: .init(
                    placeholder: "Last name",
                    hint: "Enter a valid last name",
                    style: .init(validColor: .black, invalidColor: .red)
                )
            ),
            TextFieldPresenter(
                interactor: interactor.phoneTextFieldInteractor,
                content: .init(
                    placeholder: "UK phone number",
                    hint: "Enter a valid phone number",
                    style: .init(validColor: .black, invalidColor: .red)
                )
            )
        ]
        
        buttonPresenter = ButtonPresenter()
        
        interactor.state
            .map { $0.isValid}
            .bind(to: buttonPresenter.isEnabledRelay)
            .disposed(by: disposeBag)
    }
}
