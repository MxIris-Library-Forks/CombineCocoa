//
//  ActionHandler.swift
//  FZCollection
//
//  Created by Florian Zand on 27.05.22.
//
 
#if os(macOS)
import AppKit
import Combine

public extension NSControl {
    internal class ActionHandler: NSObject {
      fileprivate var actions: [AnyHashable: () -> Void] = [:]
      fileprivate var targetActions: [(NSControl, AnyObject, Selector, [NSEvent.EventType]?)] = []
    
        func allTargets() -> [AnyObject] {
            return targetActions.compactMap({$0.1}).uniqued()
        }
        
        func allActions(for target: AnyObject) -> [Selector] {
            return targetActions.filter({$0.1 === target}).compactMap({$0.2})
        }
        
        func removeTarget(_ target: AnyObject?,
                action: Selector?) {
            targetActions.removeAll(where: {$0.1 === target && $0.2 == action})
        }
        
        func setActionTarget(for control: NSControl, _ action: Selector, target: AnyObject, for event: NSEvent.EventType? = nil) {
            let event = (event != nil) ? [event!] : nil
            targetActions.append((control, target, action,event))
        }
        
        func setActionTarget(for control: NSControl, _ action: Selector, target: AnyObject, for events: [NSEvent.EventType]?) {
            targetActions.append((control, target, action,events))
        }
        
      func setAction(
        forKey key: AnyHashable,
        events: NSEvent.EventTypeMask,
        value action: (() -> Void)?
      ) {
        actions[key] = action.map { action in
          { if events.intersects(.current) {
              action()
          } }
        }
      }
                
        func setAction(
          forKey key: AnyHashable,
          eventType: NSEvent.EventType,
          value action: (() -> Void)?
        ) {
          actions[key] = action.map { action in
              { if eventType == NSEvent.current?.type {
                action()
            } }
          }
        }
        
        func setAction(
          forKey key: AnyHashable,
          eventTypes: [NSEvent.EventType],
          value action: (() -> Void)?
        ) {
          actions[key] = action.map { action in
              { if let current = NSEvent.current?.type, eventTypes.contains(current) {
                action()
            } }
          }
        }

      @objc private func handle() {
        actions.values.forEach {
          //  Swift.print(NSEvent.current)
            if (NSEvent.current?.type.rawValue != 16) {
            $0()
            }
        }
          
          if let current = NSEvent.current {
          targetActions.forEach {
            control, target, selector, mask in
        //      control.sendAction(on: mask)
              if (control.isContinuous) {
              control.sendAction(selector, to: target)
              } else if (current.type == .leftMouseUp) {
                  control.sendAction(selector, to: target)
              }
          }
          }
      }
        
        func attach(to control: NSControl, keepPreviousAction: Bool = true) {
            if (keepPreviousAction) {
          if let target = control.target, let action = control.action, (target as? NSControl.ActionHandler) == nil {
              targetActions.append((control, target, action, nil))
       //      let action: (() -> Void) = {control.sendAction(action, to: target)}
        //     actions["Sender"]  = action
          }
            }
        control.target = self
        control.action = #selector(handle)
        control.sendAction(on: .any)
      }
    }
  }

internal extension NSEvent {
    /**
     The location of the event inside the specified view.
     - Parameters view: The view for the location.
     - Returns: The location of the event.
     */
    func location(in view: NSView) -> CGPoint {
        return view.convert(locationInWindow, from: nil)
    }
    
    /// The last event that the app retrieved from the event queue.
    static var current: NSEvent? {
        NSApplication.shared.currentEvent
    }
}

#endif
