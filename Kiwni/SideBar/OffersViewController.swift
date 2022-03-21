//
//  OffersViewController.swift
//  Kiwni_User_App
//
//  Created by Shubham Shinde on 03/02/22.
//

import UIKit

class OffersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var offersTableView: UITableView!
    var offersArray = ["Group6284", "Group6285", "Group6286", "Group6284", "Group6285"]
    @IBOutlet weak var offersView: UIView!
    @IBOutlet weak var offersLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        offersTableView.register(UINib(nibName: "OffersTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
    

    @IBAction func backButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return offersArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = offersTableView.dequeueReusableCell(withIdentifier: "cell") as! OffersTableViewCell
        cell.offerImageView.image = UIImage(named: offersArray[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}
