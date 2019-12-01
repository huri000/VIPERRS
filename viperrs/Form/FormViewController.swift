//
//  FormViewController.swift
//  viperrs
//
//  Created by Daniel on 24/11/2019.
//  Copyright © 2019 Daniel Huri. All rights reserved.
//

import UIKit

final class FormViewController: UIViewController {
        
    // MARK: - Properties
    
    @IBOutlet private var tableView: UITableView!
    
    // Lazily initialze subviews
    private lazy var buttonView = ButtonView(presenter: presenter.buttonPresenter)
    
    /// Keep presenter as property
    private let presenter: FormPresenter
    
    // MARK: - Setup
    
    /// Inject the presenter as dependency
    init(presenter: FormPresenter) {
        self.presenter = presenter
        super.init(nibName: String(describing: FormViewController.self), bundle: nil)
    }
    
    // Just be silent already! ^^
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = presenter.screenTitle
        setupTableView()
        setupButton()
    }
    
    private func setupButton() {
        view.addSubview(buttonView)
        buttonView.fillHorizontally(offset: 24)
        NSLayoutConstraint.activate([
            buttonView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            buttonView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupTableView() {
        tableView.allowsSelection = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.register(
            TextFieldTableViewCell.self,
            forCellReuseIdentifier: String(describing: TextFieldTableViewCell.self)
        )
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension FormViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return presenter.textFieldPresenters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: TextFieldTableViewCell.self),
            for: indexPath
        ) as! TextFieldTableViewCell
        cell.refresh = { [weak tableView] in
            tableView?.beginUpdates()
            tableView?.endUpdates()
        }
        cell.presenter = presenter.textFieldPresenters[indexPath.row]
        return cell
    }
}
