//
//  SidebarViewController.swift
//  Auto Direct
//
//  Created by User on 4/5/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import UIKit

protocol SidebarInventoryDelegate {
    func inventorySelected()
}

class SidebarViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var containerSidebarView: UIView!
    @IBOutlet weak var leadingSpace: NSLayoutConstraint!
    
    private let sidebarItemTableViewCell: String
    private let sidebarItemTableViewHeaderCell: String
    private let sidebarItemTableViewFooterCell: String
    private let sidebarItemsList: SidebarItemsList
    
    private let headerSectionHight: CGFloat
    private let footerSectionHeight: CGFloat
    
    var sidebarInventoryDelegate: SidebarInventoryDelegate!
    
    required init?(coder aDecoder: NSCoder) {
        sidebarItemTableViewCell = "SidebarItemTableViewCell"
        sidebarItemTableViewHeaderCell = "SidebarItemTableViewHeaderCell"
        sidebarItemTableViewFooterCell = "SidebarItemTableViewFooterCell"
        headerSectionHight = 55
        footerSectionHeight = 1
        sidebarItemsList = SidebarItemsList()
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.alwaysBounceVertical = false
        tableView.separatorStyle = .none
        
//        tableView.estimatedRowHeight = 44
//        tableView.rowHeight = UITableView.automaticDimension
        
        self.leadingSpace.constant = self.view.bounds.width/4.4
        self.view.backgroundColor = UIColor(rgb: 0x1b1f2a)
//        self.leadingSpace.constant = 0
        
        tableView.register(UINib(nibName: sidebarItemTableViewCell, bundle: nil), forCellReuseIdentifier: sidebarItemTableViewCell)
        tableView.register(UINib(nibName: sidebarItemTableViewHeaderCell, bundle: nil), forCellReuseIdentifier: sidebarItemTableViewHeaderCell)
        tableView.register(UINib(nibName: sidebarItemTableViewFooterCell, bundle: nil), forCellReuseIdentifier: sidebarItemTableViewFooterCell)
        tableView.alwaysBounceVertical = false
        
        containerSidebarView.translatesAutoresizingMaskIntoConstraints = false
//        if UIDevice().userInterfaceIdiom == .phone {
//            switch UIScreen.main.nativeBounds.height {
//                case 1136:
//                    print("iPhone 5 or 5S or 5C")
//                    NSLayoutConstraint.activate([
//                        containerSidebarView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 90)
//                    ])
//                case 1334:
//                    print("iPhone 6/6S/7/8")
//                    NSLayoutConstraint.activate([
//                        containerSidebarView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 90)
//                    ])
//                case 1920:
//                    print("iPhone 6+/6S+/7+")
//                    NSLayoutConstraint.activate([
//                        containerSidebarView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 90)
//                    ])
//                case 2208:
//                    print("iPhone 8+")
//                    NSLayoutConstraint.activate([
//                        containerSidebarView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 115)
//                    ])
//                case 2436:
//                    print("iPhone X/XS/11 Pro")
//                    NSLayoutConstraint.activate([
//                        containerSidebarView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 90)
//                    ])
//                case 2688:
//                    print("iPhone XS Max/11 Pro Max")
//                    NSLayoutConstraint.activate([
//                        containerSidebarView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 115)
//                    ])
//                case 1792:
//                    print("iPhone XR/ 11 ")
//                    NSLayoutConstraint.activate([
//                        containerSidebarView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 115)
//                    ])
//                default:
//                    print("Unknown")
//                    NSLayoutConstraint.activate([
//                        containerSidebarView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 115)
//                    ])
//            }
//        } else {
//            NSLayoutConstraint.activate([
//                containerSidebarView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 550)
//            ])
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sidebarItemsList.getItemsList()[section].getSubItems().count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        print(sidebarItemsList.getItemsList().count)
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
        let viewFooter = UIView()
        if section != 2 {
            viewFooter.backgroundColor = .gray
            return viewFooter
        } else {
            return nil
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 40
        } else {
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: sidebarItemTableViewCell, for: indexPath) as! SidebarItemTableViewCell
        if (indexPath.section == 0) {
            cell.lblItemName.textColor = .white
        }
        cell.lblItemDescription.isHidden = true
        var subItemName = sidebarItemsList.getItemsList()[indexPath.section].getSubItems()[indexPath.row].getSubItemName()
        subItemName.remove(at: subItemName.startIndex)
        cell.lblItemName.text = subItemName
        cell.selectionStyle = .none
        if sidebarItemsList.getItemsList()[indexPath.section].getSubItems()[indexPath.row].getSubItemDescription() != nil {
            cell.lblItemDescription.text = sidebarItemsList.getItemsList()[indexPath.section].getSubItems()[indexPath.row].getSubItemDescription()
            cell.lblItemDescription.isHidden = false
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.section)
        print(indexPath.row)
        if (indexPath.section == 0) {
            var navigationViewController = UINavigationController()
            
            if (indexPath.row == 0) {
                navigationViewController = self.storyboard?.instantiateViewController(withIdentifier: "aboutUs") as! UINavigationController
                navigationViewController.modalPresentationStyle = .fullScreen
                self.present(navigationViewController, animated: true) {
                    self.sideMenuController?.hideMenu()
                }
            } else if (indexPath.row == 1) {
                navigationViewController = self.storyboard?.instantiateViewController(withIdentifier: "whatIsPcp") as! UINavigationController
                navigationViewController.modalPresentationStyle = .fullScreen
                self.present(navigationViewController, animated: true) {
                    self.sideMenuController?.hideMenu()
                }
            } else if (indexPath.row == 2) {
                NotificationCenter.default.post(name: .inventoryName, object: nil)
                self.sideMenuController?.hideMenu()
            } else if (indexPath.row == 3) {
//                navigationViewController = self.storyboard?.instantiateViewController(withIdentifier: "tradeYourVehicle") as! UINavigationController
                self.sendWhatsAppMsg()
                self.sideMenuController?.hideMenu()
            } else {
//                navigationViewController = self.storyboard?.instantiateViewController(withIdentifier: "ourDeliveries") as! UINavigationController
//                navigationViewController.modalPresentationStyle = .fullScreen
//                self.present(navigationViewController, animated: true) {
//                    self.sideMenuController?.hideMenu()
//                }
                UIApplication.shared.openURL(URL(string: "https://autodirect.lk/our-deliveries/")!)
                self.sideMenuController?.hideMenu()
            }
        }
    }
    
    private func sendWhatsAppMsg() {
        let urlString = "I would like to trade my vehicle. Please call me back."
        let urlStringEncoded = urlString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        let url  = NSURL(string: "https://wa.me/+94779033388?text=\(urlStringEncoded!)")

        if UIApplication.shared.canOpenURL(url! as URL) {
            UIApplication.shared.open(url! as URL, options: [:]) { (success) in
                if success {
                    print("WhatsApp accessed successfully")
                } else {
                    print("Error accessing WhatsApp")
                }
            }
        } else {
            print("can't open whatsapp")
        }
        print("Send whatsapp")
    }
}



extension Notification.Name {
    static let inventoryName = Notification.Name("inventory")
}
