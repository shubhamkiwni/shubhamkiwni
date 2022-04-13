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
    
    var selectedCarValue = carDetails()
    
    var resultVar = ""
    @IBOutlet weak var bookingDetilsView: UIView!
    @IBOutlet weak var safetyComView: UIView!
    @IBOutlet weak var kiniComfirtView: UIView!
    @IBOutlet weak var callButton: UIButton!
    var reservationTime : String! = ""
    
    let dateFormatter = DateFormatter()

    
    var bookingArray = [""]
    
    let bookingDetilsXIBView: BookingAddressXIB = UINib(nibName: "BookingAddressXIB", bundle: Bundle.main).instantiate(withOwner: nil, options: nil)[0] as! BookingAddressXIB
    
    let safetyComXIBView: SafetyCompliancesXIB = UINib(nibName: "SafetyCompliancesXIB", bundle: Bundle.main).instantiate(withOwner: nil, options: nil)[0] as! SafetyCompliancesXIB
    
    let kiwniComfirtXIBView: KiwniComfirtXIB = UINib(nibName: "KiwniComfirtXIB", bundle: Bundle.main).instantiate(withOwner: nil, options: nil)[0] as! KiwniComfirtXIB
    let confXIB: confirmBooking = UINib(nibName: "confirmBooking", bundle: Bundle.main).instantiate(withOwner: nil, options: nil)[0] as! confirmBooking
    
    
    @IBOutlet weak var backButton: UIButton!
    
    
    let footerView = UIView()
    let button = UIButton()
    
    
    var bookedVehicleDetails : [VehicleDetails] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("selectedCarValue:", selectedCarValue)
        bookingDetilsView.addSubview(bookingDetilsXIBView)
        safetyComView.addSubview(safetyComXIBView)
        kiniComfirtView.addSubview(kiwniComfirtXIBView)
        safetyComView.addSubview(confXIB)
        confXIB.isHidden = true
        button.addTarget(self, action: #selector(pressed), for: .touchUpInside)
        confXIB.delegate = self
        dateFormatter.locale = Locale(identifier: "IST")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let inputstring =  dateFormatter.string(from: Date())
        self.reservationTime = inputstring.replacingOccurrences(of: "+0530", with: "Z")
        print("reservationTime:\(self.reservationTime!))")
    }
    
    
    @IBAction func backButton(_ sender: UIButton) {
        if safetyComXIBView.isHidden == true {
            confXIB.isHidden = true
            safetyComXIBView.isHidden = false
            kiniComfirtView.isHidden = false
            kiwniComfirtXIBView.isHidden = false
            print("hide confirm booking")
        } else if resultVar == "Result" {
            
            navigationController?.popViewController(animated: true)
            
        } else {
            //                let hvc = navigationController?.viewControllers[4] as! CarsViewController
            //                navigationController?.popToViewController(hvc, animated: true)
            navigationController?.popViewController(animated: true)
            print("back to car models view")
        }
    }
    
    @IBAction func callButtonAction(_ sender: UIButton) {
        if let phoneCallURL = URL(string: "telprompt://8308628266") {
            
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                if #available(iOS 10.0, *) {
                    application.open(phoneCallURL, options: [:], completionHandler: nil)
                } else {
                    // Fallback on earlier versions
                    application.openURL(phoneCallURL as URL)
                    
                }
            }
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
            
            let driverID = self.selectedCarValue.driverID ?? 0
            let driverLicense : String = ""
            let driverName : String = self.selectedCarValue.driverName ?? ""
            let driverPhone : String = self.selectedCarValue.driverPhone ?? ""
            //        var providerId : Int = 0
            //        providerId = (self.vehicleSchedule.vehicle?.provider?.id) ?? 0
            let providerId :String = self.selectedCarValue.providerID ?? ""
            
            let createdUser: String = UserDefaults.standard.string(forKey: "displayName") ?? ""
            let customerEmail : String = UserDefaults.standard.string(forKey: "email") ?? ""
            let customerId : String = UserDefaults.standard.string(forKey: "partyId") ?? ""
            let customerName : String = UserDefaults.standard.string(forKey: "displayName") ?? ""
            let customerPhone :  String = UserDefaults.standard.string(forKey: "phoneNumber") ?? ""
            
            var provideridint : Int = 0
            provideridint = Int(providerId) ?? 0
            print("Provider id : \(provideridint)")
            
            let estimatedPrice : Double
            estimatedPrice = round(selectedCarValue.estimatedPrice ?? 0)
            print("Estimated price:\(estimatedPrice)")
            
            let providerName : String = (self.selectedCarValue.providername) ?? ""
            let scheduleID : String = String((self.selectedCarValue.scheduleID ?? 0))
            let vehicleID : Int = (self.selectedCarValue.vehicalID)!
            let vehicleNumb : String = self.selectedCarValue.vehicleNumb ?? ""
            
            //   let createdTime :  String = String(UserDefaults.standard.string(forKey: "partyId")!)
            //   let createdUser : String = String(UserDefaults.standard.string(forKey: "partyId")!)
            let distance : String = UserDefaults.standard.string(forKey: "distance") ?? ""
            let fromLocation : String = UserDefaults.standard.string(forKey: "fromLocation") ?? ""
            let toLocation: String = UserDefaults.standard.string(forKey: "DestinationCityName") ?? ""
            let journeyEndTime : String = UserDefaults.standard.string(forKey: "journeyEndTime") ?? ""
            let journeyTime : String = UserDefaults.standard.string(forKey: "journeyTime") ?? ""
            
            
            let reservationModelData = ReservationScheduleModel(channel: Channel(id: 1), createdTime: "", createdUser: createdUser, customerEmail: customerEmail, customerID: Int(customerId) ?? 0, customerName: customerName, customerPhone: customerPhone, driverID: driverID  , driverLicense: driverLicense, driverName: driverName, driverPhone: driverPhone, providerID: provideridint, providerName: providerName, reservationTime: self.reservationTime, ride: Ride(createdTime: "", createdUser: createdUser, distance: distance, fromLocation: fromLocation, journeyEndTime: journeyEndTime, journeyTime: journeyTime, rates: [Channel(id: 1)], status: Channel(id: 2), toLocation: toLocation, updatedTime: "", updatedUser: ""), scheduleID: Int(scheduleID)!, serviceType: Channel(id: 1), status: Channel(id: 1), updatedTime: "", updatedUser: "", vehicleID: Int(exactly: vehicleID)!, estimatedPrice: estimatedPrice, vehicleNo: vehicleNumb)
            print("resevation Model :\(reservationModelData)")
            
            self.showIndicator(withTitle: "Loading", and: "Please Wait")
            
            //        if (NetworkMonitor.share.isConnected == false){
            //            self.showToast(string: "Please Check your internet connection")
            //            return
            //        }
            
            APIManager.shareInstance.createReservationForVehicleSchedule(getReservationModel: reservationModelData, completionHandler: { result in
                switch result {
                case .success(let reservationResponse):
                    
                    self.hideIndicator()
                    
                    print("ReservationResponse : \(reservationResponse)")
                    print("Payment Button Pressed")
                    
                    let VC = UIStoryboard(name: "Payment", bundle: nil).instantiateViewController(withIdentifier: "paymentStoryboard") as! PaymentModeViewController
                    self.navigationController?.pushViewController(VC, animated: true)
                    
                case .failure(let error):
                    //                    self.view.makeToast(ErrorMessage.list.sessionexpired)
                    //                    self.view.makeToast(ErrorMessage.list.pleasewait)
                    
                    self.showIndicator(withTitle: "Loading", and: "Please wait your request is processing.")
                    
                    print(error)
                    
                    let refresh_token = UserDefaults.standard.string(forKey: "refreshToken")
                    print("Refreshtoken for requestPayload: \(refresh_token ?? "0")")
                    
                    let requestpayload = FirebaseRequestPayload(grant_type:"refresh_token", refresh_token: refresh_token ?? "0" )
                    
                    print("RequestPayload : ", requestpayload)
                    
                    APIManager.shareInstance.getRefreshToken(requestpayloadModel: requestpayload, completionHandler: { result in
                        self.hideIndicator()
                        print("Refresh Token result :\(result)")
                        
                        switch result {
                        case .success(let reservationResponse):
                            
                            let revisedtoken = reservationResponse.id_token
                            
                            //                            UserDefaults.standard.set("", forKey: "idToken")
                            
                            UserDefaults.standard.removeObject(forKey: "idToken")
                            UserDefaults.standard.setValue(revisedtoken, forKey: "idToken")
                            
                            APIManager.shareInstance.createReservationForVehicleSchedule(getReservationModel: reservationModelData, completionHandler: { result in
                                switch result {
                                case .success(let reservationResponse):
                                    
                                    print("ReservationResponse : \(reservationResponse)")
                                    print("Payment Button Pressed")
                                    
                                    let VC = UIStoryboard(name: "Payment", bundle: nil).instantiateViewController(withIdentifier: "paymentStoryboard") as! PaymentModeViewController
                                    self.navigationController?.pushViewController(VC, animated: true)
                                    
                                case .failure(let error):
                                    
                                    self.view.makeToast(ErrorMessage.list.internalserver)
                                    print("Error from failure", error)
                                    
                                }
                                self.hideIndicator()
                            })
                        case .failure(_):
                            
                            break
                            
                        }
                        
                    })
                    
                }
            })
            
        }
    }
}
