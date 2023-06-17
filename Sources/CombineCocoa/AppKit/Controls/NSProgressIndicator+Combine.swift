//
//  NSProgressIndicator+Combine.swift
//  FZCollection
//
//  Created by Florian Zand on 27.05.22.
//

#if os(macOS)
import AppKit
import Combine

public extension CombineExtension where Base: NSProgressIndicator {
    var minValue: BindingSink<Base, Double> {
        BindingSink(owner: base) { $0.minValue = $1 }
    }

    var maxValue: BindingSink<Base, Double> {
        BindingSink(owner: base) { $0.maxValue = $1 }
    }
    
    var doubleValue: BindingSink<Base, Double> {
           BindingSink(owner: base) { $0.doubleValue = $1 }
       }
    
    var style: BindingSink<Base, Base.Style> {
           BindingSink(owner: base) { $0.style = $1 }
    }
    
    var isDisplayedWhenStopped: BindingSink<Base, Bool> {
           BindingSink(owner: base) { $0.isDisplayedWhenStopped = $1 }
    }
    
    var isIndeterminate: BindingSink<Base, Bool> {
           BindingSink(owner: base) { $0.isIndeterminate = $1 }
    }
    
}

#endif
