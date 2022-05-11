//
//  UpcomingTableViewCell.swift
//  Kiwni_User_App
//
//  Created by Shubham Shinde on 02/02/22.
//

import UIKit
protocol MyRideDelegate : AnyObject {
    func didPressButton()
}
class UpcomingTableViewCell: UITableViewCell {
    
    
    var delegate: MyRideDelegate?
    var cancelDelegate: CancelRideDelegate?
    
    static let identifier = "UpcomingTableViewCell"
        static func nib()  -> UINib {
            return UINib(nibName: "UpcomingTableViewCell", bundle: nil)
        }
    
    @IBOutlet weak var tripDetailsView: UIView!
    @IBOutlet weak var bookingDetailsView: UIView!
    @IBOutlet weak var notificationView: UIView!
    @IBOutlet weak var carDetailsView: UIView!
    @IBOutlet weak var cancelButtonView: UIView!
    @IBOutlet weak var tripStackView: UIStackView!
    
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var pickUpImageView: UIImageView!
    @IBOutlet weak var dropImageView: UIImageView!
    
    
    @IBOutlet weak var calendarImageView: UIImageView!
    @IBOutlet weak var clockImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var serviceTypeLabel: UILabel!
    @IBOutlet weak var serviceTypeValue: UILabel!
    @IBOutlet weak var bookingNoLabel: UILabel!
    @IBOutlet weak var bookingNoValue: UILabel!
    @IBOutlet weak var krnNoLabel: UILabel!
    @IBOutlet weak var krnNoValue: UILabel!
    @IBOutlet weak var notificationLabel: UILabel!
    @IBOutlet weak var carNameLabel: UILabel!
    @IBOutlet weak var carTypeLabel: UILabel!
    
    
    
    @IBOutlet weak var mobileNumberLabel: UILabel!
    @IBOutlet weak var vehicalNumberLabel: UILabel!
    @IBOutlet weak var otpLabel: UILabel!
    @IBOutlet weak var otpValue: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var driverImageView: UIImageView!
    @IBOutlet weak var mobileImageView: UIImageView!
    @IBOutlet weak var driverNameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        design(tripStackView)
        buttonDesign(button: cancelButton)
        
        sourceLabel.font = UIFont.fontStyle(17, .medium)
        destinationLabel.font = UIFont.fontStyle(17, .medium)
        dateLabel.font = UIFont.fontStyle(17, .medium)
        timeLabel.font = UIFont.fontStyle(17, .medium)
        serviceTypeLabel.font = UIFont.fontStyle(17, .medium)
        serviceTypeValue.font = UIFont.fontStyle(17, .medium)
        
        bookingNoLabel.font = UIFont.fontStyle(17, .medium)
        bookingNoValue.font = UIFont.fontStyle(17, .medium)
        
        krnNoLabel.font = UIFont.fontStyle(17, .medium)
        krnNoValue.font = UIFont.fontStyle(17, .medium)
        
        krnNoValue.font = UIFont.fontStyle(15, .medium)
        
        krnNoValue.font = UIFont.fontStyle(15, .medium)
        carNameLabel.font = UIFont.fontStyle(14, .medium)
        carTypeLabel.font = UIFont.fontStyle(14, .medium)
        mobileNumberLabel.font = UIFont.fontStyle(14, .medium)
        vehicalNumberLabel.font = UIFont.fontStyle(14, .medium)
        otpLabel.font = UIFont.fontStyle(14, .medium)
        otpValue.font = UIFont.fontStyle(14, .medium)
        
        driverNameLabel.font = UIFont.fontStyle(14, .medium)
        
        cancelButton.titleLabel?.font = UIFont.fontStyle(15, .medium)
        
//        notificationView.isHidden = true
        
//        borderLabel.layer.borderWidth = 2.0
//        borderLabel.layer.borderColor = UIColor.lightGray.cgColor
        
//        LabelDesign("Pickuppoint", "Spin plaza, Choudhari wasti, Pune, Maharashtra..", sourceLabel)
//        LabelDesign("Droppoint", "Lane No. 3, Link Road, Navi Mumbai, Maharasht..", destinationLabel)
//        LabelDesign("Mobileicon", "8308628266", mobileNumberLabel)
    }
    
    
    
    func design(_ view: UIView) {
        view.layer.cornerRadius = 10.0
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: -1, height: 1)
        view.layer.shadowRadius = 1
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.black.cgColor
    }

    func buttonDesign(button: UIButton) {
        button.layer.cornerRadius = 5.0
        button.layer.masksToBounds = false
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = CGSize(width: -1, height: 1)
        button.layer.shadowRadius = 1
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func rideCancelButtonPressed(_ sender: UIButton) {
        delegate?.didPressButton()
        cancelDelegate?.cancelRide()
    }
    
    
}
