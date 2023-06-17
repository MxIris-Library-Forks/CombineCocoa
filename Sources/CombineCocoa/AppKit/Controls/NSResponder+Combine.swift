//
//  NSResponder+Combine.swift
//  FZCollection
//
//  Created by Florian Zand on 27.05.22.
//

#if os(macOS)
import AppKit
import Combine

public extension CombineExtension where Base: NSResponder {
var menu: BindingSink<Base, NSMenu?> {
    BindingSink(owner: base) { $0.menu = $1 }
    }
}

#endif
