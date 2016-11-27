//
//  CountryDataProviding.swift
//  CitySelector
//
//  Created by Rusalyow Kirill on 27.11.16.
//  Copyright © 2016 Rusalyow Kirill. All rights reserved.
//
//

import Foundation

protocol CountryDataProviding: ListDataProviding {
    
    var selectedCity: CityRepresenting? { get set }
    
}
