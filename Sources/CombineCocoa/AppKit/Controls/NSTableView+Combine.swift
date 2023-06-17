//
//  NSTableView+.swift
//  CombTest
//
//  Created by Florian Zand on 27.05.22.
//

#if os(macOS)
import AppKit
import Combine

public extension CombineExtension where Base: NSTableView {
    func selectionDidChangePublisher() -> AnyPublisher<IndexSet, Never>  {
        NotificationCenter.default
            .publisher(for: NSTableView.selectionDidChangeNotification, object: base)
            .map( { ($0.object as! NSTableView).selectedRowIndexes } ).eraseToAnyPublisher()
    }
}

#endif
