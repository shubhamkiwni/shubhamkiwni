//
//  GoTOSettingsViewController.swift
//  Kiwni
//
//  Created by Shubham Shinde on 17/05/22.
//

import UIKit

class GoTOSettingsViewController: UIViewController {

    @IBOutlet weak var locationPermissionImageView: UIImageView!
    @IBOutlet weak var locationPermissionRequiredLabel: UILabel!
    @IBOutlet weak var locationPermissionMessageLabel: UILabel!
    @IBOutlet weak var goToSettingsButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        goToSettingsButton.backgroundColor = .buttonBackgroundColor
        goToSettingsButton.layer.cornerRadius = 10.0
        
    }
    

    @IBAction func goToSettingsButtonPressed(_ sender: UIButton) {
        print("Move To Seeting.")
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        
        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                print("Settings opened: \(success)") // Prints true
            })
        }
    }
    

}
