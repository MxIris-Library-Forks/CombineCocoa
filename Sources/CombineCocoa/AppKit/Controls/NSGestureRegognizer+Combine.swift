//
//  NSGestureRegognizer+.swift
//  CombTest
//
//  Created by Florian Zand on 27.05.22.
//

#if os(macOS)
import AppKit
import Combine

extension NSGestureRecognizer {
    struct Publisher<G>: Combine.Publisher where G: NSGestureRecognizer {
        
        typealias Output = (G, NSGestureRecognizer.State)
        typealias Failure = Never
        
        let gestureRecognizer: G
        let view: NSView
        
        func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
            subscriber.receive(
                subscription: Subscription(subscriber: subscriber, gestureRecognizer: gestureRecognizer, on: view)
            )
        }
    }
    
    class Subscription<G: NSGestureRecognizer, S: Subscriber>: Combine.Subscription where S.Input == (G, NSGestureRecognizer.State), S.Failure == Never {
        var subscriber: S?
        let gestureRecognizer: G
        let view: NSView
        
        init(subscriber: S, gestureRecognizer: G, on view: NSView) {
            self.subscriber = subscriber
            self.gestureRecognizer = gestureRecognizer
            self.view = view
            gestureRecognizer.target = self
            gestureRecognizer.action = #selector(handle)
            view.addGestureRecognizer(gestureRecognizer)
        }
        
        @objc private func handle(_ gesture: NSGestureRecognizer) {
            _ = subscriber?.receive((gestureRecognizer, gesture.state))
        }
        
        func cancel() {
            view.removeGestureRecognizer(gestureRecognizer)
        }
        
        func request(_ demand: Subscribers.Demand) { }
    }
}


#endif
