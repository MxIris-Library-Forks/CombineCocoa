//
//  NSScrollView+.swift
//  CombTest
//
//  Created by Florian Zand on 27.05.22.
//

#if os(macOS)
import AppKit
import Combine

public extension CombineExtension where Base: NSScrollView {
    func contentOffsetPublisher() -> AnyPublisher<CGPoint, Never> {
        base.contentView.postsBoundsChangedNotifications = true
       return base.contentView.combine.boundsPublisher()
            .map({_ in base.contentOffset})
            .removeDuplicates()
            .eraseToAnyPublisher()
    }
    
    func magnificationPublisher() -> AnyPublisher<CGFloat, Never> {
        base.contentView.postsBoundsChangedNotifications = true
       return base.contentView.combine.boundsPublisher()
            .map({_ in base.magnification})
            .removeDuplicates()
            .eraseToAnyPublisher()
    }
     
    func userWillStartScrollPublisher() -> AnyPublisher<Void, Never>  {
        NotificationCenter.default
            .publisher(for: NSScrollView.willStartLiveScrollNotification, object: base.contentView)
            .map( {_ in return} )
            .eraseToAnyPublisher()
    }
    
    func userDidScrollPublisher() -> AnyPublisher<Void, Never>  {
        NotificationCenter.default
            .publisher(for: NSScrollView.didLiveScrollNotification, object: base)
            .map( {_ in return} )
            .eraseToAnyPublisher()
    }
    
    func userDidEndScrollPublisher() -> AnyPublisher<Void, Never>  {
        NotificationCenter.default
            .publisher(for: NSScrollView.didEndLiveScrollNotification, object: base)
            .map( {_ in return} )
            .eraseToAnyPublisher()
    }
    
    func userWillStartMagnifyPublisher() -> AnyPublisher<Void, Never>  {
        NotificationCenter.default
            .publisher(for: NSScrollView.willStartLiveMagnifyNotification, object: base)
            .map( {_ in return} )
            .eraseToAnyPublisher()
    }
    
    func userDidEndMagnifyPublisher() -> AnyPublisher<Void, Never>  {
        NotificationCenter.default
            .publisher(for: NSScrollView.didEndLiveMagnifyNotification, object: base)
            .map( {_ in return} )
            .eraseToAnyPublisher()
    }
    
    var allowsMagnification: BindingSink<Base, Bool> {
        BindingSink(owner: base) { $0.allowsMagnification = $1 }
    }
    
    var minMagnification: BindingSink<Base, Double> {
        BindingSink(owner: base) { $0.minMagnification = $1 }
    }

    var maxMagnification: BindingSink<Base, Double> {
        BindingSink(owner: base) { $0.maxMagnification = $1 }
    }
    
    var drawsBackground: BindingSink<Base, Bool> {
        BindingSink(owner: base) { $0.drawsBackground = $1 }
    }
    
    var backgroundColor: BindingSink<Base, NSColor> {
        BindingSink(owner: base) { $0.backgroundColor = $1 }
    }
    
    var hasVerticalScroller: BindingSink<Base, Bool> {
        BindingSink(owner: base) { $0.hasVerticalScroller = $1 }
    }
    
    var hasHorizontalScroller: BindingSink<Base, Bool> {
        BindingSink(owner: base) { $0.hasHorizontalScroller = $1 }
    }
    
    var autohidesScrollers: BindingSink<Base, Bool> {
        BindingSink(owner: base) { $0.autohidesScrollers = $1 }
    }
    
}

internal extension NSScrollView {
    /**
     The point at which the origin of the content view is offset from the origin of the scroll view.
     
     The default value is CGPointZero.
     */
    @objc dynamic var contentOffset: CGPoint {
        get {
            return documentVisibleRect.origin
        }
        set {
            willChangeValue(for: \.contentOffset)
            documentView?.scroll(newValue)
            didChangeValue(for: \.contentOffset)
        }
    }
}

#endif
