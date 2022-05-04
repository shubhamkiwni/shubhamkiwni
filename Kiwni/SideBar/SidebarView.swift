//
//  Sidebar.swift
//  mySidebar2
//
//  Created by Muskan on 10/12/17.
//  Copyright © 2017 akhil. All rights reserved.
//

import Foundation
import UIKit

protocol SidebarViewDelegate: AnyObject {
    func sidebarDidSelectRow(row: Row)
}

enum Row: String {
    case editProfile
    case myRides
    case payment
    case offers
    case safety
    case faqs
    case feedback
    case shareApp
    case referEarn
    case support
    case about
    case none
    
    init(row: Int) {
        switch row {
        case 0: self = .editProfile
        case 1: self = .myRides
        case 2: self = .payment
        case 3: self = .offers
        case 4: self = .safety
        case 5: self = .faqs
        case 6: self = .feedback
        case 7: self = .shareApp
        case 8: self = .referEarn
        case 9: self = .support
        case 10: self = .about
        default: self = .none
        }
    }
}

class SidebarView: UIView, UITableViewDelegate, UITableViewDataSource {

    var titleArr = [String]()
    var imageArray = [UIImage]()
    var storeimage =  UIImage()
    
    weak var delegate: SidebarViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.clipsToBounds=true
        let name = UserDefaults.standard.string(forKey: "displayName") ?? ""
                
        titleArr = ["\(name)", "My Rides", "Payment", "Offers", "Safety", "FAQs", "Feedback", "Share App", "Refer & Earn", "Support", "About"]

       
        
        setupViews()
        
        
        myTableView.delegate=self
        myTableView.dataSource=self
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        myTableView.tableFooterView=UIView()
        myTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        myTableView.allowsSelection = true
        myTableView.bounces=false
        myTableView.showsVerticalScrollIndicator=false
        myTableView.backgroundColor = UIColor.clear
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        if indexPath.row == 0 {
            cell.backgroundColor = .systemGray2
            let cellImg: UIImageView!
            cellImg = UIImageView(frame: CGRect(x: 15, y: 25, width: 80, height: 80))
            cellImg.layer.cornerRadius = 40
            cellImg.layer.masksToBounds=true
            cellImg.contentMode = .scaleAspectFill
            cellImg.layer.masksToBounds=true
            let data = UserDefaults.standard.data(forKey: "KEY")
            if(data != nil){
                let decoded = try! PropertyListDecoder().decode(Data.self, from: data!)
                storeimage = UIImage(data: decoded)!
            }
            else{
                
            }
            
            DispatchQueue.main.async {
                cellImg.image = self.storeimage
            }
            cell.addSubview(cellImg)
            
            let cellLbl = UILabel(frame: CGRect(x: 110, y: cell.frame.height/2-15, width: 250, height: 30))
            cell.addSubview(cellLbl)
            cellLbl.text = titleArr[indexPath.row]
            cellLbl.font=UIFont.systemFont(ofSize: 17)
            cellLbl.textColor=UIColor.black
            
            let cellLbl2 = UILabel(frame: CGRect(x: 110, y: cell.frame.height/2-(-15), width: 200, height: 20))
            print(cell.frame.height/2+50)
            cell.addSubview(cellLbl2)
            cellLbl2.text = UserDefaults.standard.string(forKey: "phoneNumber")
            cellLbl2.font=UIFont.systemFont(ofSize: 15)
            cellLbl2.textColor=UIColor.black
        } else {
            
           
            
            let imgArray = ["","MyRide","Payment","Offers","Safety","faq","Feedback","Shareapp","Refer&Earn","Support","About"]
            
            let cellImg2: UIImageView!
            cellImg2 = UIImageView(frame: CGRect(x: 10, y: 9, width: 25, height: 25))
            cellImg2.layer.cornerRadius = 5
            cellImg2.layer.masksToBounds=true
            cellImg2.contentMode = .scaleAspectFill
            cellImg2.layer.masksToBounds=true
            cellImg2.image = UIImage(named: imgArray[indexPath.row])
            cell.addSubview(cellImg2)
            
            let cellLbl = UILabel(frame: CGRect(x: 50, y: 5, width: 100, height: 30))
            cell.addSubview(cellLbl)
            cellLbl.text = titleArr[indexPath.row]
            cellLbl.font=UIFont.systemFont(ofSize: 17)
            cellLbl.textColor=UIColor.black
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.sidebarDidSelectRow(row: Row(row: indexPath.row))
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 120
        } else {
            return 40
        }
    }
    
    func setupViews() {
        self.addSubview(myTableView)
        myTableView.topAnchor.constraint(equalTo: topAnchor).isActive=true
        myTableView.leftAnchor.constraint(equalTo: leftAnchor).isActive=true
        myTableView.rightAnchor.constraint(equalTo: rightAnchor).isActive=true
        myTableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive=true
    }
    
    let myTableView: UITableView = {
        let table=UITableView()
        table.translatesAutoresizingMaskIntoConstraints=false
        return table
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
