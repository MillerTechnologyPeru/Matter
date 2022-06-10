//
//  CXXSupport.swift
//  
//
//  Created by Alsey Coleman Miller on 6/10/22.
//

@_implementationOnly import CMatter

// MARK: - String

internal extension std.string {
    
    init(_ string: String) {
        self.init()
        string.withCString { cString -> Void in
            self.append(cString)
        }
    }
}

internal extension String {
    
    init(cxxString: std.string) {
        self.init(cString: cxxString.c_str())
    }
}
