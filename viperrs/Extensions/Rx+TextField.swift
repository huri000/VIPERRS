//
//  Rx+TextField.swift
//  viperrs
//
//  Created by Daniel on 01/12/2019.
//  Copyright © 2019 Daniel Huri. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UITextField {
    /// Bindable sink for `textColor` property.
    var textColor: Binder<Color> {
        return Binder(self.base) { textField, color in
            textField.textColor = color
        }
    }
}
