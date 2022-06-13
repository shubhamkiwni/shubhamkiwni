//
//  AddNewPersonTableViewCell.swift
//  Kiwni
//
//  Created by Damini on 09/03/22.
//

import UIKit

class AddNewPersonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var addPersonView : UIView!
    @IBOutlet weak var addImageView : UIImageView!
    @IBOutlet weak var addPersonLabel : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
