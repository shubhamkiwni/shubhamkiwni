//
//  SafetyCompliancesXIB.swift
//  ViewCabsDesign
//
//  Created by Shubham Shinde on 11/02/22.
//

import Foundation
import UIKit

class SafetyCompliancesXIB: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    
    
    @IBOutlet weak var safetyView: UIView!
    
    @IBOutlet weak var safetyLabel: UILabel!
    @IBOutlet weak var safetyCollectionView: UICollectionView!
    
    
    
    var sfetyCompliancesArray = ["GPS Tracking", "OTP Pickup & Drops", "Tube Less Tier", "SOS Button", "Vaccination Driver", "First Aid Box", "Break Down", "Experience Driver", "Sharing Location", "GPS Speed Limit"]
    
    var safetyCompliancesImageArray = ["Gps", "OTP Pickup", "Tube Less Tier", "Sos", "Vaccination Driver", "First Aid Box", "Break Down", "Experience Driver", "Sharing Location", "GPS speed Limit"]
    
    override func awakeFromNib() {
        
        self.safetyCollectionView.register(UINib(nibName: "SafetyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        
        safetyCollectionView.delegate = self
        safetyCollectionView.dataSource = self
        
        CollectionViewDesignclass.collectionViewDesign(safetyCollectionView)
        CollectionViewDesignclass.viewDesign(safetyView, cornerRadius: 10.0, color: UIColor.black.cgColor, borderWidth: 1.0, maskCorner: [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner])
        
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sfetyCompliancesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = safetyCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SafetyCollectionViewCell
        cell.safetyLabel.text = sfetyCompliancesArray[indexPath.row]
        cell.safetyImageView.image = UIImage(named: safetyCompliancesImageArray[indexPath.row])
//        print(cell.frame.width, cell.frame.height)
//        print("SafetyCollectionView 1")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 140, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
