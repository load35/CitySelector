//
//  AppDelegate.swift
//  CitySelector
//
//  Created by Rusalyow Kirill on 27.11.16.
//  Copyright © 2016 Rusalyow Kirill. All rights reserved.
//
//

import UIKit
import RestKit
import MagicalRecord

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    lazy var updateManager = UpdateManager()

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        RKlcl_configure_by_name("RestKit/Network", RKlcl_vError.rawValue)
        RKlcl_configure_by_name("RestKit/ObjectMapping", RKlcl_vError.rawValue)
        
        // Configure RestKit's Core Data stack
        MagicalRecord.setupCoreDataStackWithAutoMigratingSqliteStoreNamed("Model")
        let objectStore = RKManagedObjectStore(persistentStoreCoordinator: NSPersistentStoreCoordinator.MR_defaultStoreCoordinator())
        objectStore.createManagedObjectContexts()
        RKManagedObjectStore.setDefaultStore(objectStore)
        NSPersistentStoreCoordinator.MR_setDefaultStoreCoordinator(objectStore.persistentStoreCoordinator)
        
        updateManager.updateEntitiesWithCompletion(nil)
        
        return true
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        updateManager.updateEntitiesWithCompletion(nil)
    }

}

