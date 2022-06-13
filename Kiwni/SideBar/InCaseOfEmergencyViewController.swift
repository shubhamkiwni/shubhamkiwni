//
//  InCaseOfEmergencyViewController.swift
//  Kiwni
//
//  Created by Shubham Shinde on 06/05/22.
//

import UIKit

class InCaseOfEmergencyViewController: UIViewController {

    @IBOutlet weak var policeView: UIView!
    @IBOutlet weak var kiwniView: UIView!
    @IBOutlet weak var personView: UIView!
    
    @IBOutlet weak var policeLabel: UILabel!
    @IBOutlet weak var kiwniLabel: UILabel!
    @IBOutlet weak var personLabel: UILabel!
    
    @IBOutlet weak var policeCallButton: UIButton!
    @IBOutlet weak var kiwniCallButton: UIButton!
    @IBOutlet weak var personCallButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        uiViewDesign2(policeView)
        uiViewDesign2(kiwniView)
        uiViewDesign2(personView)
    }
        
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func policeCallButton(_ sender: UIButton) {
    }
    
    @IBAction func kiwniCallButton(_ sender: UIButton) {
    }
    
    @IBAction func personCallButton(_ sender: UIButton) {
    }
    
}
