//
//  FavoriteDataProvider.swift
//  CitySelector
//
//  Created by Rusalyow Kirill on 27.11.16.
//  Copyright © 2016 Rusalyow Kirill. All rights reserved.
//
//

import UIKit
import CoreData
import RestKit

class FavoriteDataProvider: DataProvider {
    
    override func fetchRequest() -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: "City")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "mName", ascending: true)]
        fetchRequest.predicate = NSPredicate(format: "mFavorite == YES")
        return fetchRequest
    }
    
}
