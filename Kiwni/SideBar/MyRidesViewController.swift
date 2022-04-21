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
    var tripsArray = [String]()
    var pastTripsArray = ["Shivani", "Preran", "Jinisha"]
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var myRideLable: UILabel!
    @IBOutlet weak var myRideView: UIView!
    @IBOutlet weak var tripButtonStackView: UIStackView!
    @IBOutlet weak var upcomingButton: UIButton!
    @IBOutlet weak var pastButton: UIButton!
    @IBOutlet weak var tripsTableView: UITableView!
    
    var passData = [Json4Swift_Base]()
    var inProgressTripArray = [Json4Swift_Base]()
    var db:DBHelper = DBHelper()
    var persons:[Person] = []
    
    var strTripType :  String = ""
    let formatter = DateFormatter()
    override func viewDidLoad() {
        super.viewDidLoad()
        upcomingButton.addBottomBorderWithColor(color: .gray, width: 2, frameWidth: upcomingButton.frame.width)
        
        
        
        self.tripsTableView.register(UpcomingTableViewCell.nib(), forCellReuseIdentifier: UpcomingTableViewCell.identifier)
        self.tripsTableView.register(PastTableViewCell.nib(), forCellReuseIdentifier: PastTableViewCell.identifier)
        
        
        
        APIManager.shareInstance.callinggInProgressTripRequest() { response in
            self.showIndicator(withTitle: "Loading", and: "Please Wait")
            switch response{
            case .success(let inProgressResponse):
                self.hideIndicator()
                print("In progress responseArray:", inProgressResponse)
                self.inProgressTripArray.append(contentsOf: inProgressResponse)
                print("count:",self.inProgressTripArray.count)
                self.tripsTableView.reloadData()
            case .failure(let err) :
                self.hideIndicator()
                print(err.localizedDescription)
                print("User Fail on ViewController")
            }
        }
       
        
        
        if NetworkMonitor.share.isConnected == true {
            APIManager.shareInstance.callinggFindTripByUserID() { response in
                
                switch response{
                case .success(let responseArray):
                    print("User Success on ViewController")
                    
                    self.passData.append(contentsOf: responseArray)
                    print(self.passData.count)
                    
                    for i in self.passData {
                        self.db.deleteByID(id: Int(Double(i.id ?? 00)))
                    }
                    
                    for i in self.passData {
                        
                        self.db.insert(id: Double(i.id ?? 00), startLocationCity: i.startLocationCity ?? "", endlocationCity: i.endlocationCity ?? "", startTime: i.startTime ?? "", endTime: i.endTime ?? "", status: i.status ?? "", estimatedPrice: i.estimatedPrice ?? 00, serviceType: i.serviceType ?? "")
                    }
                    
                    self.persons = self.db.read()
                    self.strTripType = "Upcoming"
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
//            self.persons = self.db.read()
//            print("Count:",self.persons.count)
//            print("Data:", self.persons[0].id)
            customErrorPopup("No Internet Connection Found")
        }
        
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {

        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func upcomingButtonPressed(_ sender: UIButton) {
        print("upcomingButtonPressed")
        
        if inProgressTripArray.isEmpty {
            tripsTableView.isHidden = true
            customErrorPopup("No upcoming Trip found.")
            
        }
        
        strTripType = "Upcoming"
        tripsTableView.reloadData()
        
        upcomingButton.addBottomBorderWithColor(color: .gray, width: 2, frameWidth: upcomingButton.frame.width)
        pastButton.addBottomBorderWithColor(color: .white, width: 2, frameWidth: upcomingButton.frame.width)
        
    }
    @IBAction func pastButtonPressed(_ sender: UIButton) {
        if passData.isEmpty {
            tripsTableView.isHidden = true
            customErrorPopup("No past Trip found.")
            
        }
        print("pastButtonPressed")
        strTripType = "Past"
        tripsTableView.isHidden = false
        tripsTableView.reloadData()
        pastButton.addBottomBorderWithColor(color: .gray, width: 2, frameWidth: upcomingButton.frame.width)
        upcomingButton.addBottomBorderWithColor(color: .white, width: 2, frameWidth: upcomingButton.frame.width)
    }
}

extension MyRidesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(strTripType == "Upcoming"){
            return inProgressTripArray.count
        }else{
            return persons.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(strTripType == "Upcoming") {
            let cell:UpcomingTableViewCell = tableView.dequeueReusableCell(withIdentifier: "UpcomingTableViewCell") as! UpcomingTableViewCell
            
            if inProgressTripArray[indexPath.row].driver?.name != "" {
                print("Driver details availabel")
                let fullString: String = inProgressTripArray[indexPath.row].driver?.name ?? ""
                let fullSeperatedArr = fullString.components(separatedBy: " ")
                let seperatedName: String = fullSeperatedArr[0]
                cell.driverNameLabel.text = seperatedName
                cell.mobileNumberLabel.text = inProgressTripArray[indexPath.row].driver?.mobile
                cell.vehicalNumberLabel.text = inProgressTripArray[indexPath.row].vehcileNo
                cell.otpValue.text = inProgressTripArray[indexPath.row].otp
                cell.bookingDetailsView.isHidden = true
                cell.notificationView.isHidden = true
            } else {
                cell.bookingDetailsView.isHidden = false
                cell.notificationView.isHidden = false
                cell.carDetailsView.isHidden = true
            }
            
            cell.sourceLabel.text = inProgressTripArray[indexPath.row].startLocationCity
            cell.destinationLabel.text = inProgressTripArray[indexPath.row].endlocationCity
            
            let fullString: String = inProgressTripArray[indexPath.row].serviceType ?? ""
            let fullSeperatedArr = fullString.components(separatedBy: "-")
            let seperatedTripType: String = fullSeperatedArr[0]
            let seperatedTripType2: String = fullSeperatedArr[1]
            let seperatedServiceType: String = fullSeperatedArr[2]
            let seperatedCarType: String = fullSeperatedArr[3]
            print("Seperated Strings",seperatedTripType, seperatedTripType2, seperatedServiceType, seperatedCarType)
            cell.serviceTypeValue.text = seperatedServiceType
            
            let upcomingTripTime = inProgressTripArray[indexPath.row].startTime
            if let dropDate = DateFormattingHelper.strToDateTime(strDateTime: upcomingTripTime) {
                print("upComingDate: ", dropDate)
                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
                formatter.timeZone = TimeZone(identifier: "UTC")
                let myString = formatter.string(from: dropDate)
                let yourDate: Date? = formatter.date(from: myString)
                formatter.dateFormat = "dd-MM-yyyy"
                let dateStr = formatter.string(from: yourDate!)
                print("dateStr : ", dateStr)
                cell.dateLabel.text = dateStr
                formatter.dateFormat = "hh:mm a"
                let timeStr = formatter.string(from: yourDate!)
                print("timeStr : ", timeStr)
                cell.timeLabel.text = timeStr
                
            }
            
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
            
            if let dropDate = DateFormattingHelper.strToDateTime(strDateTime: endTime) {
                print("myDate: ", dropDate)
                
                
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
            if inProgressTripArray[indexPath.row].driver?.name == "" {
                return 275
            } else {
                return 305
            }
        } else {
            return 170
        }
    }
    
}
