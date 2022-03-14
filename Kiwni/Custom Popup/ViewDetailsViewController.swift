//
//  ViewDetailsViewController.swift
//  Kiwni
//
//  Created by Shubham Shinde on 02/03/22.
//

import UIKit

protocol ViewDetailsPopupViewDelegate: AnyObject
{
    func customPopupViewExtension(sender: ViewDetailsViewController, didSelectNumber : Int)
}

class ViewDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    weak var delegate: ViewDetailsPopupViewDelegate?
    static func instantiate() -> ViewDetailsViewController? {
        return ViewDetailsViewController(nibName: nil, bundle: nil)
    }
    
    @IBOutlet weak var rentalPackageLabel: UILabel!
    
    @IBOutlet weak var rulesTableView: UITableView!
    var rulesArray = ["Rental can be used for local travels only. Package cannot be changed after booking is confirmed.", "For usage beyond selected package, additional fare will be applicable as per rates above.", "Additional GST applicable on fare. Toll will be added in the final bill if applicable, please pay parking fee when required.", "For Ride Later booking , Advance Booking fee of Rs 100 will be added to Total Fare.", "Base fare amount is the minimum bill amount a Customer has to pay for the package."]
    
    let footerView = UIView()
    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.rulesTableView.register(UINib(nibName: "RulesTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        rulesTableView.delegate = self
        rulesTableView.dataSource = self
        
        button.addTarget(self, action: #selector(pressedDoneButton), for: .touchUpInside)
    }
    
    @objc func pressedDoneButton() {
        dismiss(animated: true) {
            print("Done Click Successfully")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rulesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = rulesTableView.dequeueReusableCell(withIdentifier: "cell") as! RulesTableViewCell
        cell.rulesLabel.text = rulesArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        footerView.backgroundColor = .clear
        footerView.frame = CGRect(x: 0, y: 10, width: self.rulesTableView.frame.width, height: 100)
        
        button.frame = CGRect(x: 80, y: 10, width: self.rulesTableView.frame.width - 150, height: 30)
        button.setTitle("Done", for: .normal)
        button.setTitleColor( .white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 10.0
        
        footerView.addSubview(button)
        return footerView
    }
}
