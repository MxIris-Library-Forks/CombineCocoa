//
//  NSSlider+.swift
//  CombTest
//
//  Created by Florian Zand on 27.05.22.
//

#if os(macOS)
import AppKit
import Combine
// import FZExtensions

public extension CombineExtension where Base: NSSlider {
    func valuePublisher() -> AnyPublisher<Double, Never> {
        return self.publisher(for: NSEvent.EventType.userInteractions)
            .map({base.doubleValue})
            .removeDuplicates()
            .eraseToAnyPublisher()
    }
    
    var minValue: BindingSink<Base, Double> {
        BindingSink(owner: base) { $0.minValue = $1 }
    }

    var maxValue: BindingSink<Base, Double> {
        BindingSink(owner: base) { $0.maxValue = $1 }
    }
    
    var doubleValue: BindingSink<Base, Double> {
           BindingSink(owner: base) { $0.doubleValue = $1 }
       }
}

#endif
