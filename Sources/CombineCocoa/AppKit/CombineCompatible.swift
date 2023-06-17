//
//  CombineCompatible.swift
//  CombTest
//
//  Created by Florian Zand on 27.05.22.
//

import Foundation

public struct CombineExtension<Base> {
    public let base: Base
 
  fileprivate init(_ base: Base) {
        self.base = base
    }
}

public protocol CombineCompatible {}

extension CombineCompatible {
    public static var combine: CombineExtension<Self>.Type {
        return CombineExtension<Self>.self
    }

    public var combine: CombineExtension<Self> {
        return CombineExtension<Self>(self)
    }
}

extension NSObject: CombineCompatible {}

/*
extension CombineExtension {
    public struct Publishers {
        public let base: Base
        fileprivate  init(_ base: Base) {
              self.base = base
          }
    }
    
    var publisher: Publishers {
        return Publishers(base)
    }
}
*/
