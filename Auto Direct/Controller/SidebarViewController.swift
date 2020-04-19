//
//  SidebarViewController.swift
//  Auto Direct
//
//  Created by User on 4/5/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import UIKit

class SidebarViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    private let sidebarItemTableViewCell: String
    private let sidebarItemTableViewHeaderCell: String
    private let sidebarItemTableViewFooterCell: String
    private let sidebarItemsList: SidebarItemsList
    
    private let headerSectionHight: CGFloat
    private let footerSectionHeight: CGFloat
    
    required init?(coder aDecoder: NSCoder) {
        sidebarItemTableViewCell = "SidebarItemTableViewCell"
        sidebarItemTableViewHeaderCell = "SidebarItemTableViewHeaderCell"
        sidebarItemTableViewFooterCell = "SidebarItemTableViewFooterCell"
        headerSectionHight = 65
        footerSectionHeight = 10
        sidebarItemsList = SidebarItemsList()
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.alwaysBounceVertical = false
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: sidebarItemTableViewCell, bundle: nil), forCellReuseIdentifier: sidebarItemTableViewCell)
        
        tableView.register(UINib(nibName: sidebarItemTableViewHeaderCell, bundle: nil), forCellReuseIdentifier: sidebarItemTableViewHeaderCell)
        tableView.register(UINib(nibName: sidebarItemTableViewFooterCell, bundle: nil), forCellReuseIdentifier: sidebarItemTableViewFooterCell)
        tableView.alwaysBounceVertical = false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sidebarItemsList.getItemsList()[section].getSubItems().count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sidebarItemsList.getItemsList().count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerSectionHight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: sidebarItemTableViewHeaderCell) as! SidebarItemTableViewHeaderCell
        cell.lblHeader.text = sidebarItemsList.getItemsList()[section].getItemHeader()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return footerSectionHeight
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section != 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: sidebarItemTableViewFooterCell) as! SidebarItemTableViewFooterCell
            return cell
        }
        else {
            return UIView()
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: sidebarItemTableViewCell, for: indexPath) as! SidebarItemTableViewCell
        cell.lblItemName.text = sidebarItemsList.getItemsList()[indexPath.section].getSubItems()[indexPath.row].getSubItemName()
        if sidebarItemsList.getItemsList()[indexPath.section].getSubItems()[indexPath.row].getSubItemDescription() != nil {
            cell.lblItemDescription.text = sidebarItemsList.getItemsList()[indexPath.section].getSubItems()[indexPath.row].getSubItemDescription()
        } else {
            cell.lblItemDescription.isHidden = true
        }
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let sectionHeaderHeight: CGFloat = headerSectionHight
        if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
            scrollView.contentInset = UIEdgeInsets(top: -scrollView.contentOffset.y, left: 0, bottom: 0, right: 0);
        } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
            scrollView.contentInset = UIEdgeInsets(top: -sectionHeaderHeight, left: 0, bottom: 0, right: 0);
        }
    }

}
