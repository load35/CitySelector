//
//  CityTableViewCell.swift
//  CitySelector
//
//  Created by Rusalyow Kirill on 27.11.16.
//  Copyright © 2016 Rusalyow Kirill. All rights reserved.
//
//

import UIKit

class CityTableViewCell: SelectableTableViewCell {
    
    @IBOutlet private weak var cityNameLabel: UILabel!
    @IBOutlet private weak var favoriteButton: UIButton!
    
    var cellSelected: Bool = false

    var favoriteClick: (()->())?
    
    var city: CityRepresenting! {
        didSet {
            cityNameLabel.text = city.name
            favoriteButton.selected = city.isFavorite
        }
    }
}

//Actions
extension CityTableViewCell {
    
    @IBAction func favoriteClick(sender: UIButton) {
        favoriteClick?()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        if selected == cellSelected {
            super.setSelected(selected, animated: animated)
        }
    }
    
}
