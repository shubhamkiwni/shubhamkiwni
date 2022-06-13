//
//  ReviewTableViewCell.swift
//  Kiwni
//
//  Created by Shubham Shinde on 18/04/22.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var reviewText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        userName.font = UIFont.fontStyle(17, .medium)
        reviewText.font = UIFont.fontStyle(13, .medium)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
