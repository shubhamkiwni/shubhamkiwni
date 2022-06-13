//
//  ContactPersonTableViewCell.swift
//  Kiwni
//
//  Created by Damini on 09/03/22.
//

import UIKit

class ContactPersonTableViewCell: UITableViewCell {

    @IBOutlet weak var contactPersonView: UIView!
    
    @IBOutlet weak var personNameTextField: UITextField!
    @IBOutlet weak var personnameLabel: UILabel!
    @IBOutlet weak var otherContactPesronLabel: UILabel!
    
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
