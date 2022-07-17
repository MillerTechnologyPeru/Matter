//
//  AppMain.swift
//  
//
//  Created by Alsey Coleman Miller on 7/17/22.
//

import Foundation
@_implementationOnly import CMatter

public func CHIPAppMain() {
    main_chip_app(CommandLine.argc, CommandLine.unsafeArgv)
}

public protocol MatterApp {
    
    static func main()
}

extension MatterApp {
    
    public static func main() {
        CHIPAppMain()
    }
}
