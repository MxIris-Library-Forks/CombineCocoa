//
//  NSStepper+Combine.swift
//  FZCollection
//
//  Created by Florian Zand on 27.05.22.
//

#if os(macOS)
import AppKit
import Combine

public extension CombineExtension where Base: NSStepper {
    func valuePublisher() -> AnyPublisher<Double, Never> {
        return self.publisher(for: NSEvent.EventType.leftMouseUp)
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
    
    var increment: BindingSink<Base, Double> {
        BindingSink(owner: base) { $0.increment = $1 }
    }
    
    var autorepeat: BindingSink<Base, Bool> {
           BindingSink(owner: base) { $0.autorepeat = $1 }
       }
    
    var valueWraps: BindingSink<Base, Bool> {
           BindingSink(owner: base) { $0.valueWraps = $1 }
       }
}

#endif
