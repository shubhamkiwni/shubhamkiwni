//
//  ResultCarsTableViewCell.swift
//  Kiwni
//
//  Created by Shubham Shinde on 09/05/22.
//

import UIKit

class ResultCarsTableViewCell: UITableViewCell {
    
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
        
        applyShadow(cornerRadius: 8)
        carsDetailsView.layer.cornerRadius = 5.0
        carsDetailsView.layer.borderWidth = 1.0
        carsDetailsView.layer.borderColor = UIColor.lightGray.cgColor
//        carModelsView.addSubview(CarModelsXIB)
//        CarModelsXIB.delegate2 = self
        carTypeLabel.font = UIFont.fontStyle(14, .regular)
        carNameLabel.font = UIFont.fontStyle(15, .regular)
        avaiLabelStatus.font = UIFont.fontStyle(14, .regular)
        priceLabel.font = UIFont.fontStyle(14, .regular)
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
