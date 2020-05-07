//
//  SearchViewController.swift
//  Auto Direct
//
//  Created by User on 4/6/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import UIKit

class SearchViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    @IBOutlet weak var collectionBrands: UICollectionView!
    @IBOutlet weak var collectionTrending: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let brands = ["Audi", "BMW", "Honda", "Jeep", "Mazda", "Benz", "MG", "Mini", "Nissan", "Peugeot", "Subaru", "Suzuki", "Toyota", "Volkswagen"]
    
    let trending = ["Nissan Juke", "Suzuki Vitara", "Toyota Raize", "Volkswagen T-Cross", "Honda Civic"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        searchBarBtn.image = UIImage(named: "condition")!.roundedImageWithBorder(width: 20, color: UIColor.green)
//        searchBarBtn.selectedImage = UIImage(named: "condition")!.roundedImageWithBorder(width: 20, color: UIColor.green)
        
        self.navigationItem.rightBarButtonItem  = setCloseButton()
        self.navigationItem.leftBarButtonItem = nil
                
        self.navigationItem.title = "Search Vehicles"
        
        collectionBrands.delegate = self
        collectionBrands.dataSource = self
        collectionTrending.delegate = self
        collectionTrending.dataSource = self
        searchBar.delegate = self
                
        searchBar.barTintColor = UIColor(rgb: 0x1b1f2a)
        
        searchBar.searchTextField.textColor = UIColor.blue
        searchBar.searchTextField.backgroundColor = UIColor.white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        collectionBrands.reloadData()
        collectionTrending.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
//        self.tabBarController?.tabBar.isHidden = false
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView.accessibilityIdentifier == "trendingCollection") {
            return self.trending.count
        } else {
            return self.brands.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView.accessibilityIdentifier == "trendingCollection") {
            let cell = collectionTrending.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as! SearchCollectionViewCell
            cell.lblText.text = self.trending[indexPath.row]
            return cell
        } else {
            let cell = collectionTrending.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as! SearchCollectionViewCell
            cell.lblText.text = self.brands[indexPath.row]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.view.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        performSegue(withIdentifier: "searchResultSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "searchResultSegue") {
            let vehicleCategory = segue.destination as! VehicleCategoryViewController
            vehicleCategory.setItemId(id: 5)
        }
    }
}

