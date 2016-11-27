//
//  ListDataProviding+CoreData.swift
//  CitySelector
//
//  Created by Rusalyow Kirill on 27.11.16.
//  Copyright © 2016 Rusalyow Kirill. All rights reserved.
//
//

import Foundation
import CoreData

extension NSFetchedResultsChangeType {
    
    var listDataProviderChangeType: ListDataProviderChangeType {
        switch self {
        case .Update:
            return .Update
        case .Insert:
            return .Insert
        case .Delete:
            return .Delete
        case .Move:
            return .Move
        }
    }
    
}
