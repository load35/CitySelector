//
//  Country+CoreDataProperties.swift
//  
//
//  CitySelector
//
//  Created by Rusalyow Kirill on 27.11.16.
//  Copyright © 2016 Rusalyow Kirill. All rights reserved.
//
//

import Foundation
import CoreData

extension Country {

    @NSManaged var mIdentifier: NSNumber?
    @NSManaged var mName: String?
    @NSManaged var mPictureUrlString: String?
    @NSManaged var relCities: NSSet?

}
