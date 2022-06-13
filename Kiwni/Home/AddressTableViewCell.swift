//
//  AddressTableViewCell.swift
//  AutoTextFieldDemo
//
//  Created by Shubham Shinde on 10/06/22.
//

import UIKit

class AddressTableViewCell: UITableViewCell {

    @IBOutlet weak var addressTypeImageView: UIImageView!
    @IBOutlet weak var addressTypeValue: UILabel!
    @IBOutlet weak var addressValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
