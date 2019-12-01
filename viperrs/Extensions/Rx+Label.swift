//
//  Rx+Label.swift
//  viperrs
//
//  Created by Daniel on 01/12/2019.
//  Copyright © 2019 Daniel Huri. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UILabel {
    /// Bindable sink for `textColor` property.
    var textColor: Binder<Color> {
        return Binder(self.base) { label, color in
            label.textColor = color
        }
    }
}
