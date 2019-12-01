//
//  InputValidationService.swift
//  viperrs
//
//  Created by Daniel on 24/11/2019.
//  Copyright © 2019 Daniel Huri. All rights reserved.
//

import Foundation
import RxSwift

protocol InputValidationServiceAPI: class {
    func validate(input: String) -> Single<Bool>
}

protocol RegexValidationServiceAPI: InputValidationServiceAPI {
    var regex: String { get }
}

extension RegexValidationServiceAPI {
    func validate(input: String) -> Single<Bool> {
        let regex = self.regex
        return Single
            .create { observer -> Disposable in
                let isMatch = input.range(of: regex, options: .regularExpression) != nil
                observer(.success(isMatch))
                return Disposables.create()
            }
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .userInitiated))
    }
}

final class NameValidationService: RegexValidationServiceAPI {
    let regex = "^[a-zA-Z]{2,36}$"
}

final class PhoneValidationService: RegexValidationServiceAPI {
    let regex = "^(((\\+44\\s?\\d{4}|\\(?0\\d{4}\\)?)\\s?\\d{3}\\s?\\d{3})|((\\+44\\s?\\d{3}|\\(?0\\d{3}\\)?)\\s?\\d{3}\\s?\\d{4})|((\\+44\\s?\\d{2}|\\(?0\\d{2}\\)?)\\s?\\d{4}\\s?\\d{4}))(\\s?\\#(\\d{4}|\\d{3}))?$"
}

final class EmailValidationService: RegexValidationServiceAPI {
    let regex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
}
