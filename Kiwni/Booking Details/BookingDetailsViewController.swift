//
//  BookingDetailsViewController.swift
//  Kiwni_User_App
//
//  Created by Shubham Shinde on 14/02/22.
//

import UIKit
import Reachability


struct ServiceType{
    var servicetypeName: String? = ""
    var servicetypeId : Int? = 0
}

class BookingDetailsViewController: UITableViewController, openPopUp {
    
    var companyNameString: String? = ""
    var companyEmailString: String? = ""
    var companyMobileNoString: String? = ""
    let reachability = try! Reachability()
    
    
    
    func openPopUp() {
        let VC = UIStoryboard(name: "FindCar", bundle: nil).instantiateViewController(withIdentifier: "BusinessDetaisViewController") as! BusinessDetaisViewController
        VC.callBack = { (companyNameVar: String, companyEmailVar: String, companyNumberVar: String) in
            print("Details:",companyNameVar,companyEmailVar,companyNumberVar)
            self.companyNameString = companyNameVar
            self.companyEmailString = companyEmailVar
            self.companyMobileNoString = companyNumberVar
            self.confXIB.companyNameValueLabel.text = self.companyNameString
            self.confXIB.companyEmailValueLabel.text = self.companyEmailString
            self.confXIB.companyPhoneValueLabel.text = self.companyMobileNoString
        }
        navigationController?.pushViewController(VC, animated: true)
    }
    
    func click() {
        print("click")
    }
    var selectedCarValue = carDetails()
    var strClasstype: String = ""
    var serviceTypeId: Int = 0
    var strGST: Double? = 0
    var strTotalFare: Double? = 0
    var strThirtyPercentFare: Double? = 0
    var strFiftyPercentFare: Double? = 0
    var resultVar = ""
    @IBOutlet weak var bookingDetilsView: UIView!
    @IBOutlet weak var safetyComView: UIView!
    @IBOutlet weak var kiniComfirtView: UIView!
    @IBOutlet weak var callButton: UIButton!
    var reservationTime : String! = ""
    var carImagePath: String = ""
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
    var serviceTypeArray =  [ServiceType]()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("carImagePath:", carImagePath)
        let url = URL(string: "https://kiwni.com/car_images/\(carImagePath)")
        let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
        bookingDetilsXIBView.carImage.image = UIImage(data: data!)
        
        print("selectedCarValue:", selectedCarValue)
        bookingDetilsView.addSubview(bookingDetilsXIBView)
        safetyComView.addSubview(confXIB)
        kiniComfirtView.isHidden = true
        
        button.addTarget(self, action: #selector(pressed), for: .touchUpInside)
        confXIB.delegate = self
        confXIB.rideFareAmountLabel.text = "₹ \(String(forTrailingZero(temp: round(selectedCarValue.estimatedPrice ?? 0))))"
        confXIB.applyCoupenAmountLabel.text = "0"
        
        strGST = ((round(selectedCarValue.estimatedPrice ?? 0) * 0.05))
        print("strGST:", strGST)
        confXIB.gstAmountLabel.text = "₹ \(String(forTrailingZero(temp: round(strGST ?? 0))))"
        
        strTotalFare = (round(selectedCarValue.estimatedPrice ?? 0) + round(strGST!) )
        print("strTotalFare:", strTotalFare)
        confXIB.totalAmountALble.text = "₹ \(String(forTrailingZero(temp: round(strTotalFare ?? 0))))"
        
        strThirtyPercentFare = (round(round(strTotalFare ?? 0) * 0.3))
        confXIB.pay30AmountLabel.text = "₹ \(String(forTrailingZero(temp: round((strThirtyPercentFare ?? 0)))))"
        
        strFiftyPercentFare = (round(round(strTotalFare ?? 0) * 0.5))
        confXIB.pay50AmountLabel.text = "₹ \(String(forTrailingZero(temp: round((strFiftyPercentFare ?? 0)))))"
        
        confXIB.pay100AmountLabel.text = "₹ \(String(forTrailingZero(temp: round((strTotalFare ?? 0)))))"
        
        confXIB.applyCoupenAmountLabel.text = "₹ 0"
        
        dateFormatter.locale = Locale(identifier: "IST")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let inputstring =  dateFormatter.string(from: Date())
        self.reservationTime = inputstring.replacingOccurrences(of: "+0530", with: "Z")
        print("reservationTime:\(self.reservationTime!))")
        
        let strServiceType : String = UserDefaults.standard.string(forKey:"serviceType") ?? ""
        let strdirection :String  =  UserDefaults.standard.string(forKey:"direction") ?? ""
        
        let rateStr : String = "\(strdirection)-\(strServiceType)-\(strClasstype.lowercased())"
        print("Rate Str : ", rateStr)
        
        serviceTypeArray = [ServiceType(servicetypeName: "one-way-outstation-premium", servicetypeId: 1),
                            ServiceType(servicetypeName: "one-way-outstation-luxury", servicetypeId: 2),
                            ServiceType(servicetypeName: "one-way-outstation-ultra-luxury", servicetypeId: 3),
                            ServiceType(servicetypeName: "two-way-outstation-premium", servicetypeId: 4),
                            ServiceType(servicetypeName: "two-way-outstation-luxury", servicetypeId: 5),
                            ServiceType(servicetypeName: "two-way-outstation-ultra-luxury", servicetypeId: 6)]
        
        var rateValueArray = selectedCarValue.rate
        print(rateValueArray.count, rateValueArray)
        
        for i in  0 ..< serviceTypeArray.count{
            if(rateStr == serviceTypeArray[i].servicetypeName){
                print("Match found")
                print(serviceTypeArray[i].servicetypeName)
                print(serviceTypeArray[i].servicetypeId)
                serviceTypeId = serviceTypeArray[i].servicetypeId ?? 0
                print(serviceTypeId)
                
            }else{
                print("No Match found")
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
        //        button.setTitle("PROCEED TO PAY", for: .normal)
        button.setTitle("CONFIRM BOOKING", for: .normal)
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
    
        let driverID = self.selectedCarValue.driverID ?? 0
        let driverLicense : String = ""
        let driverName : String = self.selectedCarValue.driverName ?? ""
        let driverPhone : String = self.selectedCarValue.driverPhone ?? ""
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
        
        let distance : String = UserDefaults.standard.string(forKey: "distance") ?? ""
        let fromLocation : String = UserDefaults.standard.string(forKey: "fromLocation") ?? ""
        let toLocation: String = UserDefaults.standard.string(forKey: "DestinationCityName") ?? ""
        let journeyEndTime : String = UserDefaults.standard.string(forKey: "journeyEndTime") ?? ""
        let journeyTime : String = UserDefaults.standard.string(forKey: "journeyTime") ?? ""
        
        
        let tripType : String = UserDefaults.standard.string(forKey: "selecttripType") ?? ""
        let notificationType : String = "Email,SMS,WhatsApp"
        
        let SourceCoordinate = UserDefaults.standard.object(forKey:"SourceCoordinate" ) as! [String : NSNumber]
        let userSourceLatitude  = SourceCoordinate["SourceLatitude"]
        let userSourceLongitude  = SourceCoordinate["SourceLongitude"]
        
        print(userSourceLatitude,userSourceLongitude)
        
        let DestinationCoordinate = UserDefaults.standard.object(forKey:"DestinationCoordinate" ) as! [String : NSNumber]
        let userDestinationLatitude  = DestinationCoordinate["DestinationLatitude"]
        let userDestinationLongitude  = DestinationCoordinate["DestinationLongitude"]
        print(userDestinationLatitude,userDestinationLongitude)
        
        let reservationModelData = ReservationScheduleModel(channel: Channel(id: 1), createdTime: "", createdUser: createdUser, customerEmail: customerEmail, customerID: Int(customerId) ?? 0, customerName: customerName, customerPhone: customerPhone, driverID: driverID  , driverLicense: driverLicense, driverName: driverName, driverPhone: driverPhone, providerID: provideridint, providerName: providerName, reservationTime: self.reservationTime, ride: Ride(createdTime: "", createdUser: createdUser, distance: distance, fromLocation: fromLocation, journeyEndTime: journeyEndTime, journeyTime: journeyTime, rates: [Channel(id: 1)], status: Channel(id: 2), toLocation: toLocation, updatedTime: "", updatedUser: "",fromLocationCoordinates: locationCoordinate(latitude: userSourceLatitude as? Double, longitude: userSourceLongitude as? Double), toLocationCoordinates: locationCoordinate(latitude: userDestinationLatitude as? Double, longitude: userDestinationLongitude as? Double)), scheduleID: Int(scheduleID)!, serviceType: Channel(id: serviceTypeId), status: Channel(id: 1), updatedTime: "", updatedUser: "", vehicleID: Int(exactly: vehicleID)!, estimatedPrice: strTotalFare ?? 0, vehicleNo: vehicleNumb , notificationType: notificationType, tripType: tripType, companyName: self.companyNameString ?? "", companyEmail: self.companyEmailString ?? "", companyPhone: self.companyMobileNoString ?? "")
        print("resevation Model :\(reservationModelData)")
        
        self.showIndicator(withTitle: "Loading", and: "Please Wait")
        
        
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
                                
                                DispatchQueue.main.async {
                                    let VC = UIStoryboard(name: "Payment", bundle: nil).instantiateViewController(withIdentifier: "paymentStoryboard") as! PaymentModeViewController
                                    self.navigationController?.pushViewController(VC, animated: true)
                                    
                                }
                                
                                
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
        
        //        }
    }
}
