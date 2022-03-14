//
//  DesignExtension.swift
//  Kiwni_User_App
//
//  Created by Shubham Shinde on 03/02/22.
//

import Foundation
import UIKit

extension UpcomingTableViewCell{
    func labelDesign(_ image: String,_ labletxt: String,_ labelnm: UILabel!) {
        // Create Attachment
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(named:image)
        // Set bound to reposition
        let imageOffsetY: CGFloat = -5.0
        imageAttachment.bounds = CGRect(x: -4, y: imageOffsetY, width: imageAttachment.image!.size.width, height: imageAttachment.image!.size.height)
        // Create string with attachment
        let attachmentString = NSAttributedString(attachment: imageAttachment)
        // Initialize mutable string
        let completeText = NSMutableAttributedString(string: "")
        // Add image to mutable string
        completeText.append(attachmentString)
        // Add your text to mutable string
        let textAfterIcon = NSAttributedString(string: labletxt)
        completeText.append(textAfterIcon)
        labelnm.textAlignment = .center
        labelnm.attributedText = completeText
    }
}

extension PastTableViewCell{
    func labelDesign(_ image: String,_ labletxt: String,_ labelnm: UILabel!) {
        // Create Attachment
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(named:image)
        // Set bound to reposition
        let imageOffsetY: CGFloat = -5.0
        imageAttachment.bounds = CGRect(x: 0, y: imageOffsetY, width: imageAttachment.image!.size.width, height: imageAttachment.image!.size.height)
        // Create string with attachment
        let attachmentString = NSAttributedString(attachment: imageAttachment)
        // Initialize mutable string
        let completeText = NSMutableAttributedString(string: " ")
        // Add image to mutable string
        completeText.append(attachmentString)
        // Add your text to mutable string
        let textAfterIcon = NSAttributedString(string: labletxt)
        completeText.append(textAfterIcon)
        labelnm.textAlignment = .center
        labelnm.attributedText = completeText
    }
}

