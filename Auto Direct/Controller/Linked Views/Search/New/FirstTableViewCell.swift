//
//  FirstTableViewCell.swift
//  Auto Direct
//
//  Created by Wimukthi Rajapaksha on 7/31/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import UIKit

protocol ConditionDelegate {
    func selectedCondition(condition: Int)
}

class FirstTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var conditionDelegate: ConditionDelegate!
    
    private var data: [String] = []
    var selectedIndex = [Int]()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    public func setData(data: [String]) {
        self.data = data
        collectionView.reloadData()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FirstCollectionViewCell", for: indexPath) as! FirstCollectionViewCell
        cell.lbl.text = data[indexPath.row]
        if selectedIndex.contains(indexPath.row) {
            cell.lbl.isChecked = true
        } else {
            cell.lbl.isChecked = false
        }
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return UICollectionViewFlowLayout.automaticSize
//    }
  
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex.removeAll()
        selectedIndex.append(indexPath.row)
        let cell = collectionView.cellForItem(at: indexPath) as! FirstCollectionViewCell
        cell.lbl.isChecked = true
        conditionDelegate.selectedCondition(condition: indexPath.row)
    }
        
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? FirstCollectionViewCell else {
            return
        }
        cell.lbl.isChecked = false
    }

}
