//
//  NSView+.swift
//  CombTest
//
//  Created by Florian Zand on 27.05.22.
//

#if os(macOS)
import AppKit
import Combine

public extension CombineExtension where Base: NSView {
    func framePublisher() -> AnyPublisher<CGRect, Never>  {
        NotificationCenter.default
            .publisher(for: NSView.frameDidChangeNotification, object: base)
            .map( { ($0.object as! NSView).frame } ).eraseToAnyPublisher()
    }
    
    func boundsPublisher() -> AnyPublisher<CGRect, Never>  {
        NotificationCenter.default
            .publisher(for: NSView.boundsDidChangeNotification, object: base)
            .map( { ($0.object as! NSView).bounds } ).eraseToAnyPublisher()
    }
    
    var alphaValue: BindingSink<Base, Double> {
        BindingSink(owner: base) { $0.alphaValue = $1 }
    }
    
    var isHidden: BindingSink<Base, Bool> {
        BindingSink(owner: base) { $0.isHidden = $1 }
    }
}

#endif
