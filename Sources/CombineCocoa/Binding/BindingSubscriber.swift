//
//  BindingOwner.swift
//  CombTest
//
//  Created by Florian Zand on 27.05.22.
//

import Foundation
import Combine

public protocol BindingSubscriber: Subscriber, Cancellable {
    @discardableResult
    static func bind<P: Publisher>(subscriber: Self, source: P) -> AnyCancellable
        where P.Output == Input, P.Failure == Failure
}

extension Publisher {
    @discardableResult
    static func bind<B: BindingSubscriber>(source: Self, subscriber: B) -> AnyCancellable
        where Output == B.Input, Failure == B.Failure
    {
        B.bind(subscriber: subscriber, source: source)
    }
}

// MARK: Optional
extension BindingSubscriber {
    @discardableResult
    static func bind<P: Publisher>(subscriber: Self, source: P) -> AnyCancellable
        where Input == P.Output?, Failure == P.Failure
    {
        Self.bind(subscriber: subscriber, source: source.map(Optional.some))
    }
}
