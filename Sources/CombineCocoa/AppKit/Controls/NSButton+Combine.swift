//
//  NSButton+Combine.swift
//  FZCollection
//
//  Created by Florian Zand on 27.05.22.
//

#if os(macOS)
import AppKit
import Combine

public extension CombineExtension where Base: NSButton {
    func statePublisher() -> AnyPublisher<NSControl.StateValue, Never> {
        return self.publisher(for: NSEvent.EventType.leftMouseUp)
            .map({base.state})
            .removeDuplicates()
            .eraseToAnyPublisher()
    }
    
    var title: BindingSink<Base, String> {
        BindingSink(owner: base) { $0.title = $1 }
    }
    
    var image: BindingSink<Base, NSImage?> {
        BindingSink(owner: base) { $0.image = $1 }
    }
    
    var alternateImage: BindingSink<Base, NSImage?> {
        BindingSink(owner: base) { $0.alternateImage = $1 }
    }
    
    var imageScaling: BindingSink<Base, NSImageScaling> {
        BindingSink(owner: base) { $0.imageScaling = $1 }
    }
    
    var imagePosition: BindingSink<Base, NSButton.ImagePosition> {
        BindingSink(owner: base) { $0.imagePosition = $1 }
    }
    
    var isEnabled: BindingSink<Base, Bool> {
        BindingSink(owner: base) { $0.isEnabled = $1 }
    }
    
    var isBordered: BindingSink<Base, Bool> {
        BindingSink(owner: base) { $0.isBordered = $1 }
    }
    
    var state: BindingSink<Base, NSControl.StateValue> {
        BindingSink(owner: base) { $0.state = $1 }
    }
    
    var allowsMixedState: BindingSink<Base, Bool> {
        BindingSink(owner: base) { $0.allowsMixedState = $1 }
    }
    
    var keyEquivalent: BindingSink<Base, String> {
        BindingSink(owner: base) { $0.keyEquivalent = $1 }
    }
    
    var keyEquivalentModifierMask: BindingSink<Base, NSEvent.ModifierFlags> {
        BindingSink(owner: base) { $0.keyEquivalentModifierMask = $1 }
    }
    
    var isTransparent: BindingSink<Base, Bool> {
        BindingSink(owner: base) { $0.isTransparent = $1 }
    }
    
    var bezelStyle: BindingSink<Base, Base.BezelStyle> {
        BindingSink(owner: base) { $0.bezelStyle = $1}
    }
    
    var bezelColor: BindingSink<Base, NSColor?> {
        BindingSink(owner: base) { $0.bezelColor = $1}
    }
    
    var buttonType: BindingSink<Base, Base.ButtonType> {
        BindingSink(owner: base) { $0.setButtonType($1)}
    }
    
    var contentTintColor: BindingSink<Base, NSColor?> {
        BindingSink(owner: base) { $0.contentTintColor = $1 }
    }
    
    var sound: BindingSink<Base, NSSound?> {
        BindingSink(owner: base) { $0.sound = $1 }
    }
}



#endif
