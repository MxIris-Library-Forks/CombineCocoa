//
//  Publisher+Bind.swift
//  CombTest
//
//  Created by Florian Zand on 27.05.22.
//

import Foundation
import Combine

extension Publisher {
    @discardableResult
    static func bind<B: BindingSubscriber>(source: Self, subscriber: B) -> AnyCancellable
        where B.Input == Output?, B.Failure == Failure
    {
        B.bind(subscriber: subscriber, source: source)
    }
}

extension Publisher {
    public func bind<B: BindingSubscriber>(to sink: B) -> AnyCancellable where B.Input == Output, B.Failure == Failure {
        B.bind(subscriber: sink, source: self)
    }

    public func bind<B: BindingSubscriber>(to sink: B) -> AnyCancellable where B.Input == Output?, B.Failure == Failure {
        B.bind(subscriber: sink, source: self)
    }
}

extension Publisher {
    public func bind(
        receiveCompletion: @escaping ((Subscribers.Completion<Failure>) -> Void),
        receiveValue: @escaping ((Output) -> Void)
    ) -> AnyCancellable {
        let subscriber = Subscribers.Sink<Self.Output, Failure>(
            receiveCompletion: receiveCompletion, receiveValue: receiveValue
        )
        self.receive(subscriber: subscriber)
        return BlockCancellable {
            subscriber.cancel()
        }.eraseToAnyCancellable()
    }
}

extension Publisher where Failure == Never {
    public func bind(
        receiveValue: @escaping ((Output) -> Void)
    ) -> AnyCancellable {
        let subscriber = Subscribers.Sink<Self.Output, Never>(
            receiveCompletion: { _ in }, receiveValue: receiveValue
        )
        self.receive(subscriber: subscriber)
        return BlockCancellable {
            subscriber.cancel()
        }.eraseToAnyCancellable()
    }
}

extension Publisher where Failure == Never {
    public func bind<Root>(
        object: Root, keyPath: ReferenceWritableKeyPath<Root, Output>
    ) -> AnyCancellable {
        let subscriber = Subscribers.Assign(object: object, keyPath: keyPath)
        self.receive(subscriber: subscriber)
        return BlockCancellable {
            subscriber.cancel()
        }.eraseToAnyCancellable()
    }
}
