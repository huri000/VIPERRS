//
//  TextFieldTableViewCell.swift
//  viperrs
//
//  Created by Daniel on 01/12/2019.
//  Copyright © 2019 Daniel Huri. All rights reserved.
//

import UIKit
import RxSwift

final class TextFieldTableViewCell: UITableViewCell {

    var refresh: (() -> Void)!
    var presenter: TextFieldPresenter! {
        didSet {
            textFieldView.presenter = presenter
            disposeBag = DisposeBag()
            presenter.containsHint
                .distinctUntilChanged()
                .asObservable()
                .bind { [weak self] _ in
                    self?.refresh()
                }
                .disposed(by: disposeBag)
        }
    }
        
    private lazy var textFieldView = TextFieldView()
    
    private var disposeBag = DisposeBag()
    
    // MARK: - Lifeycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(textFieldView)
        textFieldView.fillHorizontally(offset: 24)
        textFieldView.fillVertically()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        textFieldView.presenter = nil
    }
}
