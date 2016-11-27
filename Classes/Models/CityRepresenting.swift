//
//  CityRepresenting.swift
//  CitySelector
//
//  Created by Rusalyow Kirill on 27.11.16.
//  Copyright © 2016 Rusalyow Kirill. All rights reserved.
//
//

import Foundation

@objc protocol CityRepresenting: Representing {
    
    var id: Int { get }
    var name: String! { get }
    var imageUrl: NSURL? { get }
    
    var country: CountryRepresenting! { get }
    
    var isFavorite: Bool { get set }
    
}

