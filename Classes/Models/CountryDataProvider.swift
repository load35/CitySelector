//
//  CountryDataProvider.swift
//  CitySelector
//
//  Created by Rusalyow Kirill on 27.11.16.
//  Copyright © 2016 Rusalyow Kirill. All rights reserved.
//
//

import UIKit
import CoreData
import RestKit


class CountryDataProvider: DataProvider, CountryDataProviding {
    
    private enum UserDefaultsKeys {
        static let selectedCity = "UserDefaultsKeys.selectedCity"
    }
    
    var selectedCity: CityRepresenting? {
        didSet {
            saveSelectedCity()
        }
    }
    
    override func fetchRequest() -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: "Country")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "mName", ascending: true)]
        fetchRequest.relationshipKeyPathsForPrefetching = ["relCity"]
        return fetchRequest
    }
    
    override init() {
        super.init()
        selectedCity = readSelectedCity()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(contextUpdated), name: NSManagedObjectContextDidSaveNotification, object: nil)
    }
}

//City Changes
extension CountryDataProvider {
    
    func contextUpdated(notification: NSNotification) {
        guard let context = notification.object as? NSManagedObjectContext where context == managedObjectContext else { return }
        
        let inserted = (notification.userInfo![NSInsertedObjectsKey] as? Set<NSManagedObject>)?.filter{ $0 is City } as? [City]
        let deleted = (notification.userInfo![NSDeletedObjectsKey] as? Set<NSManagedObject>)?.filter{ $0 is City } as? [City]
        let updated = (notification.userInfo![NSUpdatedObjectsKey] as? Set<NSManagedObject>)?.filter{ $0 is City } as? [City]
        
        if inserted?.count > 0 || deleted?.count > 0 || updated?.count > 0 {
            self.delegate?.listDataProviderReloadData?(self)
        }
    }
}

// SelectedCity local storage
extension CountryDataProvider {
    
    func saveSelectedCity() {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setInteger(selectedCity!.id, forKey: UserDefaultsKeys.selectedCity)
        userDefaults.synchronize()
    }
    
    func readSelectedCity() -> City? {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if let id = userDefaults.objectForKey(UserDefaultsKeys.selectedCity) as? Int {
            let predicate = NSPredicate(format: "mIdentifier == \(id)")
            let result = City.MR_findFirstWithPredicate(predicate, inContext: self.managedObjectContext)
            return result
        }
        return nil
    }
    
}
