//
//  Representing.swift
//  CitySelector
//
//  Created by Rusalyow Kirill on 27.11.16.
//  Copyright © 2016 Rusalyow Kirill. All rights reserved.
//
//

import Foundation

@objc protocol Representing: class {
    
    var id: Int { get }
}

func == <T: Representing>(lhs: T?, rhs: T?) -> Bool {
    return lhs?.id == rhs?.id
}

func != <T: Representing>(lhs: T?, rhs: T?) -> Bool {
    return lhs?.id != rhs?.id
}

class HashableRepresenter: Hashable {
    
    var object: Representing
    var hashValue: Int { return object.id }
    
    init(object: Representing) {
        self.object = object
    }
}

func == (lhs: HashableRepresenter, rhs: HashableRepresenter) -> Bool {
    return lhs.object == rhs.object
}
