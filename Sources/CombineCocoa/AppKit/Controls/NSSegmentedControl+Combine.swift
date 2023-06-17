//
//  NSSegmentedControl+.swift
//  CombTest
//
//  Created by Florian Zand on 27.05.22.
//

#if os(macOS)
import AppKit
import Combine

public extension CombineExtension where Base: NSSegmentedControl {
     func selectedSegmentPublisher() -> AnyPublisher<Int, Never> {
         return self.publisher(for: NSEvent.EventType.leftMouseUp)
             .map({base.selectedSegment})
             .removeDuplicates()
             .eraseToAnyPublisher()
    }
    
    var segmentStyle: BindingSink<Base, Base.Style> {
        BindingSink(owner: base) { $0.segmentStyle = $1 }
    }
    
    var segmentDistribution: BindingSink<Base,Base.Distribution> {
        BindingSink(owner: base) { $0.segmentDistribution = $1 }
    }
    
    var segmentCount: BindingSink<Base,Int> {
        BindingSink(owner: base) { $0.segmentCount = $1 }
    }
    
    var segments: BindingSink<Base,[NSSegment]> {
        BindingSink(owner: base) { $0.segments = $1 }
    }
}

extension NSSegmentedControl {
   private func segment(for index: Int) -> NSSegment? {
        if (index > -1 && index < self.segmentCount) {
            let segment = NSSegment(title: self.label(forSegment: index),
                                    image: self.image(forSegment: index),
                                    isSelected: self.isSelected(forSegment: index),
                                    imageScaling: self.imageScaling(forSegment: index),
                                    menu: menu(forSegment: index),
                                    textAlignment: self.alignment(forSegment: index))
           return segment
        }
        return nil
    }
    
    
   private func setSegment(_ segment: NSSegment, for index: Int) {
        if (index > -1 && index < self.segmentCount) {
            self.setImage(segment.image, forSegment: index)
            self.setLabel(segment.title ?? "", forSegment: index)
            self.setSelected(segment.isSelected, forSegment: index)
            self.setImageScaling(segment.imageScaling, forSegment: index)
            self.setMenu(segment.menu, forSegment: index)
            self.setAlignment(segment.textAlignment, forSegment: index)
        }
    }
    
    var segments: [NSSegment] {
        get {
        var segments = [NSSegment]()
        for i in 0...segmentCount-1 {
            if let segment = segment(for: i) {
            segments.append(segment)
            }
        }
        return segments
        }
        set {
            self.segmentCount = newValue.count
            for (index, segment) in newValue.enumerated() {
                if (self.segment(for: index) != segment) {
                    self.setSegment(segment, for: index)
                    if (segment.isSelected) {
                        self.selectedSegment = index
                    }
                }
            }
            Swift.print(self.segmentCount)
            Swift.print(self.selectedSegment)

            if (self.trackingMode == .selectOne && self.selectedSegment == -1 && self.segmentCount > 0) {
                self.setSelected(true, forSegment: 0)
            }
        }
    }
}


public struct NSSegment: Equatable {
    init(title: String?, image: NSImage?, isSelected: Bool, imageScaling: NSImageScaling, menu: NSMenu?, textAlignment: NSTextAlignment) {
        self.title = title
        self.image = image
        self.isSelected = isSelected
        self.imageScaling = imageScaling
        self.menu = menu
        self.textAlignment = textAlignment
    }
    
    init(_ title: String, isSelected: Bool = false) {
        self.title = title
        self.isSelected = isSelected
    }
    
    init(_ image: NSImage, isSelected: Bool = false) {
        self.image = image
        self.isSelected = isSelected
    }
    
    init(_ title: String, image: NSImage, isSelected: Bool = false) {
        self.title = title
        self.image = image
        self.isSelected = isSelected
    }
    
    var image: NSImage? = nil
    var title: String? = ""
    var isSelected: Bool = false
    var imageScaling: NSImageScaling = .scaleProportionallyDown
    var menu: NSMenu? = nil
    var textAlignment: NSTextAlignment = .center
}


#endif
