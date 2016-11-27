//
//  Country+Representing.swift
//  CitySelector
//
//  Created by Rusalyow Kirill on 27.11.16.
//  Copyright © 2016 Rusalyow Kirill. All rights reserved.
//
//

import Foundation

extension Country: CountryRepresenting {
    
    var id: Int { return mIdentifier!.integerValue }
    var name: String! { return mName }
    var imageUrl: NSURL? { return mPictureUrlString != nil ? NSURL(string: mPictureUrlString!) : nil }
    
    var cities: [CityRepresenting] { return Array(relCities as! Set<City>) }
}
