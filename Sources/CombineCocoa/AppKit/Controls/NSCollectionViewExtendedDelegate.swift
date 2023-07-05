//
//  NSCollectionViewDelegate+.swift
//  FZCollection
//
//  Created by Florian Zand on 30.05.22.
//

#if os(macOS)
import AppKit
import Combine

@objc protocol NSCollectionViewExtendedDelegate: NSCollectionViewDelegate {
    @objc optional func collectionView(_ collectionVIew: NSCollectionView, displaysItemsAt indexPaths: [IndexPath])
    @objc optional func collectionView(didScroll collectionVIew: NSCollectionView)
}


extension NSCollectionView {
    @objc private func didScroll(_ any: Any) {
        self.extendedDelegate?.collectionView?(self, displaysItemsAt: self.displayingIndexPaths())
    }
    
    var extendedDelegate: NSCollectionViewExtendedDelegate?{
        get {
            return (self.delegate as? NSCollectionViewExtendedDelegate)
        }
        set {
            if let newValue = newValue, let contentView = self.enclosingScrollView?.contentView {
                self.delegate = newValue
                NotificationCenter.default.addObserver(self, selector: #selector(self.didScroll(_:)), name: NSView.boundsDidChangeNotification, object: contentView)
                /*
                NSEvent.addLocalMonitorForEvents(matching: [.mouseMoved], handler: {event in
                    let point = event.location(in: self)
                    if let indexPath = self.indexPathForItem(at: point) {
                        self.extendedDelegate?.collectionView?(self, mouseHoversAt: indexPath)
                    }
                    return event
                })
                */
            } else {
                if extendedDelegate != nil {
                    NotificationCenter.default.removeObserver(self, name: NSView.boundsDidChangeNotification, object: nil)
                    self.delegate = nil
                }
            }
        }
    }
}

internal extension NSCollectionView {
    func displayingIndexPaths() -> [IndexPath] {
        return displayingItems().compactMap { self.indexPath(for: $0) }.sorted()
    }
    
    func displayingItems() -> [NSCollectionViewItem] {
        let visibleItems = self.visibleItems()
        let visibleRect = self.visibleRect
        return visibleItems.filter { NSIntersectsRect($0.view.frame, visibleRect) }
    }
}

#endif
