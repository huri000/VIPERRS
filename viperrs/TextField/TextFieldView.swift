//
//  TextFieldView.swift
//  viperrs
//
//  Created by Daniel on 24/11/2019.
//  Copyright © 2019 Daniel Huri. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay
import RxCocoa

final class TextFieldView: UIView {
    
    /// Property injection allows us to reeuse this component
    /// in a table-views and collection-views
    var presenter: TextFieldPresenter! {
        didSet {
            disposeBag = DisposeBag()
            guard let presenter = presenter else { return }
            
            textField.placeholder = presenter.content.placeholder
            
            /// Bind The text in the text-field to the presenter's `textRelay`
            textField.rx.text
                .orEmpty
                .bind(to: presenter.textRelay)
                .disposed(by: disposeBag)
            
            /// Bind presenter's hint to the `hintLabel`
            presenter.hint
                .drive(hintLabel.rx.text)
                .disposed(by: disposeBag)
            
            /// Bind presenter's tint to the `hintLabel`
            presenter.tint
                .drive(textField.rx.textColor)
                .disposed(by: disposeBag)
            
            /// Bind presenter's tint to the `hintLabel`
            presenter.tint
                .drive(hintLabel.rx.textColor)
                .disposed(by: disposeBag)
        }
    }
    
    @IBOutlet private var textField: UITextField!
    @IBOutlet private var hintLabel: UILabel!
    @IBOutlet private var separatorView: UIView!

    private var disposeBag: DisposeBag!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        fromNib()
    }
}
