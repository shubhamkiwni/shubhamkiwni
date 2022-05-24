//
//  confirmBookingXIB.swift
//  Kiwni_User_App
//
//  Created by Shubham Shinde on 18/02/22.
//

import Foundation
import  UIKit

func dropShadow(_ button: UIButton){
    button.layer.masksToBounds = false
    button.layer.shadowColor = UIColor.black.cgColor
    button.layer.shadowOpacity = 0.5
    button.layer.shadowOffset = CGSize(width: -1, height: 1)
    button.layer.shadowRadius = 2.0
    button.layer.cornerRadius = 10
    button.backgroundColor = .buttonBackgroundColor
}

protocol openPopUp {
    func openPopUp()
}

enum checkunchcek {
    case emailButton
    case whatsAppButton
    case phoneButton
}

class confirmBooking: UIView {
    var delegate: openPopUp?
//    var notificationTypeString : String? = ""
    var tripTypeString : String? = ""
    var notificationTypeStr1: String? = ""
    var notificationTypeStr2: String? = ""
    var notificationTypeStr3: String? = ""
    var valueArr: [String] = ["Email","WSP","SMS"]
    var notificationString : String? = ""
    
    @IBOutlet var payAdvanceCollection: [UIButton]!
    @IBOutlet weak var businessDetailsView: UIView!
    
    let nibName = "confirmBookingXIB"
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var sendingDetailsView: UIView!
    @IBOutlet weak var sendMeBookingLabel: UILabel!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var phoneButton: UIButton!
    @IBOutlet weak var whatsAppButton: UIButton!
    
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
    
    @IBOutlet weak var personalLabel: UILabel!
    @IBOutlet weak var businessLabel: UILabel!
    
    @IBOutlet weak var billingDetailsLabel: UIButton!
    
    
    var companyName = ""
    var companyEmail = ""
    var companyPhone = ""
    
    static let share = confirmBooking()
    override func awakeFromNib() {
        
        emailButton.setImage(UIImage(named: "SquareCheck"), for: .normal)
        whatsAppButton.setImage(UIImage(named: "SquareCheck"), for: .normal)
        phoneButton.setImage(UIImage(named: "SquareCheck"), for: .normal)
        
        emailButton.isSelected = true
        whatsAppButton.isSelected = true
        phoneButton.isSelected =  true
        emailButton.setBackgroundColor(.clear, for: .selected)
        whatsAppButton.setBackgroundColor(.clear, for: .selected)
        phoneButton.setBackgroundColor(.clear, for: .selected)
        
        dropShadow(applyButton)
        
        emailButton.titleLabel?.font = UIFont.fontStyle(15, .regular)
        phoneButton.titleLabel?.font = UIFont.fontStyle(15, .regular)
        whatsAppButton.titleLabel?.font = UIFont.fontStyle(15, .regular)
        sendMeBookingConfirmationLabel.font = UIFont.fontStyle(15, .regular)
        billingDetailsLabel.titleLabel?.font = UIFont.fontStyle(14, .regular)
        rideFareLabel.font = UIFont.fontStyle(14, .regular)
        extraFareKMLabel.font = UIFont.fontStyle(14, .regular)
        extraFarePerKMLabel.font = UIFont.fontStyle(14, .regular)
        totalBaseFareLabel.font = UIFont.fontStyle(14, .regular)
        applyCoupnLabel.font = UIFont.fontStyle(14, .regular)
        gstLabel.font = UIFont.fontStyle(14, .regular)
        totalLabel.font = UIFont.fontStyle(14, .regular)
        rideFareAmountLabel.font = UIFont.fontStyle(14, .regular)
        extraFareKMAmountLabel.font = UIFont.fontStyle(14, .regular)
        extraFarePerKMAmountLabel.font = UIFont.fontStyle(14, .regular)
        totalBaseFareAmountLabel.font = UIFont.fontStyle(14, .regular)
        applyCoupnLabel.font = UIFont.fontStyle(14, .regular)
        gstLabel.font = UIFont.fontStyle(14, .regular)
        totalLabel.font = UIFont.fontStyle(14, .regular)
        personalLabel.font = UIFont.fontStyle(15, .regular)
        businessLabel.font = UIFont.fontStyle(15, .regular)
        pay30Label.font = UIFont.fontStyle(15, .regular)
        pay50Label.font = UIFont.fontStyle(15, .regular)
        pay100Label.font = UIFont.fontStyle(15, .regular)
        pay30AmountLabel.font = UIFont.fontStyle(14, .regular)
        pay50AmountLabel.font = UIFont.fontStyle(14, .regular)
        pay100AmountLabel.font = UIFont.fontStyle(14, .regular)
        companyNameLabel.font = UIFont.fontStyle(15, .regular)
        companyEmailLabel.font = UIFont.fontStyle(15, .regular)
        companyPhoneLabel.font = UIFont.fontStyle(15, .regular)
        companyNameValueLabel.font = UIFont.fontStyle(15, .regular)
        companyEmailValueLabel.font = UIFont.fontStyle(15, .regular)
        companyPhoneValueLabel.font = UIFont.fontStyle(15, .regular)
        applyButton.titleLabel?.font = UIFont.fontStyle(15, .regular)
        offerCodeTextField.font = UIFont.fontStyle(15, .regular)
        
        emailButton.isSelected = true
        whatsAppButton.isSelected = true
        phoneButton.isSelected =  true
        emailButton.setBackgroundColor(.clear, for: .selected)
        whatsAppButton.setBackgroundColor(.clear, for: .selected)
        phoneButton.setBackgroundColor(.clear, for: .selected)
        
        tripTypeString = "Personal"
        UserDefaults.standard.set(tripTypeString, forKey: "selecttripType")
       
        notificationString = "Email,WSP,SMS"
        print("In Did Load notification String: ", notificationString ?? "")
        print("valueArr: ", valueArr)
        
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
        print(companyNameValueLabel.text ?? "", companyEmailValueLabel.text ?? "", companyPhoneValueLabel.text ?? "")
        
        
        
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
        businessButton.setImage(UIImage(named: "uncheck circle"), for: .normal)
        personalButton.setImage(UIImage(named: "check circle"), for: .normal)
        businessDetailsView.isHidden = true
        tripTypeString = "Personal"
        UserDefaults.standard.set(tripTypeString, forKey: "selecttripType")

    }
    @IBAction func businessButtonPressed(_ sender: UIButton) {
        
        businessButton.setImage(UIImage(named: "check circle"), for: .normal)
        personalButton.setImage(UIImage(named: "uncheck circle"), for: .normal)
        businessDetailsView.isHidden = false
        tripTypeString = "Business"
        UserDefaults.standard.set(tripTypeString, forKey: "selecttripType")
        delegate?.openPopUp()
        
    }
    
    var notificationType = [String]()
    
    @IBAction func notificationTypeButtonPressed(_ sender: UIButton){
        print("Button pressed")
        print(valueArr)
        
        switch sender {
        case emailButton:
            print("Email Button Pressed.")
            if(emailButton.isSelected == true){
                emailButton.isSelected = false
                emailButton.setImage(UIImage(named: "SquareUncheck"), for: .normal)
                            
                if let index = valueArr.firstIndex(of: "Email") {
                    valueArr.remove(at: index)
                } else {
                    print("not found")
                }
                print("valueArr: ",valueArr)
            }else{
                emailButton.isSelected = true
                emailButton.setImage(UIImage(named: "SquareCheck"), for: .normal)
                notificationTypeStr1 = "Email"
                valueArr.append(notificationTypeStr1 ?? "")
            }
            
        case whatsAppButton:
            print("WSP Button Pressed.")
//            wspButton.isSelected = false
            if(whatsAppButton.isSelected == true){
                whatsAppButton.isSelected = false
                whatsAppButton.setImage(UIImage(named: "SquareUncheck"), for: .normal)
  
                if let index = valueArr.firstIndex(of: "WSP") {
                    valueArr.remove(at: index)
                } else {
                    print("not found")
                }
                print("valueArr: ",valueArr)
            }else{
                whatsAppButton.isSelected = true
                whatsAppButton.setImage(UIImage(named: "SquareCheck"), for: .normal)
                notificationTypeStr2 = "WSP"
                valueArr.append(notificationTypeStr2 ?? "")
            }
        case phoneButton:
            print("SMS Button Pressed.")
            if(phoneButton.isSelected == true){
                phoneButton.isSelected = false
                phoneButton.setImage(UIImage(named: "SquareUncheck"), for: .normal)

                if let index = valueArr.firstIndex(of: "SMS") {
                    valueArr.remove(at: index)
                } else {
                    print("not found")
                }
            }else{
                phoneButton.isSelected = true
                phoneButton.setImage(UIImage(named: "SquareCheck"), for: .normal)
                notificationTypeStr3 = "SMS"
                valueArr.append(notificationTypeStr3 ?? "")
            }
        default:
            print("No Case Found.")
        }
        notificationString = valueArr.joined(separator: ",")
        print("notificationString: ", notificationString ?? "")
    }
    
}


extension UIButton {

  func setBackgroundColor(_ color: UIColor, for forState: UIControl.State) {
    UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
    UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
    UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
    let colorImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    self.setBackgroundImage(colorImage, for: forState)
  }

}
