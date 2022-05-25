//
//  ResultViewController.swift
//  Kiwni_User_App
//
//  Created by Shubham Shinde on 21/02/22.
//

import UIKit

class ResultViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, PaymentDelegate3, PaymentDelegate {
    func usernameClicked(_ cell: CarModelsTableViewCell) {
        print("success")
    }
    
    func review() {
        print("success")
    }
    
    func payment(getName: String) {
        let next = UIStoryboard(name: "FindCar", bundle: nil).instantiateViewController(withIdentifier: "BookingDetailsViewController") as! BookingDetailsViewController
        navigationController?.pushViewController(next, animated: true)
    }
    
    func goPaymeny() {
        print("PaymentDelegate3 call")
        let next = storyboard?.instantiateViewController(withIdentifier: "BookingDetailsViewController") as! BookingDetailsViewController
//        next.resultVar = "Result"
        navigationController?.pushViewController(next, animated: true)
    }
    

    var sortingLabel: String = ""
    @IBOutlet weak var tripTypeLabel: UILabel!
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var sortingButton: UIButton!
    @IBOutlet weak var carsTableView: UITableView!
    var carsArray = ["", "", "", "", ""]
    
    var tableViewData = [cellData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sortingButton.setTitle(sortingLabel, for: .normal)
        sortingButton.layer.cornerRadius = 10.0
        sortingButton.layer.masksToBounds = false
        sortingButton.layer.shadowColor = UIColor.black.cgColor
        sortingButton.layer.shadowOpacity = 0.5
        sortingButton.layer.shadowOffset = CGSize(width: -1, height: 1)
        sortingButton.layer.shadowRadius = 1
        
        tableViewData = [cellData(opened: false, carType: "Premium", carName: "Mahindra", avaiLabel: "AvaiLabel: 4", amount: "2000", selectionData: ["2012", "2013", "2014", "2015", "2012", "2013", "2014", "2015"]),
                         cellData(opened: false, carType: "Luxury", carName: "Tata", avaiLabel: "AvaiLabel: 3", amount: "3000", selectionData: ["2011", "2012", "2013"]),
                         cellData(opened: false, carType: "Ultra-Luxury", carName: "BMW", avaiLabel: "AvaiLabel: 2", amount: "10000", selectionData: ["2020", "2021"]),
                         cellData(opened: false, carType: "Ultra-Luxury", carName: "BMW", avaiLabel: "AvaiLabel: 2", amount: "10000", selectionData: ["2020", "2021"])]
        
    }

    @IBAction func sortingButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewData[section].opened == true {
            return tableViewData[section].selectionData.count + 1
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = carsTableView.dequeueReusableCell(withIdentifier: "carCell") as! ResultCarsTableViewCell
            cell.carTypeLabel.text = tableViewData[indexPath.section].carType
            cell.carNameLabel.text = tableViewData[indexPath.section].carName
            cell.avaiLabelStatus.text = tableViewData[indexPath.section].avaiLabel
            
            cell.layer.cornerRadius = 10.0
//            cell.backgroundColor = .red
            return cell
        } else {
            let seconCell = carsTableView.dequeueReusableCell(withIdentifier: "carModelCell") as! ResultCarModelsTableViewCell
            seconCell.delegate1 = self
            seconCell.star1.setTitle("", for: .normal)
            seconCell.star2.setTitle("", for: .normal)
            seconCell.star3.setTitle("", for: .normal)
            seconCell.star4.setTitle("", for: .normal)
            seconCell.star5.setTitle("", for: .normal)
            
            seconCell.bookButton.backgroundColor = .buttonBackgroundColor
            
            
            return seconCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 145
        } else {
            return 75
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableViewData[indexPath.section].opened == true {
            tableViewData[indexPath.section].opened = false
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none)
        } else {
            tableViewData[indexPath.section].opened = true
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none)
        }
    }
    
}
