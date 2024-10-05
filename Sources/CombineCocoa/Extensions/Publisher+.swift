import Foundation
import Combine

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
extension Publisher where Self.Failure == Never {

    /// Assigns each element from a publisher to a property on an object.
    ///
    /// Use the ``Publisher/assign(to:on:)`` subscriber when you want to set a given property each time a publisher produces a value.
    ///
    /// In this example, the ``Publisher/assign(to:on:)`` sets the value of the `anInt` property on an instance of `MyClass`:
    ///
    ///     class MyClass {
    ///         var anInt: Int = 0 {
    ///             didSet {
    ///                 print("anInt was set to: \(anInt)", terminator: "; ")
    ///             }
    ///         }
    ///     }
    ///
    ///     var myObject = MyClass()
    ///     let myRange = (0...2)
    ///     cancellable = myRange.publisher
    ///         .assign(to: \.anInt, on: myObject)
    ///
    ///     // Prints: "anInt was set to: 0; anInt was set to: 1; anInt was set to: 2"
    ///
    ///  > Important: The ``Subscribers/Assign`` instance created by this operator maintains a strong reference to `object`, and sets it to `nil` when the upstream publisher completes (either normally or with an error).
    ///
    /// - Parameters:
    ///   - keyPath: A key path that indicates the property to assign. See [Key-Path Expression](https://developer.apple.com/library/archive/documentation/Swift/Conceptual/Swift_Programming_Language/Expressions.html#//apple_ref/doc/uid/TP40014097-CH32-ID563) in _The Swift Programming Language_ to learn how to use key paths to specify a property of an object.
    ///   - object: The object that contains the property. The subscriber assigns the object’s property every time it receives a new value.
    /// - Returns: An ``AnyCancellable`` instance. Call ``Cancellable/cancel()`` on this instance when you no longer want the publisher to automatically assign the property. Deinitializing this instance will also cancel automatic assignment.
    public func assign<Root>(on object: Root, to keyPath: ReferenceWritableKeyPath<Root, Self.Output>) -> AnyCancellable {
        assign(to: keyPath, on: object)
    }
}
