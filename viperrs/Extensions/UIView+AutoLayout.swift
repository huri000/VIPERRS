//
//  UIView+AutoLayout.swift
//  viperrs
//
//  Created by Daniel on 01/12/2019.
//  Copyright © 2019 Daniel Huri. All rights reserved.
//

import UIKit

extension UIView {
    func fillSuperview() {
        guard let superview = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            superview.leadingAnchor.constraint(equalTo: leadingAnchor),
            superview.trailingAnchor.constraint(equalTo: trailingAnchor),
            superview.topAnchor.constraint(equalTo: topAnchor),
            superview.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func fillHorizontally(offset: CGFloat = 0) {
        guard let superview = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: offset),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -offset),
        ])
    }
    
    func fillVertically(offset: CGFloat = 0) {
        guard let superview = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor, constant: offset),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -offset),
        ])
    }
}
