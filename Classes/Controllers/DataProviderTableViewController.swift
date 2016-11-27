//
//  DataProviderTableViewController.swift
//  CitySelector
//
//  Created by Rusalyow Kirill on 27.11.16.
//  Copyright © 2016 Rusalyow Kirill. All rights reserved.
//
//

import UIKit

class DataProviderTableViewController: UITableViewController {
    
    private(set) var dataProvider: ListDataProviding!
}

// MARK: - View controller view's lifecycle
extension DataProviderTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataProvider = createDataProvider()
        dataProvider.delegate = self
        
        tableView.tableFooterView = UIView()
    }

}

// MARK: - Public API
extension DataProviderTableViewController {
    
    func objectAtIndexPath(indexPath: NSIndexPath) -> AnyObject {
        return dataProvider.objectAtIndex(indexPath.row)
    }
    
    func indexPathForObject(object: AnyObject) -> NSIndexPath? {
        let idx = dataProvider.indexOfObject(object)
        if idx == NSNotFound {
            return nil
        }
        return NSIndexPath(forRow: idx, inSection: 0)
    }
    
    func createDataProvider() -> ListDataProviding {
        fatalError("This method must be overridden")
    }
    
    func configureCell(cell: UITableViewCell, withItem item: AnyObject) {
        fatalError("This method must be overridden")
    }
    
    func cellReuseIdentifier() -> String {
        fatalError("This method must be overridden")
    }
    
}

// MARK: - Table view data source
extension DataProviderTableViewController {
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataProvider.numberOfObjects
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellReuseIdentifier(), forIndexPath: indexPath)
        configureCell(cell, withItem: objectAtIndexPath(indexPath))
        return cell
    }
    
}

// MARK: - Data provider delegate
extension DataProviderTableViewController: ListDataProviderDelegate {
    
    func listDataProviderReloadData(listDataProvider: ListDataProviding) {
        tableView.reloadData()
    }
    
    func listDataProviderWillBeginChanges(listDataProvider: ListDataProviding) {
        tableView.beginUpdates()
    }
    
    func listDataProvider(dataProvider: ListDataProviding,
                          didChangeObjectAtIndex index: NSNumber?,
                          forChangeType type: ListDataProviderChangeType,
                                        newIndex: NSNumber?) {
        let indexPath = index.map { NSIndexPath(forRow: $0.integerValue, inSection: 0) }
        let newIndexPath = newIndex.map { NSIndexPath(forRow: $0.integerValue, inSection: 0) }
        switch type {
        case .Insert:
            tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
        case .Delete:
            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
        case .Update:
            guard let cell = tableView.cellForRowAtIndexPath(indexPath!) else { break }
            configureCell(cell, withItem: objectAtIndexPath(indexPath!))
        case .Move:
            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
            tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
        }
    }
    
    func listDataProviderDidEndChanges(dataProvider: ListDataProviding) {
        tableView.endUpdates()
    }
    
}
