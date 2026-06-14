//
//  Entity+CoreDataProperties.swift
//  
//
//  Created by eightman on 2026/06/12.
//
//  This file was automatically generated and should not be edited.
//

public import Foundation
public import CoreData


public typealias EntityCoreDataPropertiesSet = NSSet

extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Entity")
    }

    @NSManaged public var aaa: Data?

}

extension Entity : Identifiable {

}
