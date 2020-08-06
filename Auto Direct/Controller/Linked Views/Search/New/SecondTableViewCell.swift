//
//  SecondTableViewCell.swift
//  Auto Direct
//
//  Created by Wimukthi Rajapaksha on 7/31/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import UIKit

protocol MakeYearDelegate {
    func selectedMakeYear(makeModelYear: String, identifier: String)
}

class SecondTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var makeYearDelegate: MakeYearDelegate!
    
    private var data: [String?] = []
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    public func setData(data: [String], identifier: String) {
        self.data = data
        collectionView.accessibilityIdentifier = identifier
        collectionView.reloadData()
    }
    
    public func setCollectionIdentifier(identifier: String) {
        self.collectionView.accessibilityIdentifier = identifier
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SecondCollectionViewCell", for: indexPath) as! SecondCollectionViewCell
        cell.lbl.text = data[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        makeYearDelegate.selectedMakeYear(makeModelYear: data[indexPath.row]!, identifier: collectionView.accessibilityIdentifier!)
    }

}
