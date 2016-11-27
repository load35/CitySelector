//
//  CountriesTableViewController.swift
//  CitySelector
//
//  Created by Rusalyow Kirill on 27.11.16.
//  Copyright © 2016 Rusalyow Kirill. All rights reserved.
//
//

import UIKit

class CountriesTableViewController: ExpandableTableViewController {
    
    private lazy var countryProvider: CountryDataProviding = CountryDataProvider()
}

// MARK: - View controller view's lifecycle
extension CountriesTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

// MARK: ExpandableTableViewController
extension CountriesTableViewController {
    
    override func parentCellReuseIdentifier() -> String {
        return "Country cell identifier"
    }
    
    override func cellChildReuseIdentifier() -> String {
        return "City cell identifier"
    }
    
    override func childNumberOfParent(item: AnyObject) -> Int {
        guard let country = item as? CountryRepresenting else { return 0 }
        return country.cities.count
    }
    
    override func childOfParent(item: AnyObject, index: Int) -> AnyObject? {
        guard let country = item as? CountryRepresenting else { return 0 }
        return country.cities[index]
    }
    
}

// MARK: - Data Providing
extension CountriesTableViewController {
    
    override func createDataProvider() -> ListDataProviding {
        return countryProvider
    }
    
    override func configureCell(cell: UITableViewCell, withItem item: AnyObject) {
        if let country = item as? CountryRepresenting {
            let countryCell = cell as! CountryTableViewCell
            countryCell.country = country
        }
        
        if let city = item as? CityRepresenting {
            let cityCell = cell as! CityTableViewCell
            cityCell.city = city
            cityCell.favoriteClick = {                
                city.isFavorite = !city.isFavorite
                self.tableView.reloadData()
            }
            cityCell.cellSelected = (city == countryProvider.selectedCity)
            cityCell.setSelected(city == countryProvider.selectedCity, animated: false)
        }
    }
    
    override func cellDidSelected(item: AnyObject) {
        if let city = item as? CityRepresenting {
            countryProvider.selectedCity = city
            self.tableView.reloadData()
        }
    }
    
}
