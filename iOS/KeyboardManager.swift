//
//  KeyboardManager.swift
//  BasicTip
//
//  Created by Matt Gilboy on 11/11/20.
//  Copyright © 2020 Matt Gilboy. All rights reserved.
//

import SwiftUI
import Combine
import Foundation

final class KeyboardManager: ObservableObject {
    public var managedKeyboardIsVisible = false

    init() {
        // Empty
    }

    func addObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(managedKeyboardWillShow(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(managedKeyboardWillHide(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    func removeObserver() {
        NotificationCenter.default.removeObserver(self)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc func managedKeyboardWillShow(notification: Notification) {
        managedKeyboardIsVisible = true
    }

    @objc func managedKeyboardWillHide(notification: Notification) {
        managedKeyboardIsVisible = false
    }
}
