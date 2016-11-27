//
//  UpdateManager.swift
//  CitySelector
//
//  Created by Rusalyow Kirill on 27.11.16.
//  Copyright © 2016 Rusalyow Kirill. All rights reserved.
//
//

import UIKit
import RestKit

enum RestServerParameters {
    
    static let scheme = "https"
    
    static let host = "atw-backend.azurewebsites.net"
    
    static let apiPath = "/"
    
    static func serverURL() -> NSURL {
        let components = NSURLComponents()
        components.scheme = self.scheme
        components.host = self.host
        components.path = self.apiPath
        return components.URL!
    }
}

enum RestApiPath {
    static let Country = "api/countries"
}

class UpdateManager {
    
    private var countryObjectManager: RKObjectManager!

    func setupCountryManager() {
        countryObjectManager = RKObjectManager(baseURL: RestServerParameters.serverURL())
        countryObjectManager.managedObjectStore = RKManagedObjectStore.defaultStore()
        
        let cityMapping = RKEntityMapping.cityMapping(countryObjectManager.managedObjectStore)
        
        let countryMapping = RKEntityMapping.countryMapping(countryObjectManager.managedObjectStore)
        countryMapping.addPropertyMapping(RKRelationshipMapping(fromKeyPath: "Cities", toKeyPath: "relCities", withMapping: cityMapping))
        
        let statusCodes = RKStatusCodeIndexSetForClass(.Successful)
        let responseDescriptor = RKResponseDescriptor(mapping: countryMapping,
                                                      method: .Any,
                                                      pathPattern: nil,
                                                      keyPath: "Result",
                                                      statusCodes: statusCodes)
        
        countryObjectManager.addResponseDescriptor(responseDescriptor)
    }
    
    init() {
        setupCountryManager()
    }
    
    func updateEntitiesWithCompletion(completion: ((Bool!, NSError?) -> Void)?) {
        countryObjectManager.getObjectsAtPath(RestApiPath.Country,
                                              parameters: nil,
                                              success:
            { (operation, result) in
                completion?(true, nil)
                
        }) { (operation, error) in
            completion?(false, error)
        }
    }
}
