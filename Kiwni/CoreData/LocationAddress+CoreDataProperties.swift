//
//  LocationAddress+CoreDataProperties.swift
//  
//
//  Created by Shubham Shinde on 13/06/22.
//
//

import Foundation
import CoreData


extension LocationAddress {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LocationAddress> {
        return NSFetchRequest<LocationAddress>(entityName: "LocationAddress")
    }

    @NSManaged public var addressLat: String?
    @NSManaged public var addressLong: String?
    @NSManaged public var addressType: String?
    @NSManaged public var addressValue: String?

}
