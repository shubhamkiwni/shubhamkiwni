//
//  MyRidesViewController.swift
//  Kiwni_User_App
//
//  Created by Shubham Shinde on 24/01/22.
//

import UIKit
import Reachability

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
    
    var pastTripArray = [Json4Swift_Base]()
    var sortedPastTripArray = [Json4Swift_Base]()
    var upcomingTripArray = [Json4Swift_Base]()
    var db:DBHelper = DBHelper()
    var persons:[Person] = []
    
    var strTripType :  String = ""
    let formatter = DateFormatter()
    let reachability = try! Reachability()
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
                self.upcomingTripArray.append(contentsOf: inProgressResponse)
                print("count:",self.upcomingTripArray.count)
                self.tripsTableView.reloadData()
            case .failure(let err) :
                self.hideIndicator()
                print(err.localizedDescription)
                print("User Fail on ViewController")
            }
        }
            APIManager.shareInstance.callinggFindTripByUserID() { response in
                switch response{
                case .success(let responseArray):
                    print("User Success on ViewController")
                    
                    self.pastTripArray.append(contentsOf: responseArray)
                    print(self.pastTripArray.count)
                    
                    for i in self.pastTripArray {
                         if i.status != "In-Progress"{
                             
                             self.sortedPastTripArray.append(i)
                             print("sortedPastTripArray Count: ", self.sortedPastTripArray.count)
                         } else {
                             print("other trips are In-progress")
                         }
                     }
                    
                    print("Sorted Past Trip",self.sortedPastTripArray)
                    print("sortedPastTripArray Count: ", self.sortedPastTripArray.count)
                    
                    
                    for i in self.sortedPastTripArray {
                        self.db.deleteByID(id: Int(Double(i.id ?? 00)))
                    }
                    
                    for i in self.sortedPastTripArray {
                        
                        self.db.insert(id: Double(i.id ?? 00), startLocationCity: i.startLocationCity ?? "", endlocationCity: i.endlocationCity ?? "", startTime: i.startTime ?? "", endTime: i.endTime ?? "", status: i.status ?? "", estimatedPrice: i.estimatedPrice ?? 00, serviceType: i.serviceType ?? "")
                    }
                    
                    self.persons = self.db.read()
                    self.strTripType = "Upcoming"
                    self.tripsTableView.reloadData()
                    print("persons Count:",self.persons.count)
//                    print("Data:", self.persons[0].id)
                    
                    print("User Success on ViewController")
                    
                case .failure(let err) :
                    self.hideIndicator()
                    print(err.localizedDescription)
                    print("User Fail on ViewController")
                }
            }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        DispatchQueue.main.async {
            self.reachability.whenReachable = { reachability in
                if reachability.connection == .wifi {
                    print(" Reachable via wifir")
                } else {
                    print("Reachable via Cellular")
                }
                self.noInternetErrorPopupHide()
            }
            self.reachability.whenUnreachable = { _ in
                print("Not reachable")
                self.noInternetErrorPopupShow("No Internet Connection")
            }

            do {
                try self.reachability.startNotifier()
            } catch {
                print("Unable to start notifier")
            }
        }
    }
    
    deinit{
        reachability.stopNotifier()
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {

        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func upcomingButtonPressed(_ sender: UIButton) {
        print("upcomingButtonPressed")
        
        if upcomingTripArray.isEmpty {
            tripsTableView.isHidden = true
            customErrorPopup("No upcoming Trip found.")
            
        }
        
        strTripType = "Upcoming"
        tripsTableView.reloadData()
        
        upcomingButton.addBottomBorderWithColor(color: .gray, width: 2, frameWidth: upcomingButton.frame.width)
        pastButton.addBottomBorderWithColor(color: .white, width: 2, frameWidth: upcomingButton.frame.width)
        
    }
    @IBAction func pastButtonPressed(_ sender: UIButton) {
        if sortedPastTripArray.isEmpty {
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
            return upcomingTripArray.count
        }else{
            return sortedPastTripArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(strTripType == "Upcoming") {
            let cell:UpcomingTableViewCell = tableView.dequeueReusableCell(withIdentifier: "UpcomingTableViewCell") as! UpcomingTableViewCell
            
            if upcomingTripArray[indexPath.row].driver?.name != "" {
                print("Driver details availabel")
                let fullString: String = upcomingTripArray[indexPath.row].driver?.name ?? ""
                let fullSeperatedArr = fullString.components(separatedBy: " ")
                let seperatedName: String = fullSeperatedArr[0]
                cell.driverNameLabel.text = seperatedName
                cell.mobileNumberLabel.text = upcomingTripArray[indexPath.row].driver?.mobile
                cell.vehicalNumberLabel.text = upcomingTripArray[indexPath.row].vehcileNo
                
                let dataDecoded:NSData = NSData(base64Encoded:  self.upcomingTripArray[indexPath.row].otp ?? "", options: NSData.Base64DecodingOptions(rawValue: 0))!
                let decodedString = String(data: dataDecoded as Data, encoding: .utf8)!
                print("OTP after decoding: ", decodedString)
                cell.otpValue.text = "OTP:\(decodedString)"
                
//                cell.otpValue.text = upcomingTripArray[indexPath.row].otp
                cell.bookingDetailsView.isHidden = true
                cell.notificationView.isHidden = true
            } else {
                cell.bookingDetailsView.isHidden = false
                cell.notificationView.isHidden = false
                cell.carDetailsView.isHidden = true
            }
            
            cell.sourceLabel.text = upcomingTripArray[indexPath.row].startLocationCity
            cell.destinationLabel.text = upcomingTripArray[indexPath.row].endlocationCity
            
            let fullString: String = upcomingTripArray[indexPath.row].serviceType ?? ""
            let fullSeperatedArr = fullString.components(separatedBy: "-")
            let seperatedTripType: String = fullSeperatedArr[0]
            let seperatedTripType2: String = fullSeperatedArr[1]
            let seperatedServiceType: String = fullSeperatedArr[2]
            let seperatedCarType: String = fullSeperatedArr[3]
            print("Seperated Strings",seperatedTripType, seperatedTripType2, seperatedServiceType, seperatedCarType)
            cell.serviceTypeValue.text = seperatedServiceType
            
            let upcomingTripTime = upcomingTripArray[indexPath.row].startTime
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
            cell.sourceLable.text = sortedPastTripArray[indexPath.row].startLocationCity
            cell.destinationLable.text = sortedPastTripArray[indexPath.row].endlocationCity
            cell.tripTypelable.text = sortedPastTripArray[indexPath.row].serviceType
            cell.fareAmount.text = "Rs. \(String(persons[indexPath.row].estimatedPrice))"
            cell.tripStatusLable.text = sortedPastTripArray[indexPath.row].status
            let startTime = sortedPastTripArray[indexPath.row].startTime
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
            
            let endTime = sortedPastTripArray[indexPath.row].endTime
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
            if upcomingTripArray[indexPath.row].driver?.name == "" {
                return 275
            } else {
                return 305
            }
        } else {
            return 170
        }
    }
    
}
