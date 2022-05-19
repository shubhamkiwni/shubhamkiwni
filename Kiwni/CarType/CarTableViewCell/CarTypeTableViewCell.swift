//
//  CarTypeTableViewCell.swift
//  Kiwni_User_App
//
//  Created by Shubham Shinde on 10/02/22.
//

import UIKit

class CarTypeTableViewCell: UITableViewCell {

    @IBOutlet weak var carTypeLabel: UILabel!
    @IBOutlet weak var carTypeImage: UIImageView!
    @IBOutlet weak var availabelStatus: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var acLabel: UILabel!
    @IBOutlet weak var acImageView: UIImageView!
    @IBOutlet weak var seaterImageView: UIImageView!
    @IBOutlet weak var seaterLabel: UILabel!
    @IBOutlet weak var bagsImageView: UIImageView!
    @IBOutlet weak var bagsLabel: UILabel!
    
    @IBOutlet weak var baseView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        carTypeLabel.font = UIFont.fontStyle(15, .regular)
        availabelStatus.font = UIFont.fontStyle(15, .regular)
        priceLabel.font = UIFont.fontStyle(15, .regular)
        acLabel.font = UIFont.fontStyle(13, .regular)
        seaterLabel.font = UIFont.fontStyle(13, .regular)
        bagsLabel.font = UIFont.fontStyle(13, .regular)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
