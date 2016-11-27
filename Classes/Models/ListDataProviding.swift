//
//  ListDataProviding.swift
//  CitySelector
//
//  Created by Rusalyow Kirill on 27.11.16.
//  Copyright © 2016 Rusalyow Kirill. All rights reserved.
//
//

import Foundation

@objc protocol ListDataProviding: class {
    
    weak var delegate: ListDataProviderDelegate? { get set }
    
    var numberOfObjects: Int { get }
    
    func updateData()
    
    func objectAtIndex(idx: Int) -> AnyObject
    
    func indexOfObject(object: AnyObject) -> Int
    
}

@objc enum ListDataProviderChangeType: Int {
    
    case Insert
    case Delete
    case Move
    case Update
    
}

@objc protocol ListDataProviderDelegate {
    
    optional func listDataProviderReloadData(listDataProvider: ListDataProviding)
    
    func listDataProviderWillBeginChanges(listDataProvider: ListDataProviding)
    
    func listDataProvider(dataProvider: ListDataProviding, didChangeObjectAtIndex index: NSNumber?, forChangeType type: ListDataProviderChangeType, newIndex: NSNumber?)
    
    func listDataProviderDidEndChanges(dataProvider: ListDataProviding)
    
}
