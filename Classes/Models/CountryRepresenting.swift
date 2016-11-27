//
//  CountryRepresenting.swift
//  CitySelector
//
//  Created by Rusalyow Kirill on 27.11.16.
//  Copyright © 2016 Rusalyow Kirill. All rights reserved.
//
//

import Foundation

@objc protocol CountryRepresenting: Representing {
    
    var id: Int { get }
    var name: String! { get }
    var imageUrl: NSURL? { get }
    
    var cities: [CityRepresenting] { get }
    
}
