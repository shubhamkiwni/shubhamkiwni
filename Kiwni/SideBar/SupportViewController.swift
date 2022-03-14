//
//  SupportViewController.swift
//  Kiwni_User_App
//
//  Created by Shubham Shinde on 02/02/22.
//

import UIKit

class SupportViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var supportTableView: UITableView!
    @IBOutlet weak var backButton: UIButton!
    
    var supportArray = ["Trips Issues and Refunds", "A guide to Kiwni", "Accessibility", "All about kiwni Service", "New Booking Error", "Kiwni emergency Number"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        let hvc = navigationController?.viewControllers[2] as! HomeViewController
        navigationController?.popToViewController(hvc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return supportArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = supportTableView.dequeueReusableCell(withIdentifier: "cell") as! SupportTableViewCell
        cell.supportLabel.text = supportArray[indexPath.row]
        return cell
    }
    
}
