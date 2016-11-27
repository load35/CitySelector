//
//  TextCountry.swift
//  CitySelector
//
//  Created by Rusalyow Kirill on 27.11.16.
//  Copyright © 2016 Rusalyow Kirill. All rights reserved.
//
//

import UIKit

private extension String {
    
    private static func randomStringWithLength (len : Int) -> String {
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let randomString = NSMutableString(capacity: len)
        for _ in 0...len {
            let length = UInt32 (letters.length)
            let rand = arc4random_uniform(length)
            randomString.appendFormat("%C", letters.characterAtIndex(Int(rand)))
        }
        return randomString as String
    }
    
}

class TestCountry: NSObject, CountryRepresenting {
    
    var id: Int
    var name: String!
    var imageUrl: NSURL?
    
    var cities: [CityRepresenting] = []

    init(id: Int, name: String, imageUrl: NSURL?) {
        self.id = id
        self.name = name
        self.imageUrl = imageUrl
    }
    
}

// MARK: Create
extension TestCountry {
    
    class func createRandomCountry(id: Int) -> TestCountry {
        let countryName = String.randomStringWithLength(Int(arc4random_uniform(20)))
        let result = TestCountry(id: id, name: countryName, imageUrl: nil)
        for index in 1...Int(2 + arc4random_uniform(5)) {
            let cityName = String.randomStringWithLength(Int(arc4random_uniform(20)))
            let city = TestCity(id: Int(index), name: cityName, imageUrl: nil)
            city.country = result
            result.cities.append(city)
        }
        
        return result
    }
    
}
