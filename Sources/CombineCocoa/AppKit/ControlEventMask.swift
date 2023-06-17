//
//  ControlEvent.swift
//  FZCollection
//
//  Created by Florian Zand on 27.05.22.
//

#if canImport(UIKit)
import UIKit
import Combine



  // MARK: - Publisher
  extension Combine.Publishers {
    /// A Control Event is a publisher that emits whenever the provided
    /// Control Events fire.
    public struct ControlEvent<Control: UIControl>: Publisher {
      public typealias Output = Void
      public typealias Failure = Never

      private let control: Control
      private let controlEvents: Control.Event

      /// Initialize a publisher that emits a Void
      /// whenever any of the provided Control Events trigger.
      ///
      /// - parameter control: UI Control.
      /// - parameter events: Control Events.
      public init(
        control: Control,
        events: Control.Event
      ) {
        self.control = control
        self.controlEvents = events
      }

      public func receive<S: Subscriber>(subscriber: S)
      where S.Failure == Failure, S.Input == Output {
        let subscription = Subscription(
          subscriber: subscriber,
          control: control,
          event: controlEvents
        )

        subscriber.receive(subscription: subscription)
      }
    }
  }

  // MARK: - Subscription
  extension Combine.Publishers.ControlEvent {
    private final class Subscription<
      SubscriberType: Subscriber
    >: Combine.Subscription where SubscriberType.Input == Void {
      private var subscriber: SubscriberType?
      weak private var control: Control?

      init(subscriber: SubscriberType, control: Control, event: Control.Event) {
        self.subscriber = subscriber
        self.control = control
        control.addTarget(self, action: #selector(handleEvent), for: event)
      }

      func request(_ demand: Subscribers.Demand) {
        // We don't care about the demand at this point.
        // As far as we're concerned - UIControl events are endless until the control is deallocated.
      }

      func cancel() {
        subscriber = nil
      }

      @objc private func handleEvent() {
        _ = subscriber?.receive()
      }
    }
  }

#elseif canImport(Combine) && os(macOS)
  import Combine
  import Foundation
  import AppKit

  // MARK: - Publisher
  extension Combine.Publishers {
    /// A Control Event is a publisher that emits whenever the provided
    /// Control Events fire.
    public struct ControlEvent<Control: NSControl>: Publisher {
      public typealias Output = Void
      public typealias Failure = Never

      let control: Control
      let controlEvents: NSEvent.EventTypeMask

      init(control: Control, events: NSEvent.EventTypeMask) {
        self.control = control
        self.controlEvents = events
      }

      public func receive<S>(subscriber: S)
      where S: Subscriber, S.Failure == Failure, S.Input == Output {
        let subscription = Subscription(
          subscriber: subscriber,
          control: control,
          events: controlEvents
        )
        subscriber.receive(subscription: subscription)
      }
    }
  }

  // MARK: - Subscription
  extension Combine.Publishers.ControlEvent {
    public final class Subscription<
      SubscriberType: Subscriber
    >: Combine.Subscription where SubscriberType.Input == Void {
      private let id = UUID()
      private let handler: NSControl.ActionHandler
      private var subscriber: SubscriberType?
      private let control: Control
      private let events: NSEvent.EventTypeMask

      init(subscriber: SubscriberType, control: Control, events: NSEvent.EventTypeMask) {
        self.subscriber = subscriber
        self.control = control
        self.events = events

        if let handler = control.target as? NSControl.ActionHandler {
          self.handler = handler
        } else {
          self.handler = NSControl.ActionHandler()
        }
        handler.setAction(forKey: id, events: events, value: eventHandler)
        self.handler.attach(to: control)
      }

      public func request(_ demand: Subscribers.Demand) {
        // We do nothing here as we only want to send events when they occur.
        // See, for more info: https://developer.apple.com/documentation/combine/subscribers/demand
      }

      public func cancel() {
        subscriber = nil
      }

      private func eventHandler() {
        guard events.intersects(.current) else { return }
        _ = subscriber?.receive()
      }
    }
  }
#endif
