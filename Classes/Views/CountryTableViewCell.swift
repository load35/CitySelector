//
//  CountryTableViewCell.swift
//  CitySelector
//
//  Created by Rusalyow Kirill on 27.11.16.
//  Copyright © 2016 Rusalyow Kirill. All rights reserved.
//
//

import UIKit

class CountryTableViewCell: UITableViewCell {
    
    var country: CountryRepresenting! {
        didSet {
            textLabel?.text = country.name
        }
    }

}
