//
//  TextFieldPresenter.swift
//  viperrs
//
//  Created by Daniel on 24/11/2019.
//  Copyright © 2019 Daniel Huri. All rights reserved.
//

import RxRelay
import RxSwift
import RxCocoa

final class TextFieldPresenter {
        
    enum State {
            
        /// A valid state
        case valid
        
        /// An optional hint to be display to the user
        case invalid(hint: String?)
        
        var hint: String? {
            switch self {
            case .valid:
                return nil
            case .invalid(hint: let hint):
                return hint
            }
        }
    }
    
    // MARK: - State and Data
    
    /// Expose a driver that streams the current state
    var state: Driver<State> {
        return stateRelay.asDriver()
    }
    
    /// Expose a driver that streams the hint 
    var hint: Driver<String?> {
        return state.map { $0.hint }
    }
    
    var containsHint: Driver<Bool> {
        return state.map { ($0.hint ?? "").isEmpty }
    }
    
    /// Expose a driver that streams the tint
    var tint: Driver<Color> {
        return state
            .map { [weak self] state in
                guard let self = self else { return .clear }
                switch state {
                case .valid:
                    return self.content.style.validColor
                case .invalid:
                    return self.content.style.invalidColor
                }
            }
    }
    
    /// Expose text relay. It passes the text to the interaction layer for validation.
    let textRelay = BehaviorRelay(value: "")
    
    private let stateRelay = BehaviorRelay(value: State.invalid(hint: nil))
    private let disposeBag = DisposeBag()
    
    // MARK: - DIs

    let content: Content
    private let interactor: TextFieldInteractor
    
    init(interactor: TextFieldInteractor, content: Content) {
        self.content = content
        self.interactor = interactor
        textRelay
            .bind(to: interactor.contentRelay)
            .disposed(by: disposeBag)
        
        interactor.state
            .map { state -> State in
                switch state {
                case .invalid(let error):
                    switch error {
                    case .empty:
                        return .invalid(hint: nil)
                    case .mismatch:
                        return .invalid(hint: content.hint)
                    }
                case .valid:
                    return .valid
                }
            }
            .bind(to: stateRelay)
            .disposed(by: disposeBag)
    }
}

extension TextFieldPresenter {
    
    /// A mutable content
    struct Content {
        struct Style {
            let validColor: Color
            let invalidColor: Color
        }
        let placeholder: String
        let hint: String
        let style: Style
    }
}
