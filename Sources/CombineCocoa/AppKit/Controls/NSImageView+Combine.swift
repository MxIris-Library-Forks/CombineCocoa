//
//  NSImageView+.swift
//  CombTest
//
//  Created by Florian Zand on 27.05.22.
//

#if os(macOS)
import AppKit
import Combine

public extension CombineExtension where Base: NSImageView {
    var image: BindingSink<Base, NSImage?> {
        BindingSink(owner: base) { $0.image = $1 }
    }
    
    var imageScaling: BindingSink<Base, NSImageScaling> {
        BindingSink(owner: base) { $0.imageScaling = $1 }
    }
    
    var imageAlignment: BindingSink<Base, NSImageAlignment> {
        BindingSink(owner: base) { $0.imageAlignment = $1 }
    }
    
    var animates: BindingSink<Base, Bool> {
        BindingSink(owner: base) { $0.animates = $1 }
    }
    
    var isEditable: BindingSink<Base, Bool> {
        BindingSink(owner: base) { $0.isEditable = $1 }
    }
    
    var allowsCutCopyPaste: BindingSink<Base, Bool> {
        BindingSink(owner: base) { $0.allowsCutCopyPaste = $1 }
    }
    
    var contentTintColor: BindingSink<Base, NSColor?> {
        BindingSink(owner: base) { $0.contentTintColor = $1 }
    }
    
    @available(OSX 11.10, *)
    var symbolConfiguration: BindingSink<Base, NSImage.SymbolConfiguration?> {
        BindingSink(owner: base) { $0.symbolConfiguration = $1 }
    }
}

#endif
