//
//  City+CityRepresenting.swift
//  CitySelector
//
//  Created by Rusalyow Kirill on 27.11.16.
//  Copyright © 2016 Rusalyow Kirill. All rights reserved.
//
//
import Foundation

extension City: CityRepresenting {
    
    var id: Int { return mIdentifier!.integerValue }
    var name: String! { return mName }
    var imageUrl: NSURL? { return mPictureUrlString != nil ? NSURL(string: mPictureUrlString!) : nil }
    
    var country: CountryRepresenting! { return relCountry as! CountryRepresenting }
    
    var isFavorite: Bool {
        get { return mFavorite!.boolValue }
        set {
            mFavorite = newValue
            self.managedObjectContext?.MR_saveToPersistentStoreWithCompletion(nil)
        }
    }
    
}
