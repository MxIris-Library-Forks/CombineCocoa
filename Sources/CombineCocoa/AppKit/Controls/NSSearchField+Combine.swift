//
//  NSSearchField+.swift
//  CombTest
//
//  Created by Florian Zand on 27.05.22.
//

#if os(macOS)
import AppKit
import Combine

public extension CombineExtension where Base: NSSearchField {
    func didStartSearchingPublisher() -> AnyPublisher<NSSearchField, Never> {
        let selector = #selector(NSSearchFieldDelegate.searchFieldDidStartSearching(_:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { $0[0] as! NSSearchField }
            .eraseToAnyPublisher()
    }
    
    func didEndSearchingPublisher() -> AnyPublisher<NSSearchField, Never> {
        let selector = #selector(NSSearchFieldDelegate.searchFieldDidEndSearching(_:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { $0[1] as! NSSearchField }
            .eraseToAnyPublisher()
    }
    
    var delegateProxy: DelegateProxy {
        SearchFieldViewDelegateProxy.createDelegateProxy(for: base)
       }
    
    private class SearchFieldViewDelegateProxy: DelegateProxy, NSSearchFieldDelegate, DelegateProxyType {
        func setDelegate(to object: NSSearchField) {
            object.delegate = self
        }
    }
}

#endif
