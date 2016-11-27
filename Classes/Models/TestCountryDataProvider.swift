//
//  TestCountryDataProvider.swift
//  CitySelector
//
//  Created by Rusalyow Kirill on 27.11.16.
//  Copyright © 2016 Rusalyow Kirill. All rights reserved.
//
//

import UIKit

class TestCountryDataProvider: NSObject {
    
    weak var delegate: ListDataProviderDelegate?
    
    private let testData: [TestCountry] = {
        var result: [TestCountry] = []
        for index in 1...5 {
            result.append(TestCountry.createRandomCountry(index))
        }
        return result
    }()
}

extension TestCountryDataProvider: ListDataProviding {
    
    var numberOfObjects: Int {
        return testData.count
    }
    
    func updateData() {
        //NOTHING
    }
    
    func objectAtIndex(idx: Int) -> AnyObject {
        return testData[idx]
    }
    
    func indexOfObject(object: AnyObject) -> Int {
        guard let country = object as? TestCountry else { return NSNotFound }
        return testData.indexOf(country) ?? NSNotFound
    }
}
