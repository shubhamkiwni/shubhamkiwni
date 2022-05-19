//
//  CancelRideViewController.swift
//  Kiwni_User_App
//
//  Created by Shubham Shinde on 04/02/22.
//

import UIKit

protocol CancelRideDelegate : AnyObject {
    func cancelRide()
}

class CancelRideViewController: UIViewController {
    var cancelDelegate: CancelRideDelegate?
    @IBOutlet weak var cancelView: UIView!
    @IBOutlet weak var reasonFortripLabel: UILabel!
    @IBOutlet weak var areYouSureLabel: UILabel!
    @IBOutlet weak var reasonLabel1: UILabel!
    @IBOutlet weak var reasonLabel2: UILabel!
    @IBOutlet weak var reasonLabel3: UILabel!
    @IBOutlet weak var reasonLabel4: UILabel!
    
    @IBOutlet var radioButton: [UIButton]!
    
    @IBOutlet weak var dontCancelButton: UIButton!
    @IBOutlet weak var cancelRideButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cancelView.layer.cornerRadius = 10.0
        dontCancelButton.layer.cornerRadius = 5.0
        cancelRideButton.layer.cornerRadius = 5.0
        dontCancelButton.backgroundColor = .buttonBackgroundColor
        cancelRideButton.backgroundColor = .buttonBackgroundColor
        reasonLabel1.font = UIFont.fontStyle(13, .regular)
        reasonLabel2.font = UIFont.fontStyle(13, .regular)
        reasonLabel3.font = UIFont.fontStyle(13, .regular)
        reasonLabel4.font = UIFont.fontStyle(13, .regular)
        reasonFortripLabel.font = UIFont.fontStyle(15, .regular)
        areYouSureLabel.font = UIFont.fontStyle(13, .regular)
        cancelRideButton.titleLabel?.font = UIFont.fontStyle(15, .regular)
        dontCancelButton.titleLabel?.font = UIFont.fontStyle(15, .regular)
    }
    
    @IBAction func radioButtonAction(_ sender: UIButton) {
        
        for button in radioButton {
            if button.tag == sender.tag {
                button.setTitle("true", for: .normal)
                button.setImage(UIImage(named: "Check"), for: .normal)
            } else {
                button.setTitle("false", for: .normal)
                button.setImage(UIImage(named: "Uncheck"), for: .normal)
            }
        }
        
    }
    
    
    @IBAction func dontCancelButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelRideButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
//        cancelDelegate?.cancelRide()
    }
}
