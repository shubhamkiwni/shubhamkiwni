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
        
        let distance : String = UserDefaults.standard.string(forKey: "distance") ?? ""
        let fromLocation : String = UserDefaults.standard.string(forKey: "fromLocation") ?? ""
        let toLocation: String = UserDefaults.standard.string(forKey: "DestinationCityName") ?? ""
        let journeyEndTime : String = UserDefaults.standard.string(forKey: "journeyEndTime") ?? ""
        let journeyTime : String = UserDefaults.standard.string(forKey: "journeyTime") ?? ""
        let classType: String = UserDefaults.standard.string(forKey: "classType") ?? ""
        let modelName: String = UserDefaults.standard.string(forKey: "modelName") ?? ""
        
        var startTime = journeyTime.split(separator: ".")
        startTime.removeLast()
        print("StartTime : ", startTime)
        
        let str = startTime.joined(separator: ".")
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX") //"en_US_POSIX"
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        if let date = formatter.date(from: str) {
            formatter.dateFormat = "hh:mm a"
            let timeStr = formatter.string(from: date)
            print(timeStr) //add timeStr to your timeLabel here...
            
            formatter.dateFormat = "EEE, dd MMM"
            let dateStr = formatter.string(from: date)
            print("Booking Details dateStr:",dateStr) //add dateStr to your dateLabel here...
            
            self.dateLabel.text = "\(dateStr)"
            self.timeLabel.text = "\(timeStr)"
            print("Date Label in booking details: ",self.dateLabel.text)
            print("Time Label in booking details: ",self.timeLabel.text)
        }
        
        print("classType from CarsViewcontroller:", classType)
        print("modelName from CarsViewcontroller:", modelName)
        print(distance)
        print(fromLocation)
        print(toLocation)
        print(journeyEndTime)
        print(journeyTime)
        
        self.sourceLabel.text = UserDefaults.standard.string(forKey: "SourceAddress")
        self.destinationLabel.text = UserDefaults.standard.string(forKey: "DestinationAddress")
        self.serviceTypeLabel.text = UserDefaults.standard.string(forKey: "tripType")
//        self.dateLabel.text = UserDefaults.standard.string(forKey: "journeyTime")
        self.estKMValueLabel.text = "Est.Km -\((UserDefaults.standard.string(forKey: "distance")) ?? "")km "
        self.carNameLabel.text = UserDefaults.standard.string(forKey: "modelName")
        self.carTypeLabel.text = UserDefaults.standard.string(forKey: "classType")
        
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
