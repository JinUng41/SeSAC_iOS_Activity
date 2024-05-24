//
//  Then.swift
//  UserNotificationsPractice
//

import Foundation

protocol Then { }

extension Then where Self: AnyObject {
    func then(_ action: (Self) -> Void) -> Self {
        action(self)
        return self
    }
}

extension DateComponents: Then {
    func then(_ action: (inout Self) -> Void) -> Self {
        var copy = self
        action(&copy)
        return copy
    }
}

extension NSObject: Then { }
