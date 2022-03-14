//
//  CarsTableViewCell.swift
//  ViewCabsDesign
//
//  Created by Shubham Shinde on 07/02/22.
//

import UIKit

protocol PaymentDelegate3 {
    func goPaymeny()
}

class CarsTableViewCell: UITableViewCell {
    
    var delegate3: PaymentDelegate3?
    

    
    @IBOutlet weak var carImage: UIImageView!
    @IBOutlet weak var carTypeLabel: UILabel!
    @IBOutlet weak var carNameLabel: UILabel!
    @IBOutlet weak var avaiLabelStatus: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var carsDetailsView: UIView!
    @IBOutlet weak var lineImageView: UIImageView!
    
    var carModelsArray = ["", "", "", "", ""]
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
//        carModelsView.addSubview(CarModelsXIB)
//        CarModelsXIB.delegate2 = self
    }
    
//    func goNext() {
//        print("PaymentDelegate2 call")
//        delegate3?.goPaymeny()
//    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
