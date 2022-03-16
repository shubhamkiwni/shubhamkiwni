//
//  BookingAddressXIB.swift
//  ViewCabsDesign
//
//  Created by Shubham Shinde on 11/02/22.
//

import Foundation
import UIKit


class BookingAddressXIB: UIView {
    
    
    @IBOutlet weak var bookingDetailsView: UIView!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var carDetailsView: UIView!
    @IBOutlet weak var dateTimeView: UIView!
    @IBOutlet weak var calenderImage: UIImageView!
    @IBOutlet weak var clockImage: UIImageView!
    @IBOutlet weak var serviceTypeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var carImage: UIImageView!
    @IBOutlet weak var carNameLabel: UILabel!
    @IBOutlet weak var carTypeLabel: UILabel!
    @IBOutlet weak var estKMImageView: UIImageView!
    @IBOutlet weak var estKMValueLabel: UILabel!
    @IBOutlet weak var dottedImageView: UIImageView!
    
    internal override func awakeFromNib() {
        bookingDetailsView.layer.cornerRadius = 10.0
        bookingDetailsView.layer.borderColor = UIColor.black.cgColor
        bookingDetailsView.layer.borderWidth = 1.0
//        labelDesign("SourceAddress", " New Airport Road, Viman Nagar, Pune, Maharashtra", sourceLabel)
//        labelDesign("DestinationAddress", " Lane No. 5, H. No. 2587, Dhule, Maharashtra", destinationLabel)
        
    }
    
    func labelDesign(_ image: String,_ Labeltxt: String,_ labelnm: UILabel!) {
        // Create Attachment
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(named:image)
        // Set bound to reposition
        let imageOffsetY: CGFloat = -5.0
        imageAttachment.bounds = CGRect(x: 0, y: imageOffsetY, width: imageAttachment.image!.size.width, height: imageAttachment.image!.size.height)
        // Create string with attachment
        let attachmentString = NSAttributedString(attachment: imageAttachment)
        // Initialize mutable string
        let completeText = NSMutableAttributedString(string: "   ")
        // Add image to mutable string
        completeText.append(attachmentString)
        // Add your text to mutable string
        let textAfterIcon = NSAttributedString(string: Labeltxt)
        completeText.append(textAfterIcon)
//        labelnm.textAlignment = .center
        labelnm.attributedText = completeText
    }
    
}
