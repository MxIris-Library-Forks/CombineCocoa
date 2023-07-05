//
//  NSPopUpGutton+.swift
//  CombTest
//
//  Created by Florian Zand on 27.05.22.
//

#if os(macOS)
import AppKit
import Combine
// import FZExtensions

public extension CombineExtension where Base: NSPopUpButton {
    func selectedIndexPublisher() -> AnyPublisher<Int, Never> {
        return  NotificationCenter.default
            .publisher(for: NSMenu.didSendActionNotification, object: base.menu)
            .map { _ in base.indexOfSelectedItem }
            .removeDuplicates()
            .eraseToAnyPublisher()
    }
    
    var pullsDown: BindingSink<Base, Bool> {
        BindingSink(owner: base) { $0.pullsDown = $1 }
    }
    
    var items: BindingSink<Base, [NSMenuItem]> {
        BindingSink(owner: base) { $0.items = $1 }
    }
}

internal extension NSPopUpButton {
    var items: [NSMenuItem] {
        get {
            return menu?.items ?? []
        }
        set {
            if let menu = menu {
                let selectedItemTitle = titleOfSelectedItem
                menu.items = newValue
                if let selectedItemTitle = selectedItemTitle, let item = newValue.first(where: { $0.title == selectedItemTitle }) {
                    select(item)
                }
            } else {
                menu = NSMenu(items: newValue)
            }
        }
    }
}

internal extension NSMenu {
    /**
     Initializes and returns a menu having the specified menu items.
     - Parameters items: The menu items for the menu.
     - Returns: The initialized `NSMenu` object.
     */
    convenience init(items: [NSMenuItem]) {
        self.init(title: "", items: items)
    }
    
    /**
     Initializes and returns a menu having the specified title and menu items.
     - Parameters items: The menu items for the menu.
     - Parameters title: The title to assign to the menu.
     - Returns: The initialized `NSMenu` object.
     */
    convenience init(title: String, items: [NSMenuItem]) {
        self.init(title: title)
        self.items = items
    }
}

#endif
