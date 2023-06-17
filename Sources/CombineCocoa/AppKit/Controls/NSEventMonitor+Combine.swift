//
//  NSEvent+Combine.swift
//  ToolbarTest
//
//  Created by Florian Zand on 27.05.22.
//

#if os(macOS)
import AppKit
import Combine

public extension CombineExtension where Base: NSEvent {
    /// Returns a publisher that emits events from a local or global NSEvent monitor.
    /// - Parameters:
    ///   - scope: The scope of the events to monitor.
    ///   - mask: A mask specifying the type of events to monitor.
    static func publisher(for scope: Publisher.Scope, matching mask: Base.EventTypeMask) -> Publisher {
        return Publisher(scope: scope, matching: mask)
    }
    
     struct Publisher: Combine.Publisher {
        public typealias Output = NSEvent
        public typealias Failure = Never
        
        /// Determines the scope of the NSEvent publisher.
        public enum Scope {
            /// Monitor local events
            case local
            
            /// Monitor global events
            case global
        }
        
        private let scope: Scope
         private let matching: NSEvent.EventTypeMask
        
         public init(scope: Scope, matching: NSEvent.EventTypeMask) {
            self.scope    = scope
            self.matching = matching
        }
        
        public func receive<S>(subscriber: S) where S: Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
            let subscription = Subscription(scope: scope, matching: matching, subscriber: subscriber)
            subscriber.receive(subscription: subscription)
        }
    }
}


private extension CombineExtension.Publisher where Base: NSEvent {
    final class Subscription<S: Subscriber> where S.Input == NSEvent, S.Failure == Never {
        fileprivate let lock = NSLock()
        fileprivate var demand = Subscribers.Demand.none
        private var monitor: Any?
        
        fileprivate let subscriberLock = NSRecursiveLock()
        
        init(scope: Scope, matching: NSEvent.EventTypeMask, subscriber: S) {
            switch scope {
            case .local:
                monitor = NSEvent.addLocalMonitorForEvents(matching: matching, handler: { [weak self] (event) -> NSEvent? in
                    self?.didReceive(event: event, subscriber: subscriber)
                    return event
                })
                
            case .global:
                monitor = NSEvent.addGlobalMonitorForEvents(matching: matching, handler: { [weak self] in
                    self?.didReceive(event: $0, subscriber: subscriber)
                })
            }
            
        }
        
        deinit {
            if let monitor = monitor {
                NSEvent.removeMonitor(monitor)
            }
        }
        
        func didReceive(event: NSEvent, subscriber: S) {
            let val = { () -> Subscribers.Demand in
                lock.lock()
                defer { lock.unlock() }
                let before = demand
                if demand > 0 {
                    demand -= 1
                }
                return before
            }()
            
            guard val > 0 else { return }
            
            let newDemand = subscriber.receive(event)
            
            lock.lock()
            demand += newDemand
            lock.unlock()
        }
    }
}

extension CombineExtension.Publisher.Subscription: Combine.Subscription where Base: NSEvent {
    func request(_ demand: Subscribers.Demand) {
        lock.lock()
        defer { lock.unlock() }
        self.demand += demand
    }
    
    func cancel() {
        lock.lock()
        defer { lock.unlock() }
        guard let monitor = monitor else { return }
        
        self.monitor = nil
        NSEvent.removeMonitor(monitor)
    }
}


#endif
