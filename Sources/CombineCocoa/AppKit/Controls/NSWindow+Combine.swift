//
//  NSWindow+.swift
//  CombTest
//
//  Created by Florian Zand on 27.05.22.
//

#if os(macOS)
import AppKit
import Combine

public extension CombineExtension where Base: NSWindow {
    func didMovePublisher() -> AnyPublisher<CGRect, Never>  {
        NotificationCenter.default
            .publisher(for: NSWindow.didMoveNotification, object: base)
            .map( { ($0.object as! NSWindow).frame } ).eraseToAnyPublisher()
    }
    func willMovePublisher() -> AnyPublisher<CGRect, Never>  {
        NotificationCenter.default
            .publisher(for: NSWindow.willMoveNotification, object: base)
            .map( { ($0.object as! NSWindow).frame } ).eraseToAnyPublisher()
    }
    func didResizePublisher() -> AnyPublisher<CGRect, Never>  {
        NotificationCenter.default
            .publisher(for: NSWindow.didResizeNotification, object: base)
            .map( { ($0.object as! NSWindow).frame } ).eraseToAnyPublisher()
    }
    
    func willStartLiveResizePublisher() -> AnyPublisher<CGRect, Never>  {
        NotificationCenter.default
            .publisher(for: NSWindow.willStartLiveResizeNotification, object: base)
            .map( { ($0.object as! NSWindow).frame } ).eraseToAnyPublisher()
    }
    
    func didMiniaturizePublisher() -> AnyPublisher<NSWindow, Never>  {
        NotificationCenter.default
            .publisher(for: NSWindow.didMiniaturizeNotification, object: base)
            .map( { ($0.object as! NSWindow) } ).eraseToAnyPublisher()
    }
    
    
    func didEnterFullScreenPublisher() -> AnyPublisher<NSWindow, Never>  {
        NotificationCenter.default
            .publisher(for: NSWindow.didEnterFullScreenNotification, object: base)
            .map( { ($0.object as! NSWindow) } ).eraseToAnyPublisher()
    }
    
    func didExitFullScreenPublisher() -> AnyPublisher<NSWindow, Never>  {
        NotificationCenter.default
            .publisher(for: NSWindow.didExitFullScreenNotification, object: base)
            .map( { ($0.object as! NSWindow) } ).eraseToAnyPublisher()
    }
    
    func didBecomeMainPublisher() -> AnyPublisher<NSWindow, Never>  {
        NotificationCenter.default
            .publisher(for: NSWindow.didBecomeMainNotification, object: base)
            .map( { ($0.object as! NSWindow) } ).eraseToAnyPublisher()
    }
    
    func didBecomeKeyPublisher() -> AnyPublisher<NSWindow, Never>  {
        NotificationCenter.default
            .publisher(for: NSWindow.didBecomeKeyNotification, object: base)
            .map( { ($0.object as! NSWindow) } ).eraseToAnyPublisher()
    }
    
    func didResignMainPublisher() -> AnyPublisher<NSWindow, Never>  {
        NotificationCenter.default
            .publisher(for: NSWindow.didResignMainNotification, object: base)
            .map( { ($0.object as! NSWindow) } ).eraseToAnyPublisher()
    }
    
    func didResignKeyPublisher() -> AnyPublisher<NSWindow, Never>  {
        NotificationCenter.default
            .publisher(for: NSWindow.didResignKeyNotification, object: base)
            .map( { ($0.object as! NSWindow) } ).eraseToAnyPublisher()
    }
    
    var maxSize: BindingSink<Base, CGSize> {
        BindingSink(owner: base) { $0.maxSize = $1 }
    }
    
    var minSize: BindingSink<Base, CGSize> {
        BindingSink(owner: base) { $0.minSize = $1 }
    }
    
    var backgroundColor: BindingSink<Base, NSColor> {
        BindingSink(owner: base) { $0.backgroundColor = $1 }
    }
    
    var alphaValue: BindingSink<Base, Double> {
        BindingSink(owner: base) { $0.alphaValue = $1 }
    }
    
    var styleMask: BindingSink<Base, NSWindow.StyleMask> {
        BindingSink(owner: base) { $0.styleMask = $1 }
    }
    
    var toolbar: BindingSink<Base, NSToolbar?> {
        BindingSink(owner: base) { $0.toolbar = $1 }
    }
    
    @available(macOS 11.0, *)
    var toolbarStyle: BindingSink<Base, NSWindow.ToolbarStyle> {
        BindingSink(owner: base) { $0.toolbarStyle = $1 }
    }
    
    var titlebarAppearsTransparent: BindingSink<Base, Bool> {
        BindingSink(owner: base) { $0.titlebarAppearsTransparent = $1 }
    }
    
    var title: BindingSink<Base, String> {
        BindingSink(owner: base) { $0.title = $1 }
    }
    
    @available(macOS 11.0, *)
    var subtitle: BindingSink<Base, String> {
        BindingSink(owner: base) { $0.subtitle = $1 }
    }
    
    var titleVisibility: BindingSink<Base, NSWindow.TitleVisibility> {
        BindingSink(owner: base) { $0.titleVisibility = $1 }
    }

}

#endif
