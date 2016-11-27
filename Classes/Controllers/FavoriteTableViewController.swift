//
//  FavoriteTableViewController.swift
//  CitySelector
//
//  Created by Rusalyow Kirill on 27.11.16.
//  Copyright © 2016 Rusalyow Kirill. All rights reserved.
//
//

import UIKit

class FavoriteTableViewController: DataProviderTableViewController {
    
    private lazy var countryProvider: ListDataProviding = FavoriteDataProvider()
}

// MARK: - View controller view's lifecycle
extension FavoriteTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension FavoriteTableViewController {
    
    override func createDataProvider() -> ListDataProviding {
        return countryProvider
    }
    
    override func configureCell(cell: UITableViewCell, withItem item: AnyObject) {
        let favoriteCell = cell as! FavoriteTableViewCell
        let city = item as! CityRepresenting
        favoriteCell.city = city
        favoriteCell.deleteClick = {
            city.isFavorite = !city.isFavorite
        }
    }
    
    override func cellReuseIdentifier() -> String {
        return "Favorite Cell Identifier"
    }
}
