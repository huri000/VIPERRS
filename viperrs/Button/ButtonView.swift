//
//  ButtonView.swift
//  viperrs
//
//  Created by Daniel on 24/11/2019.
//  Copyright © 2019 Daniel Huri. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay
import RxCocoa

final class ButtonView: UIView {
    
    @IBOutlet private var button: UIButton!
    
    private let presenter: ButtonPresenterAPI
    
    private let disposeBag = DisposeBag()
    
    init(presenter: ButtonPresenterAPI) {
        self.presenter = presenter
        super.init(frame: .zero)
        fromNib()
        presenter.isEnabled
            .drive(button.rx.isEnabled)
            .disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
