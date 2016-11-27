//
//  TestCity.swift
//  CitySelector
//
//  Created by Rusalyow Kirill on 27.11.16.
//  Copyright © 2016 Rusalyow Kirill. All rights reserved.
//
//

import UIKit

class TestCity: NSObject, CityRepresenting {
    
    var id: Int
    var name: String!
    var imageUrl: NSURL?
    
    var country: CountryRepresenting!
    
    var isFavorite: Bool = false
    
    init(id: Int, name: String, imageUrl: NSURL?) {
        self.id = id
        self.name = name
        self.imageUrl = imageUrl
    }
}
