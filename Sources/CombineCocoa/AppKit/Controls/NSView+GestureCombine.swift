//
//  NSView+Combine+Gesture.swift
//  FZCollection
//
//  Created by Florian Zand on 30.05.22.
//

#if os(macOS)
import AppKit
import Combine

extension CombineExtension where Base: NSView {
    private func publisher<G>(for GestureRecognizer: G.Type) -> NSGestureRecognizer.Publisher<G> where G: NSGestureRecognizer {
         let gestureRecognizer = GestureRecognizer.init()
         return NSGestureRecognizer.Publisher(gestureRecognizer: gestureRecognizer, view: base)
     }
    
    func publisher<G>(for gestureRecognizer: G) -> NSGestureRecognizer.Publisher<G> where G: NSGestureRecognizer {
        NSGestureRecognizer.Publisher(gestureRecognizer: gestureRecognizer, view: base)
    }
    
    var gestureRecognizer: GestureRecognizer {
        return GestureRecognizer(self)
    }
    
    public struct GestureRecognizer {
        private var base: CombineExtension
        init(_ base: CombineExtension) {
            self.base = base
        }
        
        func clickPublisher() -> NSGestureRecognizer.Publisher<NSClickGestureRecognizer> {
            return base.publisher(for: NSClickGestureRecognizer.self)
        }
        
        func magnificationPublisher() -> NSGestureRecognizer.Publisher<NSMagnificationGestureRecognizer> {
            return base.publisher(for: NSMagnificationGestureRecognizer.self)
        }
        
        func panPublisher() -> NSGestureRecognizer.Publisher<NSPanGestureRecognizer> {
            return base.publisher(for: NSPanGestureRecognizer.self)
        }
        
        func rotationPublisher() -> NSGestureRecognizer.Publisher<NSRotationGestureRecognizer> {
            return base.publisher(for: NSRotationGestureRecognizer.self)
        }
        
        func pressPublisher() -> NSGestureRecognizer.Publisher<NSPressGestureRecognizer> {
            return base.publisher(for: NSPressGestureRecognizer.self)
        }
    }
}

#endif
