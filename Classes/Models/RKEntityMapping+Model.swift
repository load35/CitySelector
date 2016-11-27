//
//  RKEntityMapping+Model.swift
//  CitySelector
//
//  Created by Rusalyow Kirill on 27.11.16.
//  Copyright © 2016 Rusalyow Kirill. All rights reserved.
//
//
import Foundation
import RestKit

extension RKEntityMapping {
    
    class func countryMapping(managedObjectStore: RKManagedObjectStore) -> RKEntityMapping {
        
        let mapping = RKEntityMapping(forEntityForName: "Country", inManagedObjectStore: managedObjectStore)
        
        mapping.addAttributeMappingsFromDictionary(
            [
                "Id" : "mIdentifier",
                "Name" : "mName",
                "ImageLink" : "mPictureUrlString"
            ]
        )
        mapping.identificationAttributes = ["mIdentifier"]
        mapping.assignsDefaultValueForMissingAttributes = true
        mapping.assignsNilForMissingRelationships = true
        
        return mapping
    }
    
    class func cityMapping(managedObjectStore: RKManagedObjectStore) -> RKEntityMapping {
        
        let mapping = RKEntityMapping(forEntityForName: "City", inManagedObjectStore: managedObjectStore)
        
        mapping.addAttributeMappingsFromDictionary(
            [
                "Id" : "mIdentifier",
                "Name" : "mName",
                "ImageLink" : "mPictureUrlString"
            ]
        )
        mapping.identificationAttributes = ["mIdentifier"]
        mapping.assignsDefaultValueForMissingAttributes = true
        mapping.assignsNilForMissingRelationships = true
        
        return mapping
    }
    
}
