//
//  ExpandableTableViewController.swift
//  CitySelector
//
//  Created by Rusalyow Kirill on 27.11.16.
//  Copyright © 2016 Rusalyow Kirill. All rights reserved.
//
//

import UIKit

private enum State {
    case Collapsed
    case Expanded
}

private struct Parent {
    var state: State = .Collapsed
    var item: AnyObject
    var childs: [AnyObject] = []
    
    init(item: AnyObject) {
        self.item = item
    }
}

class ExpandableTableViewController: DataProviderTableViewController {
    
    private var totalRows: Int {
        let total = parentItems.count
        let childs = parentItems.filter{ $0.state == .Expanded }.reduce(0, combine: {$0 + $1.childs.count } )
        return total + childs
    }
    
    private var parentItems: [Parent] = []
}

// MARK: - View controller view's lifecycle
extension ExpandableTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadRowsInTable()
    }
    
}

extension ExpandableTableViewController {

    func childNumberOfParent(item: AnyObject) -> Int {
        fatalError("This method must be overridden")
    }
    
    func childOfParent(item: AnyObject, index: Int) -> AnyObject? {
        fatalError("This method must be overridden")
    }
    
    func parentCellReuseIdentifier() -> String {
        fatalError("This method must be overridden")
    }
    
    func cellChildReuseIdentifier() -> String {
        fatalError("This method must be overridden")
    }
    
    func cellDidSelected(item: AnyObject) {
    }

}

// Mark: Private
extension ExpandableTableViewController {
    
    private func findItemAtIndex(index : Int) -> (item: AnyObject, isParent: Bool, actualIndex: Int)? {
        var currentIndex = 0
        for parentIndex in 0..<parentItems.count {
            let parentItem = parentItems[parentIndex]
            if index == currentIndex {
                return (parentItem.item, true, parentIndex)
            }
            currentIndex += 1
            if parentItem.state == .Expanded {
                for childIndex in 0..<parentItem.childs.count {
                    if index == currentIndex {
                        return (parentItem.childs[childIndex], false, childIndex)
                    }
                    currentIndex += 1
                }
            }
        }
        return nil
    }
    
    private func reloadRowsInTable() {
        parentItems.removeAll()
        for index in 0..<dataProvider.numberOfObjects {
            parentItems.append(Parent(item: dataProvider.objectAtIndex(index)))
        }
    }
    
    private func reloadChilds(inout parent: Parent) {
        parent.childs.removeAll()
        for index in 0..<childNumberOfParent(parent.item) {
            if let item = childOfParent(parent.item, index: index) {                
                parent.childs.append(item)
            }
        }
    }
    
    private func expandItemAtIndex(index : Int, parent: Int) {
        reloadChilds(&parentItems[parent])
        let currentSubItems = parentItems[parent].childs
        parentItems[parent].state = .Expanded
        var insertPos = index + 1
        
        let indexPaths = (0..<currentSubItems.count).map { _ -> NSIndexPath in
            let indexPath = NSIndexPath(forRow: insertPos, inSection: 0)
            insertPos += 1
            return indexPath
        }
        self.tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Fade)
    }
 
    private func collapseSubItemsAtIndex(index : Int, parent: Int) {
        var indexPaths = [NSIndexPath]()
        let numberOfChilds = parentItems[parent].childs.count
        parentItems[parent].state = .Collapsed
        guard index + 1 <= index + numberOfChilds else { return }
        indexPaths = (index + 1...index + numberOfChilds).map { NSIndexPath(forRow: $0, inSection: 0)}
        self.tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Fade)
    }
    
    private func updateCells(parent: Int, index: Int) {
        
        switch (parentItems[parent].state) {
        case .Expanded:
            collapseSubItemsAtIndex(index, parent: parent)
        case .Collapsed:
            expandItemAtIndex(index, parent: parent)
        }
    }
}

// Mark: TableViewController
extension ExpandableTableViewController {
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return totalRows
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : UITableViewCell!
        
        if let (item, isParent, actualPosition) = findItemAtIndex(indexPath.row) {
            if isParent {
                cell = tableView.dequeueReusableCellWithIdentifier(parentCellReuseIdentifier(), forIndexPath: indexPath)
                configureCell(cell, withItem: item)
            }
            else {
                cell = tableView.dequeueReusableCellWithIdentifier(cellChildReuseIdentifier(), forIndexPath: indexPath)
                configureCell(cell, withItem: item)
            }
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        guard let (item, isParent, actualPosition) = findItemAtIndex(indexPath.row) else { return }
        
        if isParent {
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            self.tableView.beginUpdates()
            self.updateCells(actualPosition, index: indexPath.row)
            self.tableView.endUpdates()
        }
        else {
            cellDidSelected(item)
        }
    }
    
}

// MARK: - ListDataProviderDelegate
extension ExpandableTableViewController {
    
    override func listDataProviderReloadData(listDataProvider: ListDataProviding) {
        self.tableView.reloadData()
    }
    
    override func listDataProviderWillBeginChanges(listDataProvider: ListDataProviding) {
        //NOTHING
    }
    
    override func listDataProvider(dataProvider: ListDataProviding, didChangeObjectAtIndex index: NSNumber?, forChangeType type: ListDataProviderChangeType, newIndex: NSNumber?) {
        //NOTHING
    }
    
    override func listDataProviderDidEndChanges(dataProvider: ListDataProviding) {
        //NOTHING
        reloadRowsInTable()
        self.tableView.reloadData()
    }
    
}
