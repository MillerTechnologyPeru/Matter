//
//  CXXSupport.swift
//  
//
//  Created by Alsey Coleman Miller on 6/10/22.
//

import Foundation
@_implementationOnly import CMatter

// MARK: - String

internal extension String {
    
    init(cxxString: std.string) {
        self.init(cString: cxxString.c_str())
    }

    func toCXX() -> std.string {
        var cxxString = std.string.init()
        cxxString.reserve(self.utf8.count)
        self.withCString { cString -> Void in
            cxxString.append(cString)
        }
        return cxxString
    }
}
