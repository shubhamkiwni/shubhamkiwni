//
//  BookingDetailsViewController.swift
//  Kiwni_User_App
//
//  Created by Shubham Shinde on 14/02/22.
//

import UIKit

class BookingDetailsViewController: UITableViewController, openPopUp {
    func openPopUp() {
        let VC = UIStoryboard(name: "FindCar", bundle: nil).instantiateViewController(withIdentifier: "BusinessDetaisViewController") as! BusinessDetaisViewController
        navigationController?.pushViewController(VC, animated: true)
    }
    
    func click() {
        print("click")
    }
    
    
    
    var resultVar = ""
    @IBOutlet weak var bookingDetilsView: UIView!
    @IBOutlet weak var safetyComView: UIView!
    @IBOutlet weak var kiniComfirtView: UIView!
    var bookingArray = [""]
    
    let bookingDetilsXIBView: BookingAddressXIB = UINib(nibName: "BookingAddressXIB", bundle: Bundle.main).instantiate(withOwner: nil, options: nil)[0] as! BookingAddressXIB
    
    let safetyComXIBView: SafetyCompliancesXIB = UINib(nibName: "SafetyCompliancesXIB", bundle: Bundle.main).instantiate(withOwner: nil, options: nil)[0] as! SafetyCompliancesXIB
    
    let kiwniComfirtXIBView: KiwniComfirtXIB = UINib(nibName: "KiwniComfirtXIB", bundle: Bundle.main).instantiate(withOwner: nil, options: nil)[0] as! KiwniComfirtXIB
    let confXIB: confirmBooking = UINib(nibName: "confirmBooking", bundle: Bundle.main).instantiate(withOwner: nil, options: nil)[0] as! confirmBooking
   
    
    @IBOutlet weak var backButton: UIButton!
    
    
    let footerView = UIView()
    let button = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bookingDetilsView.addSubview(bookingDetilsXIBView)
        safetyComView.addSubview(safetyComXIBView)
        kiniComfirtView.addSubview(kiwniComfirtXIBView)
        safetyComView.addSubview(confXIB)
        confXIB.isHidden = true
        button.addTarget(self, action: #selector(pressed), for: .touchUpInside)
        confXIB.delegate = self
    }
    
    
    @IBAction func backButton(_ sender: UIButton) {
        if safetyComXIBView.isHidden == true {
            confXIB.isHidden = true
            safetyComXIBView.isHidden = false
            kiniComfirtView.isHidden = false
            kiwniComfirtXIBView.isHidden = false
            print("hide confirm booking")
        } else if resultVar == "Result" {
            
                let hvc = navigationController?.viewControllers[6] as! ResultViewController
                navigationController?.popToViewController(hvc, animated: true)
                print("back to car models view")
            
        } else {
                let hvc = navigationController?.viewControllers[4] as! CarsViewController
                navigationController?.popToViewController(hvc, animated: true)
                print("back to car models view")
        }
    }
    
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        footerView.backgroundColor = .clear
        footerView.frame = CGRect(x: 0, y: 10, width: self.tableView.frame.width, height: 100)
        
        button.frame = CGRect(x: 80, y: 10, width: self.tableView.frame.width - 150, height: 40)
        button.setTitle("PROCEED TO PAY", for: .normal)
        button.setTitleColor( .white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 10.0
        footerView.addSubview(button)
        return footerView
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 80
    }
    
    @objc func pressed() {
        print("PROCEED TO PAY")
        
        if safetyComXIBView.isHidden == false {
            confXIB.isHidden = false
            safetyComXIBView.isHidden = true
            kiniComfirtView.isHidden = true
            kiwniComfirtXIBView.isHidden = true
            button.setTitle("CONFIRM BOOKING", for: .normal)
        } else {
//            let pmVC = storyboard?.instantiateViewController(withIdentifier: "PaymentModeViewController") as! PaymentModeViewController
//            navigationController?.pushViewController(pmVC, animated: true)
            let VC = UIStoryboard(name: "Payment", bundle: nil).instantiateViewController(withIdentifier: "paymentStoryboard") as! PaymentModeViewController
            navigationController?.pushViewController(VC, animated: true)
        }
    }
}




