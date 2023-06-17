//
//  NSSwitch+.swift
//  CombTest
//
//  Created by Florian Zand on 27.05.22.
//

#if os(macOS)
import AppKit
import Combine

public extension CombineExtension where Base: NSSwitch {
    
    func statePublisher() -> AnyPublisher<NSControl.StateValue, Never> {
        return self.publisher(for: NSEvent.EventType.leftMouseUp)
            .map({base.state})
            .removeDuplicates()
            .eraseToAnyPublisher()
    }
}


#endif
