//
//  DatabaseReference+Location.swift
//  RedPandaAssigment
//
//  Created by Arslan Ahmad on 29/10/2022.
//

import Foundation
import FirebaseDatabase

extension DatabaseReference {
    enum MGLocation {
        case root
        
        case product(nodeName:String, pid: String)
        case productTb(nodeName:String)
        
        func asDatabaseReference() -> DatabaseReference {
            let root = Database.database().reference()
            
            switch self {
            case .root:
                return root
                
            case .productTb(let nodeName):
                return root.child(nodeName)

            case .product(let nodeName, let pid):
                return root.child(nodeName).child(pid)
            }
        }
    }
    
    static func toLocation(_ location: MGLocation) -> DatabaseReference {
        return location.asDatabaseReference()
    }
}
