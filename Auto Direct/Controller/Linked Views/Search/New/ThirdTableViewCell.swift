//
//  ThirdTableViewCell.swift
//  Auto Direct
//
//  Created by Wimukthi Rajapaksha on 7/31/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import UIKit

protocol ModelDelegate {
    func selectedModel(model: String)
}

class ThirdTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var modelsForSelectedMake: [String?]
    
    private var data: [String] = []
    var selectedIndex = [Int]()
    var modelDelegate: ModelDelegate!
    
    required init?(coder: NSCoder) {
        modelsForSelectedMake = []
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    public func setData(data: [String]) {
        self.data = data
//        collectionView.reloadData()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func setModelsForSelectedMake(modelsForSelectedMake: [String?]) {
        self.modelsForSelectedMake = modelsForSelectedMake
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ThirdCollectionViewCell", for: indexPath) as! ThirdCollectionViewCell
        cell.lbl.text = data[indexPath.row]
        if selectedIndex.contains(indexPath.row) {
            cell.lbl.isChecked = true
        } else {
            cell.lbl.isChecked = false
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex.removeAll()
        selectedIndex.append(indexPath.row)
        let cell = collectionView.cellForItem(at: indexPath) as! ThirdCollectionViewCell
        cell.lbl.isChecked = true
        modelDelegate.selectedModel(model: data[indexPath.row])
    }
        
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ThirdCollectionViewCell else {
            return
        }
        cell.lbl.isChecked = false
    }

}
