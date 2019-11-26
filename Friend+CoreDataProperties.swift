//
//  Friend+CoreDataProperties.swift
//  FriendFace
//
//  Created by Mario Alberto Barragán Espinosa on 26/11/19.
//  Copyright © 2019 Mario Alberto Barragan Espinosa. All rights reserved.
//
//

import Foundation
import CoreData


extension Friend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Friend> {
        return NSFetchRequest<Friend>(entityName: "Friend")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var user: User?
    
    public var wrappedID: String {
        if let id = id {
            return id.uuidString
        }
        return ""
    }
    
    public var wrappedName: String {
        return name ?? ""
    }

}
