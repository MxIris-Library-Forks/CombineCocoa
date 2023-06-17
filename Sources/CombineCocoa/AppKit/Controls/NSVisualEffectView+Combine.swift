//
//  NSVisualEffectView+Combine.swift
//  FZCollection
//
//  Created by Florian Zand on 27.05.22.
//

#if os(macOS)
import AppKit
import Combine

public extension CombineExtension where Base: NSVisualEffectView {
    var material: BindingSink<Base, Base.Material> {
        BindingSink(owner: base) { $0.material = $1 }
    }
    
    var blendingMode: BindingSink<Base, Base.BlendingMode> {
        BindingSink(owner: base) { $0.blendingMode = $1 }
    }
    
    var isEmphasized: BindingSink<Base, Bool> {
        BindingSink(owner: base) { $0.isEmphasized = $1 }
    }
    
    var state: BindingSink<Base, Base.State> {
        BindingSink(owner: base) { $0.state = $1 }
    }
}

#endif
