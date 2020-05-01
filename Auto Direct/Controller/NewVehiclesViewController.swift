//
//  NewVehiclesViewController.swift
//  Auto Direct
//
//  Created by User on 4/13/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import UIKit

class NewVehiclesViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var btnBack: UIBarButtonItem!
    @IBOutlet weak var barButtonRight: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var newVehiclesCollectionView: UICollectionView!
    @IBOutlet weak var viewSearchDetails: UIView!
    @IBOutlet weak var viewSearchOption: UIView!
    @IBOutlet weak var viewNewestFirst: UIView!
    @IBOutlet weak var lblSearchResultCount: UILabel!
    
    private let newVehiclesTableViewCell: String
    private let newVehiclesCollectionViewCell: String
    private let brandsList: [String]
    
    private var fromSearch: Bool
    
    required init?(coder aDecoder: NSCoder) {
        fromSearch = false
        newVehiclesTableViewCell = "NewVehiclesTableViewCell"
        newVehiclesCollectionViewCell = "NewVehiclesCollectionViewCell"
        brandsList = ["All", "p", "qqqqqqq", "r", "s", "tttttt", "u", "v", "w", "xxxxxxx", "y", "z", "p", "q", "r", "sssssss", "t", "uuuuuuuuuuuuuuuuuuuuuuuu", "v", "wwwwwwwwwwww", "xxxx", "yxxyyy", "zzzzzzz"]
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if fromSearch {
            newVehiclesCollectionView.isHidden = true
            viewSearchDetails.isHidden = false
        }
        
        viewSearchOption.layer.cornerRadius = viewSearchOption.frame.height / 2.0
        viewNewestFirst.layer.cornerRadius = viewNewestFirst.frame.height / 2.0
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: newVehiclesTableViewCell, bundle: nil), forCellReuseIdentifier: newVehiclesTableViewCell)
        
        newVehiclesCollectionView.delegate = self
        newVehiclesCollectionView.dataSource = self
        newVehiclesCollectionView.register(UINib(nibName: newVehiclesCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: newVehiclesCollectionViewCell)
        
        viewSearchOption.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.searchOption(_:))))
        viewSearchOption.isUserInteractionEnabled = true
        
        viewNewestFirst.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.newestFirst(_:))))
        viewNewestFirst.isUserInteractionEnabled = true
        
//        self.tabBarController?.tabBar.isHidden = false
        
        navigationItem.leftBarButtonItem = backBarButton()
        
        tableView.gradient(width: tableView.bounds.width, height: 30, colors: [UIColor(rgb: 0x0b0f0f).cgColor, UIColor(rgb: 0x1b1f2a).cgColor])
    }
    
    @objc func searchOption(_ gestureRecognizer: UITapGestureRecognizer) {
        performSegue(withIdentifier: "searchOptionsSegue", sender: self)
    }
    
    @objc func newestFirst(_ gestureRecognizer: UITapGestureRecognizer) {
        print("newest first")
    }
    
//    private func loadCardDetails() {
//        viewCarDetails.viewFeature1.imgFeature.image = UIImage(named: "petrol")
//        viewCarDetails.viewFeature1.lblFeature.text = "Petrol"
//        print(viewCarDetails.viewFeature1.bounds.width)
//
//        viewCarDetails.viewFeature2.imgFeature.image = UIImage(named: "engine")
//        viewCarDetails.viewFeature2.lblFeature.text = "1.3L"
//
//        viewCarDetails.viewFeature3.imgFeature.image = UIImage(named: "transmission")
//        viewCarDetails.viewFeature3.lblFeature.text = "Auto"
//
//        viewCarDetails.viewFeature4.imgFeature.image = UIImage(named: "year")
//        viewCarDetails.viewFeature4.lblFeature.text = "2019"
//
//        viewCarDetails.viewFeature5.imgFeature.image = UIImage(named: "readyToShipSk")
//        viewCarDetails.viewFeature5.lblFeature.text = "Ready to\nShip"
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
//    @objc func handleButton( sender : UIButton ) {
//        // It would be nice is isEnabled worked...
//        sender.alpha = sender.alpha == 1.0 ? 0.5 : 1.0
//    }
    
    @IBAction func onBackTouch(_ sender: Any) {
        self.navigationController?.popViewController(animated:true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: newVehiclesTableViewCell, for: indexPath) as! NewVehiclesTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "itemDescriptionSegue", sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return brandsList.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = newVehiclesCollectionView.dequeueReusableCell(withReuseIdentifier: newVehiclesCollectionViewCell, for: indexPath) as! NewVehiclesCollectionViewCell
        cell.lblItemName.text = brandsList[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("select \(indexPath.row)")
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print("deselect \(indexPath.row)")
    }
    
    public func setFromSearch(fromSearch: Bool) {
        self.fromSearch = fromSearch
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 100, height: collectionView.bounds.size.height)
//    }
}
