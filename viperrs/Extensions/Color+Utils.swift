//
//  Color+Utils.swift
//  viperrs
//
//  Created by Daniel on 30/11/2019.
//  Copyright © 2019 Daniel Huri. All rights reserved.
//

import Foundation

#if os(OSX)
import AppKit
typealias Color = NSColor
typealias Font = NSFont
#else
import UIKit
typealias Color = UIColor
typealias Font = UIFont
#endif
