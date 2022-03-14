//
//  ThankYouViewController.swift
//  Kiwni_User_App
//
//  Created by Shubham Shinde on 21/02/22.
//

import UIKit

class ThankYouViewController: UIViewController {

    
    @IBOutlet weak var thankYouView: UIView!
    @IBOutlet weak var bookingDetailsView: UIView!
    @IBOutlet weak var thankYouLabel: UILabel!
    @IBOutlet weak var bookingSuccessfulLabel: UILabel!
    @IBOutlet weak var bookingNoLabel: UILabel!
    @IBOutlet weak var krnLabel: UILabel!
    @IBOutlet weak var notificationLabel: UILabel!
    @IBOutlet weak var okButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        CollectionViewDesignclass.viewDesign(thankYouView, cornerRadius: 10.0, color: UIColor.lightGray.cgColor, borderWidth: 0.0, maskCorner: [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner])
//        CollectionViewDesignclass.viewDesign(bookingDetailsView, cornerRadius: 0, color: UIColor.black.cgColor, borderWidth: 1)
        thankYouView.layer.cornerRadius = 10.0
        thankYouView.layer.masksToBounds = false
        thankYouView.layer.shadowColor = UIColor.black.cgColor
        thankYouView.layer.shadowOpacity = 0.5
        thankYouView.layer.shadowOffset = CGSize(width: -1, height: 1)
        thankYouView.layer.shadowRadius = 1
        bookingDetailsView.addTopBorderWithColor(color: .black, width: 1.0)
        bookingDetailsView.addBottomBorderWithColor(color: .black, width: 1.0, frameWidth: bookingDetailsView.frame.width)
        
        print(bookingDetailsView.frame.width)
        
    }

    
    @IBAction func okButtonPressed(_ sender: UIButton) {
        let hvc = navigationController?.viewControllers[2] as! HomeViewController
        navigationController?.popToViewController(hvc, animated: true)
    }
    
    
}
