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

#endif
