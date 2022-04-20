//
//  confirmBookingXIB.swift
//  Kiwni_User_App
//
//  Created by Shubham Shinde on 18/02/22.
//

import Foundation
import  UIKit

protocol openPopUp {
    func openPopUp()
}

class confirmBooking: UIView {
    var delegate: openPopUp?
    var emailTag: Int = 0
    var phoneTag: Int = 0
    var whatsAppTag: Int = 0
    var notificationTypeString : String? = ""
    var tripTypeString : String? = ""
    
    @IBOutlet var payAdvanceCollection: [UIButton]!
    @IBOutlet var personalCollection: [UIButton]!
    @IBOutlet weak var businessDetailsView: UIView!
    
    let nibName = "confirmBookingXIB"
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var sendingDetailsView: UIView!
    @IBOutlet weak var sendMeBookingLabel: UILabel!
    @IBOutlet weak var emailRadioButton: UIButton!
    @IBOutlet weak var phoneRadioButton: UIButton!
    @IBOutlet weak var whatsAppRadioButton: UIButton!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var whatsAppLabel: UILabel!
 
    
    
    @IBOutlet weak var sendMeBookingConfirmationLabel: UILabel!
    @IBOutlet weak var offerCodeTextField: UITextField!
    @IBOutlet weak var applyButton: UIButton!
    
    @IBOutlet weak var offerTextFieldView: UIView!
    @IBOutlet weak var bookingDetailsView: UIView!
    @IBOutlet weak var rideFareView: UIView!
    @IBOutlet weak var bookingDetailsLabel: UIButton!
    @IBOutlet weak var rideFareLabel: UILabel!
    @IBOutlet weak var extraFareKMLabel: UILabel!
    @IBOutlet weak var extraFarePerKMLabel: UILabel!
    @IBOutlet weak var totalBaseFareLabel: UILabel!
    @IBOutlet weak var applyCoupnLabel: UILabel!
    @IBOutlet weak var gstLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var rideFareAmountLabel: UILabel!
    @IBOutlet weak var extraFareKMAmountLabel: UILabel!
    @IBOutlet weak var extraFarePerKMAmountLabel: UILabel!
    @IBOutlet weak var totalBaseFareAmountLabel: UILabel!
    @IBOutlet weak var applyCoupenAmountLabel: UILabel!
    @IBOutlet weak var gstAmountLabel: UILabel!
    @IBOutlet weak var totalAmountALble: UILabel!
    
    @IBOutlet weak var personalButton: UIButton!
    @IBOutlet weak var businessButton: UIButton!
    
    @IBOutlet weak var payInAdvanceView: UIView!
    @IBOutlet weak var pay30Label: UILabel!
    @IBOutlet weak var pay50Label: UILabel!
    @IBOutlet weak var pay100Label: UILabel!
    
    
    @IBOutlet weak var pay30AmountLabel: UILabel!
    @IBOutlet weak var pay50AmountLabel: UILabel!
    @IBOutlet weak var pay100AmountLabel: UILabel!
    
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var companyEmailLabel: UILabel!
    @IBOutlet weak var companyPhoneLabel: UILabel!
    
    @IBOutlet weak var companyNameValueLabel: UILabel!
    @IBOutlet weak var companyEmailValueLabel: UILabel!
    @IBOutlet weak var companyPhoneValueLabel: UILabel!
    
    
    
    var companyName = ""
    var companyEmail = ""
    var companyPhone = ""
    
    static let share = confirmBooking()
    override func awakeFromNib() {
        tripTypeString = "Personal"
        notificationTypeString = "Email"
        UserDefaults.standard.set(tripTypeString, forKey: "selecttripType")
        UserDefaults.standard.set(notificationTypeString, forKey: "notificationType")
        
        if companyName.isEmpty == false {
            businessDetailsView.isHidden = false
            companyNameLabel.text = companyName
            companyEmailLabel.text = companyEmail
            companyPhoneLabel.text = companyPhone
        } else {
            businessDetailsView.isHidden = true
        }
        
        businessDetailsView.isHidden = true
        CollectionViewDesignclass.viewDesign(emailView, cornerRadius: 0.0, color: UIColor.lightGray.cgColor, borderWidth: 1.0, maskCorner: [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner])
        CollectionViewDesignclass.viewDesign(sendingDetailsView, cornerRadius: 10.0, color: UIColor.lightGray.cgColor, borderWidth: 1.0, maskCorner: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        CollectionViewDesignclass.viewDesign(payInAdvanceView, cornerRadius: 10.0, color: UIColor.lightGray.cgColor, borderWidth: 1.0, maskCorner: [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner])
        CollectionViewDesignclass.viewDesign(bookingDetailsView, cornerRadius: 10.0, color: UIColor.lightGray.cgColor, borderWidth: 1.0, maskCorner: [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner])
        CollectionViewDesignclass.viewDesign(rideFareView, cornerRadius: 0.0, color: UIColor.lightGray.cgColor, borderWidth: 1.0, maskCorner: [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner])
        CollectionViewDesignclass.viewDesign(businessDetailsView, cornerRadius: 10.0, color: UIColor.lightGray.cgColor, borderWidth: 1, maskCorner: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner])
        
        companyNameValueLabel.text = UserDefaults.standard.string(forKey: "companyName")
        companyEmailValueLabel.text = UserDefaults.standard.string(forKey: "companyEmail")
        companyPhoneValueLabel.text = UserDefaults.standard.string(forKey: "companyPhoneNo")
        print(companyNameValueLabel.text, companyEmailValueLabel.text, companyPhoneValueLabel.text)
        
        
        
    }
    
    @IBAction func apply(_ sender: UIButton) {
        print("Apply")
    }
    
    @IBAction func radio(_ sender: UIButton) {
        print("30")
    }
    
    @IBAction func payAdvanceButtonPressed(_ sender: UIButton) {
        for button in payAdvanceCollection {
            if button.tag == sender.tag {
                button.setImage(UIImage(named: "Check"), for: .normal)
//                buttonTag = sender.tag
            } else {
                button.setImage(UIImage(named: "Uncheck"), for: .normal)
            }
        }
    }
    
    @IBAction func personalButtonPressed(_ sender: UIButton) {
        businessButton.setImage(UIImage(named: "Uncheck"), for: .normal)
        personalButton.setImage(UIImage(named: "Check"), for: .normal)
        businessDetailsView.isHidden = true
        tripTypeString = "Personal"
        UserDefaults.standard.set(tripTypeString, forKey: "selecttripType")

    }
    @IBAction func businessButtonPressed(_ sender: UIButton) {
        
        businessButton.setImage(UIImage(named: "Check"), for: .normal)
        personalButton.setImage(UIImage(named: "Uncheck"), for: .normal)
        businessDetailsView.isHidden = false
        tripTypeString = "Business"
        UserDefaults.standard.set(tripTypeString, forKey: "selecttripType")
        delegate?.openPopUp()
        
    }
//    @IBAction func personalButtonPressed(_ sender: UIButton) {
//        for button in personalCollection {
//            if button.tag == sender.tag {
//                button.setImage(UIImage(named: "Check"), for: .normal)
////                buttonTag = sender.tag
//            } else {
//                button.setImage(UIImage(named: "Uncheck"), for: .normal)
//            }
//        }
//    }
    
    @IBAction func emailButtonPresed(_ sender: UIButton) {
        if emailTag == 0 {
            emailRadioButton.setImage(UIImage(named: "SquareCheck"), for: .normal)
            emailTag = 1
            notificationTypeString = "Email"
            UserDefaults.standard.set(notificationTypeString, forKey: "notificationType")
        } else {
            emailRadioButton.setImage(UIImage(named: "SquareUncheck"), for: .normal)
            emailTag = 0
        }
        
//        emailRadioButton.setImage(UIImage(named: "SquareCheck"), for: .normal)
//        phoneRadioButton.setImage(UIImage(named: "SquareUncheck"), for: .normal)
//        whatsAppRadioButton.setImage(UIImage(named: "SquareUncheck"), for: .normal)
//        notificationTypeString = "Email"
//        UserDefaults.standard.set(notificationTypeString, forKey: "notificationType")
        
    }
    
    @IBAction func phoneButtonPressed(_ sender: UIButton) {
        if phoneTag == 0 {
            phoneRadioButton.setImage(UIImage(named: "SquareCheck"), for: .normal)
            phoneTag = 1
            notificationTypeString = "SMS"
            UserDefaults.standard.set(notificationTypeString, forKey: "notificationType")
        } else {
            phoneRadioButton.setImage(UIImage(named: "SquareUncheck"), for: .normal)
            phoneTag = 0
        }
        
//        emailRadioButton.setImage(UIImage(named: "SquareUncheck"), for: .normal)
//        phoneRadioButton.setImage(UIImage(named: "SquareCheck"), for: .normal)
//        whatsAppRadioButton.setImage(UIImage(named: "SquareUncheck"), for: .normal)
//        notificationTypeString = "SMS"
//        UserDefaults.standard.set(notificationTypeString, forKey: "notificationType")
    }
    
    @IBAction func whatsAppButtonPressed(_ sender: UIButton) {
        if whatsAppTag == 0 {
            whatsAppRadioButton.setImage(UIImage(named: "SquareCheck"), for: .normal)
            whatsAppTag = 1
            notificationTypeString = "WhatsApp"
            UserDefaults.standard.set(notificationTypeString, forKey: "notificationType")
        } else {
            whatsAppRadioButton.setImage(UIImage(named: "SquareUncheck"), for: .normal)
            whatsAppTag = 0
        }
//        emailRadioButton.setImage(UIImage(named: "SquareUncheck"), for: .normal)
//        phoneRadioButton.setImage(UIImage(named: "SquareUncheck"), for: .normal)
//        whatsAppRadioButton.setImage(UIImage(named: "SquareCheck"), for: .normal)
//        notificationTypeString = "WhatsApp"
//        UserDefaults.standard.set(notificationTypeString, forKey: "notificationType")
    }
    
}
