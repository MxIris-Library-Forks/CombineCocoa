//
//  ControlEventType.swift
//  CombTest
//
//  Created by Florian Zand on 27.05.22.
//

#if os(macOS)
import AppKit
import Combine

extension Combine.Publishers {
  /// A Control Event is a publisher that emits whenever the provided
  /// Control Events fire.
  public struct ControlEventType<Control: NSControl>: Publisher {
    public typealias Output = Void
    public typealias Failure = Never
       typealias Event = NSEvent.EventType

    let control: Control
    let controlEvents: [Event]

    init(control: Control, event: Event) {
        self.init(control: control, events: [event])
    }
      
    init(control: Control, events: [Event]) {
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

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
extension Combine.Publishers.ControlEventType {
  public final class Subscription<
    SubscriberType: Subscriber
  >: Combine.Subscription where SubscriberType.Input == Void {
    private let id = UUID()
    private let handler: NSControl.ActionHandler
    private var subscriber: SubscriberType?
    private let control: Control
    private let events: [Event]
      
      typealias Event = NSEvent.EventType

      convenience init(subscriber: SubscriberType, control: Control, event: Event) {
        self.init(subscriber: subscriber, control: control, events: [event])
    }
      
      init(subscriber: SubscriberType, control: Control, events: [Event]) {
        self.subscriber = subscriber
        self.control = control
        self.events = events

        if let handler = control.target as? NSControl.ActionHandler {
          self.handler = handler
        } else {
          self.handler = NSControl.ActionHandler()
        }
        handler.setAction(forKey: id, eventTypes: events, value: eventHandler)
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
        guard let current = NSEvent.current?.type, events.contains(current) else { return }
      _ = subscriber?.receive()
    }
  }
}
#endif
