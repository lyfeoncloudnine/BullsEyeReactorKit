//
//  ReuseableType.swift
//  BullsEye
//
//  Created by lyfeoncloudnine on 2023/05/02.
//

import Foundation

protocol ReusableType {
    static var reuseIdentifier: String { get }
}

extension ReusableType {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}
