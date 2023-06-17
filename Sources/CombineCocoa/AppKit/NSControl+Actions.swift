//
//  NSControl+MultipleTargets.swift
//  CombTest
//
//  Created by Florian Zand on 27.05.22.
//


#if os(macOS)
import AppKit
import Combine

public extension NSControl {
    func addTarget(_ target: AnyObject,
            action: Selector,
                   for events: [NSEvent.EventType]?) {
        if let handler = self.target as? NSControl.ActionHandler {
            handler.setActionTarget(for: self, action, target: target, for: events)
        } else {
           let handler = NSControl.ActionHandler()
            handler.setActionTarget(for: self, action, target: target, for: events)
            handler.attach(to: self)
        }
    }
    
    func addTarget(_ target: AnyObject,
            action: Selector,
                   for event: NSEvent.EventType? = nil) {
        self.addTarget(target, action: action, for: (event != nil) ? [event!] : nil)
    }
    
    func removeTarget(_ target: AnyObject?,
            action: Selector?) {
        if let handler = self.target as? NSControl.ActionHandler {
            handler.removeTarget(target, action: action)
        } else {
            if let target = target, self.target === target {
                self.target = nil
            }
            if let action = action, self.action == action {
                self.action = nil
            }
        }
    }
    
    func allTagets() -> [AnyObject] {
        if let handler = self.target as? NSControl.ActionHandler {
          return handler.allTargets()
        } else {
            return (self.target != nil) ? [self.target!] : []
        }
    }
    
    func allActions(for target: AnyObject) -> [Selector] {
        if let handler = self.target as? NSControl.ActionHandler {
          return handler.allActions(for: target)
        } else {
            if (self.target === target) {
                return (self.action != nil) ? [self.action!] : []
            }
        }
        return []
    }
}
#endif
