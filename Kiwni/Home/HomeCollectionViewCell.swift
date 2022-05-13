//
//  HomeCollectionViewCell.swift
//  Kiwni_User_App
//
//  Created by Shubham Shinde on 09/02/22.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var tripTypeLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tripTypeLable.font = UIFont.fontStyle(16, .medium)
    }
    
    
}
