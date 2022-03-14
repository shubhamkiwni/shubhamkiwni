//
//  KiwniComfirtXIB.swift
//  Kiwni_User_App
//
//  Created by Shubham Shinde on 17/02/22.
//

import Foundation
import UIKit

class KiwniComfirtXIB: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var kiwniComfirtView: UIView!
    
    @IBOutlet weak var kiwniComfirtLabel: UILabel!
    @IBOutlet weak var kiwniComfirtCollectionView: UICollectionView!
    
    var kiwniComfirtArray = ["Umbrella", "Water Bottle", "Shoes Cleaner", "Laptop Charger", "WIFI", "Sanitizer", "Eyes Mask", "Mobile Charger", "News Paper", "Chocolate", "Notebook Pencil"]
    
    var kiwniComfirtImageArray = ["Umbrella", "Water Bottel", "Shoes Cleaner", "Laptop Charger", "WIFI", "Sanitizer", "Eyes Mask", "Mobile Charger", "News Paper", "News Paper", "Notebook Pencile"]
    
    override func awakeFromNib() {
        self.kiwniComfirtCollectionView.register(UINib(nibName: "KiwniComfirtCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")

        
        
        CollectionViewDesignclass.collectionViewDesign(kiwniComfirtCollectionView)
        CollectionViewDesignclass.viewDesign(kiwniComfirtView, cornerRadius: 10.0, color: UIColor.black.cgColor, borderWidth: 1.0, maskCorner: [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner])
        kiwniComfirtCollectionView.delegate = self
        kiwniComfirtCollectionView.dataSource = self
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return kiwniComfirtArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = kiwniComfirtCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! KiwniComfirtCollectionViewCell
        cell.safetyLabel.text = kiwniComfirtArray[indexPath.row]
        cell.safetyImageView.image = UIImage(named: kiwniComfirtImageArray[indexPath.row])
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
