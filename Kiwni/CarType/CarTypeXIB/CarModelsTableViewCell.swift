//
//  CarModelsTableViewCell.swift
//  ViewCabsDesign
//
//  Created by Shubham Shinde on 08/02/22.
//

import UIKit

protocol PaymentDelegate  {
    func payment(getName: String)
    func review()
   func bookButtonPressed(_ cell: CarModelsTableViewCell)
}



class CarModelsTableViewCell: UITableViewCell {

    var delegate1: PaymentDelegate?
    
    @IBOutlet weak var modelRegisterLabel: UILabel!
    @IBOutlet weak var carModelRegisterYearLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var star1: UIButton!
    @IBOutlet weak var star2: UIButton!
    @IBOutlet weak var star3: UIButton!
    @IBOutlet weak var star4: UIButton!
    @IBOutlet weak var star5: UIButton!
    @IBOutlet weak var starStackView: UIStackView!
    @IBOutlet weak var fareLabel: UILabel!
    @IBOutlet weak var bookButton: UIButton!
    @IBOutlet weak var carModelsView: UIView!
    @IBOutlet weak var availabelStatusLabel: UILabel!
    @IBOutlet weak var vehicalProviderLabel: UILabel!
    @IBOutlet weak var vehicalProviderNoLabel: UILabel!
    @IBOutlet weak var reviewButton: UIButton!
    
    var name = "Shubham"
    override func awakeFromNib() {
        super.awakeFromNib()
        applyShadow(cornerRadius: 8)
        bookButton.layer.cornerRadius = 5.0
        
//        carModelsView.layer.masksToBounds = false
//        carModelsView.layer.shadowColor = UIColor.black.cgColor
//        carModelsView.layer.shadowOpacity = 0.5
//        carModelsView.layer.shadowOffset = CGSize(width: -1, height: 1)
//        carModelsView.layer.shadowRadius = 1
        
        modelRegisterLabel.font = UIFont.fontStyle(13, .regular)
        carModelRegisterYearLabel.font = UIFont.fontStyle(12, .regular)
        ratingLabel.font = UIFont.fontStyle(13, .regular)
        fareLabel.font = UIFont.fontStyle(13, .regular)
        bookButton.titleLabel?.font = UIFont.fontStyle(12, .regular)
        availabelStatusLabel.font = UIFont.fontStyle(10, .regular)
        vehicalProviderLabel.font = UIFont.fontStyle(13, .regular)
        vehicalProviderNoLabel.font = UIFont.fontStyle(10, .regular)
        reviewButton.titleLabel?.font = UIFont.fontStyle(11, .regular)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func nextView(_ sender: UIButton) {
        print("Book Button Pressed")
        
        delegate1?.bookButtonPressed(self)
//        delegate1?.payment(getName: name)
    }
    
    @IBAction func reviewButtonClick(_ sender: UIButton) {
        delegate1?.review()
    }
    
}
