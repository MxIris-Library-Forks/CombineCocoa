//
//  NSTextView+.swift
//  CombTest
//
//  Created by Florian Zand on 27.05.22.
//

#if os(macOS)
import AppKit
import Combine

public extension CombineExtension where Base: NSTextView {
    func textChangedPublisher() -> AnyPublisher<String, Never>  {
        NotificationCenter.default
            .publisher(for: NSText.didChangeNotification, object: base)
            .map( { ($0.object as! NSTextView).string } ).eraseToAnyPublisher()
    }
    
    func didBeginEditingPublisher() -> AnyPublisher<String, Never>  {
        NotificationCenter.default
            .publisher(for: NSText.didBeginEditingNotification, object: base)
            .map( { ($0.object as! NSTextView).string } ).eraseToAnyPublisher()
    }
    
    func didEndEditingPublisher() -> AnyPublisher<String, Never>  {
        NotificationCenter.default
            .publisher(for: NSText.didEndEditingNotification, object: base)
            .map( { ($0.object as! NSTextView).string } ).eraseToAnyPublisher()
    }
    
    var string: BindingSink<Base, String> {
        BindingSink(owner: base) { $0.string = $1 }
    }
    
    var font: BindingSink<Base, NSFont?> {
        BindingSink(owner: base) { $0.font = $1 }
    }
    
    var textColor: BindingSink<Base, NSColor?> {
        BindingSink(owner: base) { $0.textColor = $1 }
    }
    
    var drawsBackground: BindingSink<Base, Bool> {
        BindingSink(owner: base) { $0.drawsBackground = $1 }
    }
    
    var backgroundColor: BindingSink<Base, NSColor> {
        BindingSink(owner: base) { $0.backgroundColor = $1 }
    }
    
    var isSelectable: BindingSink<Base, Bool> {
        BindingSink(owner: base) { $0.isSelectable = $1 }
    }
    
    var isEditable: BindingSink<Base, Bool> {
        BindingSink(owner: base) { $0.isEditable = $1 }
    }
    
    var alignment: BindingSink<Base, NSTextAlignment> {
        BindingSink(owner: base) { $0.alignment = $1 }
    }
    
}

#endif
