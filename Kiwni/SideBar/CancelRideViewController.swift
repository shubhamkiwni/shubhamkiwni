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
    }
    
    @IBAction func radioButton1Pressed(_ sender: UIButton) {
    }
    
    @IBAction func radioButton2Pressed(_ sender: UIButton) {
    }
    
    @IBAction func radioButton3Pressed(_ sender: UIButton) {
    }
    
    
    @IBAction func radioButton4Pressed(_ sender: UIButton) {
    }
    
    @IBAction func dontCancelButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelRideButtonPressed(_ sender: UIButton) {
//        dismiss(animated: true, completion: nil)
        cancelDelegate?.cancelRide()
    }
}
