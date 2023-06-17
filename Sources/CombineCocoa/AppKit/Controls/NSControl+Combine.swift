//
//  NSControl+.swift
//  CombTest
//
//  Created by Florian Zand on 27.05.22.
//

#if os(macOS)
import AppKit
import Combine

public extension CombineExtension where Base: NSControl {
    func publisher(for event: NSEvent.EventType) -> AnyPublisher<Void, Never> {
     return Publishers.ControlEventType(
       control: base,
       event: event
     ).eraseToAnyPublisher()
   }
     
  func publisher(for events: [NSEvent.EventType]) -> AnyPublisher<Void, Never> {
       return Publishers.ControlEventType(
         control: base,
         events: events
       ).eraseToAnyPublisher()
    }
    
    func publisher(for events: NSEvent.EventType...) -> AnyPublisher<Void, Never> {
         return Publishers.ControlEventType(
           control: base,
           events: events
         ).eraseToAnyPublisher()
    }
    
    /// A publisher emitting events from this control.
   private  func publisher(for maskedEvents: NSEvent.EventTypeMask) -> AnyPublisher<Void, Never> {
      return Publishers.ControlEvent(
        control: base,
        events: maskedEvents
      ).eraseToAnyPublisher()
    }
    
    var controlSize: BindingSink<Base, Base.ControlSize> {
        BindingSink(owner: base) { $0.controlSize = $1 }
    }
    
    var isEnabled: BindingSink<Base, Bool> {
        BindingSink(owner: base) { $0.isEnabled = $1 }
    }
    
    var isHighlighted: BindingSink<Base, Bool> {
        BindingSink(owner: base) { $0.isHighlighted = $1 }
    }
    
    var isContinuous: BindingSink<Base, Bool> {
        BindingSink(owner: base) { $0.isContinuous = $1 }
    }
    
}

#endif
