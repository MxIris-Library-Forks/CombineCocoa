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

public extension NSEvent.EventType {
    static let userInteractions: [NSEvent.EventType] = [.leftMouseDragged, .leftMouseDown, .rightMouseDown, .scrollWheel, .magnify, .keyDown]
    static let extendedUserInteractions: [NSEvent.EventType] = [.leftMouseDragged, .leftMouseDown, .rightMouseDown, .rightMouseDragged, .leftMouseUp, .rightMouseUp, .scrollWheel, .magnify]

}

public extension NSEvent.EventTypeMask {
    /**
     A boolean value that indicates whether the specified event intersects with the event type mask.
     
     - Parameters event: The event for checking the intersection.
     - Returns: `true` if the event interesects with the mask, or `false` if not.
     */
    func intersects(_ event: NSEvent?) -> Bool {
        return event?.associatedEventsMask.intersection(self).isEmpty == false
    }
    
    /// All user interaction event types (excluding mouse up events).
    static let userInteractions: NSEvent.EventTypeMask = [.leftMouseDragged, .leftMouseDown, .rightMouseDown, .scrollWheel, .magnify, .keyDown]
    /// All user interaction event types (including mouse up events).
    static let extendedUserInteractions: NSEvent.EventTypeMask = [.leftMouseDragged, .leftMouseDown, .rightMouseDown, .rightMouseDragged, .leftMouseUp, .rightMouseUp, .scrollWheel, .magnify]
    /// All mouse movement event types.
    static let mouseMovements: NSEvent.EventTypeMask = [.mouseEntered, .mouseMoved, .mouseExited]
}

#endif
