//
//  ReferenceConvertible.swift
//  
//
//  Created by Alsey Coleman Miller on 6/9/22.
//

/// Value types which are backed by a reference type.
internal protocol ReferenceConvertible {
    
    associatedtype ReferenceType : AnyObject
}

internal protocol Duplicatable: AnyObject {
    
    func copy() -> Self
}

internal final class MutableHandle<MutableType : Duplicatable> {
    
    fileprivate var _pointer : MutableType
    
    init(reference : __shared MutableType) {
        _pointer = reference.copy()
    }
    
    init(adoptingReference reference: MutableType) {
        _pointer = reference
    }
    
    /// Apply a closure to the reference type.
    func map<ReturnType>(_ whatToDo : (MutableType) throws -> ReturnType) rethrows -> ReturnType {
        return try whatToDo(_pointer)
    }
    
    func copiedReference() -> MutableType {
        return _pointer.copy()
    }
    
    func uncopiedReference() -> MutableType {
        return _pointer
    }
}

/// Describes common operations for reference types with value semantics, e.g. struct types that are bridged to a mutable object.
internal protocol MutableReferenceConvertible : ReferenceConvertible where ReferenceType: Duplicatable {
    
    var handle : MutableHandle<ReferenceType> { get set }
    
    /// Apply a mutating closure to the reference type, regardless if it is mutable or immutable.
    ///
    /// This function performs the correct copy-on-write check for efficient mutation.
    mutating func applyMutation<ReturnType>(_ whatToDo : (ReferenceType) -> ReturnType) -> ReturnType
}

extension MutableReferenceConvertible {
    
    @inline(__always)
    mutating func applyMutation<ReturnType>(_ whatToDo : (ReferenceType) -> ReturnType) -> ReturnType {
        // Only create a new box if we are not uniquely referenced
        if !isKnownUniquelyReferenced(&handle) {
            let ref = handle._pointer
            handle = MutableHandle(reference: ref)
        }
        return whatToDo(handle._pointer)
    }
}

internal protocol CXXReferenceConvertible: ReferenceConvertible where Self.ReferenceType: CXXReference {
    
}

internal protocol CXXReference: AnyObject {
    
    associatedtype CXXObject
    
    var cxxObject: CXXObject { get }
    
    init(_ cxxObject: CXXObject)
}
