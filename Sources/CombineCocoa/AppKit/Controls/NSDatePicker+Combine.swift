//
//  NSDatePicker+Combine.swift
//  FZCollection
//
//  Created by Florian Zand on 30.05.22.
//

#if os(macOS)
import AppKit
import Combine

public extension CombineExtension where Base: NSDatePicker {
    func datePublisher() -> AnyPublisher<Date, Never> {
        return self.publisher(for: NSEvent.EventType.userInteractions)
            .map({base.dateValue})
            .removeDuplicates()
            .eraseToAnyPublisher()
   }
    
    func timeIntervalPublisher() -> AnyPublisher<TimeInterval, Never> {
        return self.publisher(for: NSEvent.EventType.userInteractions)
            .map({base.timeInterval})
            .removeDuplicates()
            .eraseToAnyPublisher()
   }
    
    func endDatePublisher() -> AnyPublisher<Date, Never> {
        let publisher = self.timeIntervalPublisher()
            .map({_ in base.dateValue + base.timeInterval})
            .removeDuplicates()
            .eraseToAnyPublisher()
        return publisher
   }
    
    var isBezeled: BindingSink<Base, Bool> {
           BindingSink(owner: base) { $0.isBezeled = $1 }
       }
    
    var isBordered: BindingSink<Base, Bool> {
           BindingSink(owner: base) { $0.isBordered = $1 }
       }
    
    var drawsBackground: BindingSink<Base, Bool> {
           BindingSink(owner: base) { $0.drawsBackground = $1 }
       }
    
    @available(macOS 10.15.4, *)
    var presentsCalendarOverlay: BindingSink<Base, Bool> {
           BindingSink(owner: base) { $0.presentsCalendarOverlay = $1 }
       }
    
    var backgroundColor: BindingSink<Base, NSColor> {
           BindingSink(owner: base) { $0.backgroundColor = $1 }
       }
    
    var textColor: BindingSink<Base, NSColor> {
           BindingSink(owner: base) { $0.textColor = $1 }
       }
    
    var minDate: BindingSink<Base, Date?> {
           BindingSink(owner: base) { $0.minDate = $1 }
       }
    
    var maxDate: BindingSink<Base, Date?> {
           BindingSink(owner: base) { $0.maxDate = $1 }
       }
    
    var datePickerMode: BindingSink<Base, NSDatePicker.Mode> {
           BindingSink(owner: base) { $0.datePickerMode = $1 }
       }
    
    var datePickerStyle: BindingSink<Base, NSDatePicker.Style> {
           BindingSink(owner: base) { $0.datePickerStyle = $1 }
    }
    
    var datePickerElements: BindingSink<Base, NSDatePicker.ElementFlags> {
           BindingSink(owner: base) { $0.datePickerElements = $1 }
    }
}



#endif
