//
//  PastTableViewCell.swift
//  Kiwni_User_App
//
//  Created by Shubham Shinde on 02/02/22.
//

import UIKit

class PastTableViewCell: UITableViewCell {

//    static let identifier = "PastTableViewCell"
//        static func nib()  -> UINib {
//            return UINib(nibName: "PastTableViewCell", bundle: nil)
//        }
    
    static let identifier = "PastTableViewCell"
       static func nib()  -> UINib {
           return UINib(nibName: "PastTableViewCell", bundle: nil)
       }
    
    @IBOutlet weak var pickUpdateTimeLable: UILabel!
    @IBOutlet weak var sourceLable: UILabel!
    @IBOutlet weak var destinationLable: UILabel!
    @IBOutlet weak var tripTypelable: UILabel!
    @IBOutlet weak var fareAmount: UILabel!
    @IBOutlet weak var driverImage: UIImageView!
    @IBOutlet weak var pickUpImage: UIImageView!
    @IBOutlet weak var dropImage: UIImageView!
    @IBOutlet weak var dropDateTimeLable: UILabel!
    @IBOutlet weak var tripStatusLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        pickUpdateTimeLable.font = UIFont.fontStyle(14, .semiBold)
        sourceLable.font = UIFont.fontStyle(14, .regular)
        dropDateTimeLable.font = UIFont.fontStyle(14, .semiBold)
        destinationLable.font = UIFont.fontStyle(14, .regular)
        tripTypelable.font = UIFont.fontStyle(14, .semiBold)
        fareAmount.font = UIFont.fontStyle(14, .regular)
        tripStatusLable.font = UIFont.fontStyle(14, .regular)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
