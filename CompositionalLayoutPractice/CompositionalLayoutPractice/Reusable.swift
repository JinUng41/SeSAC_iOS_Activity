//
//  Reusable.swift
//  CompositionalLayoutPractice
//
//  Created by 김진웅 on 12/6/23.
//

import Foundation

protocol Reusable {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
