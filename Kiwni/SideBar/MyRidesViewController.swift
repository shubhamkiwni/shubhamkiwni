//
//  MyRidesViewController.swift
//  Kiwni_User_App
//
//  Created by Shubham Shinde on 24/01/22.
//

import UIKit

class MyRidesViewController: UIViewController, MyRideDelegate, CancelRideDelegate {
    
    
    func cancelRide() {
        self.tripsArray.remove(at: indexForCell)
        tripsTableView.reloadData()
    }
    
    func didPressButton() {     
        let crvc = storyboard?.instantiateViewController(withIdentifier: "CancelRideViewController") as! CancelRideViewController
        present(crvc, animated: true, completion: nil)
    }
    
    var indexForCell = Int()
    var tripsArray = ["SHubham", "Pratik", "Swami"]
    var pastTripsArray = ["Shivani", "Preran", "Jinisha"]
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var myRideLable: UILabel!
    @IBOutlet weak var myRideView: UIView!
    @IBOutlet weak var tripButtonStackView: UIStackView!
    @IBOutlet weak var upcomingButton: UIButton!
    @IBOutlet weak var pastButton: UIButton!
    @IBOutlet weak var tripsTableView: UITableView!
    
    var passData = [Json4Swift_Base]()
    var db:DBHelper = DBHelper()
    var persons:[Person] = []
    
    var strTripType :  String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        upcomingButton.addBottomBorderWithColor(color: .gray, width: 2, frameWidth: upcomingButton.frame.width)
        
        self.tripsTableView.register(UpcomingTableViewCell.nib(), forCellReuseIdentifier: UpcomingTableViewCell.identifier)
        self.tripsTableView.register(PastTableViewCell.nib(), forCellReuseIdentifier: PastTableViewCell.identifier)
        
        if NetworkMonitor.share.isConnected == true {
            APIManager.shareInstance.callinggFindTripByUserID() { response in
                self.showIndicator(withTitle: "Loading", and: "Please Wait")
                switch response{
                case .success(let responseArray):
                    print("User Success on ViewController")
                    self.hideIndicator()
                    self.passData.append(contentsOf: responseArray)
                    print(self.passData.count)
                    
                    for i in self.passData {
                        self.db.deleteByID(id: Int(Double(i.id ?? 00)))
                    }
                    
                    for i in self.passData {
                        
                        self.db.insert(id: Double(i.id ?? 00), startLocationCity: i.startLocationCity ?? "", endlocationCity: i.endlocationCity ?? "", startTime: i.startTime ?? "", endTime: i.endTime ?? "", status: i.status ?? "", estimatedPrice: i.estimatedPrice ?? 00, serviceType: i.serviceType ?? "")
                    }
                    
                    self.persons = self.db.read()
                    self.strTripType = "Past" //"Upcoming"
                    self.tripsTableView.reloadData()
                    print("Count:",self.persons.count)
//                    print("Data:", self.persons[0].id)
                    
                    print("User Success on ViewController")
                    
                case .failure(let err) :
                    self.hideIndicator()
                    print(err.localizedDescription)
                    print("User Fail on ViewController")
                }
            }
        } else {
            self.persons = self.db.read()
            print("Count:",self.persons.count)
//            print("Data:", self.persons[0].id)
        }
        
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {

        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func upcomingButtonPressed(_ sender: UIButton) {
        print("upcomingButtonPressed")
        
        strTripType = "Upcoming"
       // tripsTableView.reloadData()
        customErrorPopup("No Upcoming Trip found.")
        upcomingButton.addBottomBorderWithColor(color: .gray, width: 2, frameWidth: upcomingButton.frame.width)
        pastButton.addBottomBorderWithColor(color: .white, width: 2, frameWidth: upcomingButton.frame.width)
        
    }
    @IBAction func pastButtonPressed(_ sender: UIButton) {
        print("pastButtonPressed")
        strTripType = "Past"
        tripsTableView.reloadData()
        pastButton.addBottomBorderWithColor(color: .gray, width: 2, frameWidth: upcomingButton.frame.width)
        upcomingButton.addBottomBorderWithColor(color: .white, width: 2, frameWidth: upcomingButton.frame.width)
    }
}

extension MyRidesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(strTripType == "Upcoming"){
            return 0 //tripsArray.count
        }else{
            return persons.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(strTripType == "Upcoming") {
            let cell:UpcomingTableViewCell = tableView.dequeueReusableCell(withIdentifier: "UpcomingTableViewCell") as! UpcomingTableViewCell
            cell.delegate = self
            cell.cancelDelegate = self
            
            indexForCell = indexPath.row
            return cell
        } else {
            let cell:PastTableViewCell = tableView.dequeueReusableCell(withIdentifier: "PastTableViewCell") as! PastTableViewCell
            cell.sourceLable.text = persons[indexPath.row].startLocationCity
            cell.destinationLable.text = persons[indexPath.row].endlocationCity
            cell.tripTypelable.text = persons[indexPath.row].serviceType
            cell.fareAmount.text = "Rs. \(String(persons[indexPath.row].estimatedPrice))"
            cell.tripStatusLable.text = persons[indexPath.row].status
            let startTime = persons[indexPath.row].startTime
            print("Table Start Time : ", startTime)
            
            if let pickUpDate = DateFormattingHelper.strToDateTime(strDateTime: startTime)
            {
                print("myDate: ", pickUpDate)
                let formatter = DateFormatter()
                
                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
                formatter.timeZone = TimeZone(identifier: "UTC")
                let myString = formatter.string(from: pickUpDate)
                let yourDate: Date? = formatter.date(from: myString)
                formatter.dateFormat = "dd-MM-yyyy"
                let dateStr = formatter.string(from: yourDate!)
                print("dateStr : ", dateStr)
                
                formatter.dateFormat = "hh:mm a"
                let timeStr = formatter.string(from: yourDate!)
                print("timeStr : ", timeStr)
                cell.pickUpdateTimeLable.text  = "\(dateStr) on \(timeStr)"
                
            }
            
            let endTime = persons[indexPath.row].endTime
            print("Table Start Time : ", startTime)
            
            if let dropDate = DateFormattingHelper.strToDateTime(strDateTime: endTime)
            {
                print("myDate: ", dropDate)
                let formatter = DateFormatter()
                
                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
                formatter.timeZone = TimeZone(identifier: "UTC")
                let myString = formatter.string(from: dropDate)
                let yourDate: Date? = formatter.date(from: myString)
                formatter.dateFormat = "dd-MM-yyyy"
                let dateStr = formatter.string(from: yourDate!)
                print("dateStr : ", dateStr)
                
                formatter.dateFormat = "hh:mm a"
                let timeStr = formatter.string(from: yourDate!)
                print("timeStr : ", timeStr)
                cell.dropDateTimeLable.text  = "\(dateStr) on \(timeStr)"
                
            }
                        
            return cell
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cell:UpcomingTableViewCell = tableView.dequeueReusableCell(withIdentifier: "UpcomingTableViewCell") as! UpcomingTableViewCell
        if(strTripType == "Upcoming") {
            if cell.carDetailsView.isHidden == true {
                return 275
            } else {
                return 385
            }
        } else {
            return 170
        }
    }
    
}
