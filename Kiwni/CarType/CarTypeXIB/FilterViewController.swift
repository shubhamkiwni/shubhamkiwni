//
//  FilterViewController.swift
//  Kiwni_User_App
//
//  Created by Shubham Shinde on 22/02/22.
//

import UIKit
import DropDown


class FilterViewController: UITableViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var brandCollectionView: UICollectionView!
    @IBOutlet weak var brandView: UIView!
    
    @IBOutlet weak var segmentView: UIView!
    @IBOutlet weak var segmentLabel: UILabel!
    @IBOutlet weak var segmentTypesView: UIView!
    @IBOutlet weak var premiumButton: UIButton!
    @IBOutlet weak var luxuryButton: UIButton!
    @IBOutlet weak var ultraLuxuryButton: UIButton!
    @IBOutlet weak var modelListButton: UIButton!
    @IBOutlet weak var specialRequestView: UIView!
    @IBOutlet weak var specialRequestLabel: UILabel!
    @IBOutlet weak var specialRequestList: UIView!
    @IBOutlet weak var filterLabel: UILabel!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var modelRegisteredYearLabel: UILabel!
    @IBOutlet weak var wheelChairAssistantLabel: UILabel!
    @IBOutlet weak var babyCarChairLabel: UILabel!
    @IBOutlet weak var safetyBodyGuardLabel: UILabel!
    @IBOutlet weak var vehicalWithCarriedLabel: UILabel!
    
    let footerView = UIView()
    let button = UIButton()
    let dropDown = DropDown()
    var brandImageArray = ["Audilogo", "hondalogo", "marutisuzukilogo", "mercedesbenzlogo", "toyotalogo", "volkswagenlogo", "Audilogo", "hondalogo", "marutisuzukilogo", "mercedesbenzlogo", "toyotalogo", "volkswagenlogo"]
    var brandLabelArray = ["Audi", "Honda", "Maruti Suzuki", "Mercedes Benz", "Toyota", "Volkswagen", "Audi", "Honda", "Maruti Suzuki", "Mercedes Benz", "Toyota", "Volkswagen"]
    var modelArray = ["2020", "2019", "2018", "2017", "2016", "2015"]
    override func viewDidLoad() {
        super.viewDidLoad()
        brandView.layer.cornerRadius = 10.0
        brandView.layer.borderWidth = 1.0
        brandView.layer.borderColor = UIColor.black.cgColor
        brandCollectionView.allowsMultipleSelection = true
        
        brandCollectionView.layer.borderWidth = 1.0
        brandCollectionView.layer.borderColor = UIColor.black.cgColor
        
        segmentView.layer.cornerRadius = 10.0
        segmentView.layer.borderWidth = 1.0
        brandView.layer.borderColor = UIColor.black.cgColor
        
        segmentTypesView.layer.borderWidth = 1.0
        segmentTypesView.layer.borderColor = UIColor.black.cgColor
        
        modelListButton.layer.cornerRadius = 5.0
        modelListButton.layer.borderColor = UIColor.black.cgColor
        modelListButton.layer.borderWidth = 1
        modelListButton.backgroundColor = .buttonBackgroundColor
        modelListButton.setTitleColor(.white, for: .normal)
        
        specialRequestView.layer.cornerRadius = 5.0
        specialRequestView.layer.borderColor = UIColor.black.cgColor
        specialRequestView.layer.borderWidth = 1
        
        specialRequestList.layer.borderWidth = 1.0
        specialRequestList.layer.borderColor = UIColor.black.cgColor
        
        button.addTarget(self, action: #selector(pressed), for: .touchUpInside)
        
        filterLabel.font = UIFont.fontStyle(15, .semiBold)
        brandLabel.font = UIFont.fontStyle(15, .regular)
        modelRegisteredYearLabel.font = UIFont.fontStyle(15, .regular)
        wheelChairAssistantLabel.font = UIFont.fontStyle(15, .regular)
        babyCarChairLabel.font = UIFont.fontStyle(15, .regular)
        safetyBodyGuardLabel.font = UIFont.fontStyle(15, .regular)
        vehicalWithCarriedLabel.font = UIFont.fontStyle(15, .regular)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        brandCollectionView.reloadData()
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func premiumButtonPressed(_ sender: UIButton) {
        
        if premiumButton.layer.cornerRadius != 10.0 {
            premiumButton.layer.cornerRadius = 10.0
            premiumButton.layer.masksToBounds = false
            premiumButton.layer.shadowColor = UIColor.black.cgColor
            premiumButton.layer.shadowOpacity = 0.5
            premiumButton.layer.shadowOffset = CGSize(width: -1, height: 1)
            premiumButton.layer.shadowRadius = 1
            
        } else {
            premiumButton.layer.cornerRadius = 0.0
            premiumButton.layer.masksToBounds = false
            premiumButton.layer.shadowColor = UIColor.clear.cgColor
            premiumButton.layer.shadowOpacity = 0.0
            premiumButton.layer.shadowOffset = CGSize(width: -1, height: 1)
            premiumButton.layer.shadowRadius = 0
        }
        
    }
    
    @IBAction func luxuryButtonPressed(_ sender: UIButton) {
        if luxuryButton.layer.cornerRadius != 10.0 {
            luxuryButton.layer.cornerRadius = 10.0
            luxuryButton.layer.masksToBounds = false
            luxuryButton.layer.shadowColor = UIColor.black.cgColor
            luxuryButton.layer.shadowOpacity = 0.5
            luxuryButton.layer.shadowOffset = CGSize(width: -1, height: 1)
            luxuryButton.layer.shadowRadius = 1
            
        } else {
            luxuryButton.layer.cornerRadius = 0.0
            luxuryButton.layer.masksToBounds = false
            luxuryButton.layer.shadowColor = UIColor.clear.cgColor
            luxuryButton.layer.shadowOpacity = 0.0
            luxuryButton.layer.shadowOffset = CGSize(width: -1, height: 1)
            luxuryButton.layer.shadowRadius = 0
        }
    }
    
    @IBAction func ultraLuxaryButtonPressed(_ sender: UIButton) {
        if ultraLuxuryButton.layer.cornerRadius != 10.0 {
            ultraLuxuryButton.layer.cornerRadius = 10.0
            ultraLuxuryButton.layer.masksToBounds = false
            ultraLuxuryButton.layer.shadowColor = UIColor.black.cgColor
            ultraLuxuryButton.layer.shadowOpacity = 0.5
            ultraLuxuryButton.layer.shadowOffset = CGSize(width: -1, height: 1)
            premiumButton.layer.shadowRadius = 1
            
        } else {
            ultraLuxuryButton.layer.cornerRadius = 0.0
            ultraLuxuryButton.layer.masksToBounds = false
            ultraLuxuryButton.layer.shadowColor = UIColor.clear.cgColor
            ultraLuxuryButton.layer.shadowOpacity = 0.0
            ultraLuxuryButton.layer.shadowOffset = CGSize(width: -1, height: 1)
            ultraLuxuryButton.layer.shadowRadius = 0
        }
    }
    
    @IBAction func modelListButtonPressed(_ sender: UIButton) {
        
        dropDown.dataSource = modelArray
        dropDown.anchorView = sender
        dropDown.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height) //6
        dropDown.show() //7
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in //8
            guard let _ = self else { return }
            sender.setTitle(item, for: .normal) //9
        }
        
    }
    
    @objc func pressed() {
        let fvc = storyboard?.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
        fvc.sortingLabel = "Filter"
        navigationController?.pushViewController(fvc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        footerView.backgroundColor = .clear
        footerView.frame = CGRect(x: 0, y: 10, width: self.tableView.frame.width, height: 100)
        
        button.frame = CGRect(x: 80, y: 10, width: self.tableView.frame.width - 150, height: 40)
        button.setTitle("Apply", for: .normal)
        button.titleLabel?.font = UIFont.fontStyle(15, .regular)
        button.backgroundColor = .buttonBackgroundColor
        button.setTitleColor( .white, for: .normal)
//        button.backgroundColor = .black
        button.layer.cornerRadius = 10.0
        
        footerView.addSubview(button)
        return footerView
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 80
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return brandImageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = brandCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! BrandCollectionViewCell
        cell.brandImage.image = UIImage(named: brandImageArray[indexPath.row])
        cell.brandLabel.text = brandLabelArray[indexPath.row]
        cell.brandLabel.font = UIFont.fontStyle(15, .regular)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 100, height: 100)
        
        //        let collectionwidth = collectionView.bounds.width
        //        return CGSize(width: collectionwidth/4 , height: collectionwidth/4)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = brandCollectionView.cellForItem(at: indexPath) as? BrandCollectionViewCell
        cell!.logoView.layer.masksToBounds = false
        cell!.logoView.layer.shadowColor = UIColor.black.cgColor
        cell!.logoView.layer.shadowOpacity = 0.5
        cell!.logoView.layer.shadowOffset = CGSize(width: -1, height: 1)
        cell!.logoView.layer.shadowRadius = 1
        cell!.logoView.layer.cornerRadius = 10.0
        print("click")
    }
    
}
