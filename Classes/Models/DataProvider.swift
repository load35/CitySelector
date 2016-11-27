//
//  DataProvider.swift
//  CitySelector
//
//  Created by Rusalyow Kirill on 27.11.16.
//  Copyright © 2016 Rusalyow Kirill. All rights reserved.
//
//

import UIKit
import CoreData
import RestKit

class DataProvider: NSObject {
    
    weak var delegate: ListDataProviderDelegate?
    
    /// Returns a number of objects.
    var numberOfObjects: Int {
        return fetchedResultsController.sections![0].numberOfObjects
    }
    
    /* Private */
    internal var fetchedResultsController: NSFetchedResultsController!
    internal let managedObjectContext: NSManagedObjectContext = RKManagedObjectStore.defaultStore().mainQueueManagedObjectContext
    
    func fetchRequest() -> NSFetchRequest {
        fatalError("Override me")
    }
    
    override init() {
        super.init()
        
        self.fetchedResultsController = NSFetchedResultsController(fetchRequest: self.fetchRequest(),
                                                                   managedObjectContext: managedObjectContext,
                                                                   sectionNameKeyPath: nil,
                                                                   cacheName: nil)
        self.fetchedResultsController.delegate = self
        try! self.fetchedResultsController.performFetch()
    }
}


extension DataProvider: ListDataProviding {
    
    func updateData() {
        
    }
    
    func objectAtIndex(idx: Int) -> AnyObject {
        return fetchedResultsController.objectAtIndexPath(NSIndexPath(forRow: idx, inSection: 0))
    }
    
    func indexOfObject(object: AnyObject) -> Int {
        return fetchedResultsController.indexPathForObject(object)?.row ?? NSNotFound
    }
}

// MARK: - Fetched results controller delegate
extension DataProvider: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        delegate?.listDataProviderWillBeginChanges(self)
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        delegate?.listDataProvider(
            self,
            didChangeObjectAtIndex: indexPath?.row,
            forChangeType: type.listDataProviderChangeType,
            newIndex: newIndexPath?.row
        )
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        delegate?.listDataProviderDidEndChanges(self)
    }
    
}
