//
//  NSCollectionView.swift
//  CombTest
//
//  Created by Florian Zand on 27.05.22.
//

#if os(macOS)
import AppKit
import Combine

public extension CombineExtension where Base: NSCollectionView {
    func displayingIndexPathsPublisher() -> AnyPublisher<([IndexPath]), Never>? {
        base.enclosingScrollView?.combine.contentOffsetPublisher().map{_ in base.displayingIndexPaths()}
        .removeDuplicates()
        .eraseToAnyPublisher()
    }
    
    func didSelectItemsAtPublisher() -> AnyPublisher<[IndexPath], Never> {
        let selector = #selector(NSCollectionViewDelegate.collectionView(_:didSelectItemsAt:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { return ($0[1] as? NSSet)?.allObjects as? [IndexPath] }
            .replaceNil(with: [])
            .removeDuplicates()
            .eraseToAnyPublisher()
    }
    
    func didDeselectItemsAtPublisher() -> AnyPublisher<[IndexPath], Never> {
        let selector = #selector(NSCollectionViewDelegate.collectionView(_:didDeselectItemsAt:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { return ($0[1] as? NSSet)?.allObjects as? [IndexPath] }
            .replaceNil(with: [])
            .removeDuplicates()
            .eraseToAnyPublisher()
    }
    
    func willDisplayItemPublisher() -> AnyPublisher<(NSCollectionViewItem, IndexPath), Never> {
        let selector = #selector(NSCollectionViewDelegate.collectionView(_:willDisplay:forRepresentedObjectAt:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { return ($0[1] as! NSCollectionViewItem, $0[2] as! IndexPath) }
            .eraseToAnyPublisher()
    }
    
    func didEndDisplayingItemPublisher() -> AnyPublisher<(NSCollectionViewItem, IndexPath), Never> {
        let selector = #selector(NSCollectionViewDelegate.collectionView(_:didEndDisplaying:forRepresentedObjectAt:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { return ($0[1] as! NSCollectionViewItem, $0[2] as! IndexPath) }
            .eraseToAnyPublisher()
    }
    
    var selectionIndexes: BindingSink<Base, IndexSet> {
        BindingSink(owner: base) { $0.selectionIndexes = $1 }
    }
    
    var collectionViewLayout: BindingSink<Base, NSCollectionViewLayout?> {
        BindingSink(owner: base) { $0.collectionViewLayout = $1 }
    }
    
    var allowsEmptySelection: BindingSink<Base, Bool> {
        BindingSink(owner: base) { $0.allowsEmptySelection = $1 }
    }
    
    var allowsMultipleSelection: BindingSink<Base, Bool> {
        BindingSink(owner: base) { $0.allowsMultipleSelection = $1 }
    }
    
    var isSelectable: BindingSink<Base, Bool> {
        BindingSink(owner: base) { $0.isSelectable = $1 }
    }
    
    var backgroundColors: BindingSink<Base, [NSColor]> {
        BindingSink(owner: base) { $0.backgroundColors = $1 }
    }
    
    var backgroundView: BindingSink<Base, NSView?> {
        BindingSink(owner: base) { $0.backgroundView = $1 }
    }
    
   private var delegateProxy: DelegateProxy {
        CollectionViewDelegateProxy.createDelegateProxy(for: base)
    }
    
    private class CollectionViewDelegateProxy: DelegateProxy, NSCollectionViewDelegate, DelegateProxyType {
        func setDelegate(to object: NSCollectionView) {
            object.delegate = self
        }
    }
}

#endif
