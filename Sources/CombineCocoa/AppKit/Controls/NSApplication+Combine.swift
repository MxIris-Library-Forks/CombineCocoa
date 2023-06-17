//
//  NSApplication+.swift
//  CombTest
//
//  Created by Florian Zand on 27.05.22.
//

#if os(macOS)
import AppKit
import Combine

public extension CombineExtension where Base: NSApplication {
    func willTerminatePublisher() -> AnyPublisher<Void, Never>  {
        NotificationCenter.default
            .publisher(for: NSApplication.willTerminateNotification, object: base)
            .map({_ in return })
            .eraseToAnyPublisher()
    }
    
    func didHidePublisher() -> AnyPublisher<Void, Never>  {
        NotificationCenter.default
            .publisher(for: NSApplication.didHideNotification, object: base)
            .map({_ in return })
            .eraseToAnyPublisher()
    }
    
    func didUnhidePublisher() -> AnyPublisher<Void, Never>  {
        NotificationCenter.default
            .publisher(for: NSApplication.didUnhideNotification, object: base)
            .map({_ in return })
            .eraseToAnyPublisher()
    }
    
    func willUnhidePublisher() -> AnyPublisher<Void, Never>  {
        NotificationCenter.default
            .publisher(for: NSApplication.willUnhideNotification, object: base)
            .map({_ in return })
            .eraseToAnyPublisher()
    }
    
    func willHidePublisher() -> AnyPublisher<Void, Never>  {
        NotificationCenter.default
            .publisher(for: NSApplication.willHideNotification, object: base)
            .map({_ in return })
            .eraseToAnyPublisher()
    }
    
    func willBecomeActivePublisher() -> AnyPublisher<Void, Never>  {
        NotificationCenter.default
            .publisher(for: NSApplication.willBecomeActiveNotification, object: base)
            .map({_ in return })
            .eraseToAnyPublisher()
    }
    
    func didBecomeActivePublisher() -> AnyPublisher<Void, Never>  {
        NotificationCenter.default
            .publisher(for: NSApplication.didBecomeActiveNotification, object: base)
            .map({_ in return })
            .eraseToAnyPublisher()
    }
    
    func didResignActivePublisher() -> AnyPublisher<Void, Never>  {
        NotificationCenter.default
            .publisher(for: NSApplication.didResignActiveNotification, object: base)
            .map({_ in return })
            .eraseToAnyPublisher()
    }
    
    func willResignActivePublisher() -> AnyPublisher<Void, Never>  {
        NotificationCenter.default
            .publisher(for: NSApplication.willResignActiveNotification, object: base)
            .map({_ in return })
            .eraseToAnyPublisher()
    }
}
#endif
