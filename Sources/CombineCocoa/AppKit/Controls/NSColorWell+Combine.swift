//
//  NSColorWell.swift
//  FZCollection
//
//  Created by Florian Zand on 27.05.22.
//

#if os(macOS)
import AppKit
import Combine

public extension CombineExtension where Base: NSColorWell {
    func colorPublisher() -> AnyPublisher<NSColor, Never> {
        return self.publisher(for: NSEvent.EventType.userInteractions)
            .map({base.color})
            .removeDuplicates()
            .eraseToAnyPublisher()
   }
    
    var isBordered: BindingSink<Base, Bool> {
           BindingSink(owner: base) { $0.isBordered = $1 }
       }
    
}

#endif
