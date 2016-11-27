//
//  FavoriteTableViewCell.swift
//  CitySelector
//
//  Created by Rusalyow Kirill on 27.11.16.
//  Copyright © 2016 Rusalyow Kirill. All rights reserved.
//
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var cityNameLabel: UILabel!
    
    var deleteClick: (()->())?
    
    var city: CityRepresenting! {
        didSet {
            cityNameLabel.text = city.name
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

}

//Actions
extension FavoriteTableViewCell {
    
    @IBAction func deleteClick(sender: UIButton) {
        deleteClick?()
    }
    
}
