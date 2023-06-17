//
//  NSTextField+.swift
//  CombTest
//
//  Created by Florian Zand on 27.05.22.
//

#if os(macOS)
import AppKit
import Combine

public extension CombineExtension where Base: NSTextField {
    func textDidChangePublisher() -> AnyPublisher<String, Never>  {
        NotificationCenter.default
            .publisher(for: NSTextField.textDidChangeNotification, object: base)
            .map( { ($0.object as! NSTextField).stringValue } ).eraseToAnyPublisher()
    }
    
    func textDidEndEditingPublisher() -> AnyPublisher<String, Never>  {
        NotificationCenter.default
            .publisher(for: NSTextField.textDidEndEditingNotification, object: base)
            .map( { ($0.object as! NSTextField).stringValue } ).eraseToAnyPublisher()
    }
    
    func textDidBeginEditingPublisher() -> AnyPublisher<String, Never>  {
        NotificationCenter.default
            .publisher(for: NSTextField.textDidBeginEditingNotification, object: base)
            .map( { ($0.object as! NSTextField).stringValue } ).eraseToAnyPublisher()
    }
    
    var stringValue: BindingSink<Base, String> {
        BindingSink(owner: base) { $0.stringValue = $1 }
    }
    
    var placeholderString: BindingSink<Base, String?> {
        BindingSink(owner: base) { $0.placeholderString = $1 }
    }
    
    var alignment: BindingSink<Base, NSTextAlignment> {
        BindingSink(owner: base) { $0.alignment = $1 }
    }
    
    var lineBreakMode: BindingSink<Base, NSLineBreakMode> {
        BindingSink(owner: base) { $0.lineBreakMode = $1 }
    }
    
    var maximumNumberOfLines: BindingSink<Base, Int> {
        BindingSink(owner: base) { $0.maximumNumberOfLines = $1 }
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
    
    /*
    var backgroundColor: BindingSink<Base, NSColor?> {
        BindingSink(owner: base) { $0.backgroundColor = $1 }
    }
     */
    
    var isEditable: BindingSink<Base, Bool> {
        BindingSink(owner: base) { $0.isEditable = $1 }
    }
    
    var isSelectable: BindingSink<Base, Bool> {
        BindingSink(owner: base) { $0.isSelectable = $1 }
    }
    
}

#endif
