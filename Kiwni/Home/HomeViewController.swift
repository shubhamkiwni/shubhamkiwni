//
//  ViewController.swift
//  Kiwni_User_App
//
//  Created by Shubham Shinde on 20/01/22.
//

import UIKit
import GoogleMaps
import GooglePlaces
import Alamofire
import DropDown
import Reachability

var tabletagArray = [0]
var dateTag: Int = 0
var rentalTag: Int = 0
var timeTag: Int = 0

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, GMSMapViewDelegate, dropOnlocateSearchdelegate, UITextFieldDelegate, pickupOnlocateSearchdelegate {
    
    
    //MARK:- View Outlet
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view5: UIView!
    @IBOutlet weak var view6: UIView!
    @IBOutlet weak var tripTypeCollectionView: UICollectionView!
    
    @IBOutlet weak var sideMenuButton: UIButton!
    @IBOutlet weak var faviourateButton: UIButton!
    
    @IBOutlet weak var viewCabsButton: UIButton!
    @IBOutlet weak var pickUpOnLable: UILabel!
    @IBOutlet weak var returnByLable: UILabel!
    @IBOutlet weak var dateTimePickupView: UIView!
    
    //MARK :- DatePicker Outlet
    @IBOutlet weak var pickUpDatePickerButton: UIButton!
    @IBOutlet weak var returnByDatePickerButton: UIButton!
    
    
    @IBOutlet weak var pickUpOnTimePickerButton: UIButton!
    @IBOutlet weak var callButton: UIButton!
    
    @IBOutlet weak var rentalSelectaPackageLable: UILabel!
    @IBOutlet weak var hoursPackegeCollectionView: UICollectionView!
    @IBOutlet weak var btnConfirmLocation : UIButton!
    
    @IBOutlet weak var selectPackageView: UIView!
    @IBOutlet weak var baseStackView: UIStackView!
    
    //MARK:- Textfield Address  Outlet
    @IBOutlet weak var pickUpTextField: UITextField!
    @IBOutlet weak var dropTextField: UITextField!
    
    //MARK:- Outstation Direction Buttons
    @IBOutlet weak var roundTripButton: UIButton!
    @IBOutlet weak var oneWayButton: UIButton!
    
    // MARK:- Socket Popup Outlet
    @IBOutlet weak var driverSchedulePopUpStackView: UIStackView!
    @IBOutlet weak var rideScheduleView: UIView!
    @IBOutlet weak var driverContactDetailsView: UIView!
    @IBOutlet weak var tripDetailsView: UIView!
    
    //    @IBOutlet weak var driverSchedulePopup : UIView!
    @IBOutlet weak var krnNumLabel: UILabel!
    @IBOutlet weak var onewaytripLabel: UILabel!
    @IBOutlet weak var driverImageView: UIImageView!
    @IBOutlet weak var estimatedFareValueLabel: UILabel!
    @IBOutlet weak var estimateFareLabel : UILabel!
    @IBOutlet weak var rideScheduleLabel: UILabel!
    @IBOutlet weak var scheduledateLabel: UILabel!
    @IBOutlet weak var drivercontactLabel : UILabel!
    @IBOutlet weak var seperatorLabel : UILabel!
    @IBOutlet weak var drivervehiclevalueLabel : UILabel!
    @IBOutlet weak var drivernameLabel : UILabel!
    @IBOutlet weak var driverOTPLabel : UILabel!
    @IBOutlet weak var doneButton : UIButton!
    @IBOutlet weak var driverCallButton: UIButton!
    
    //MARK:- MapView
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var locatePinImage : UIImageView!
    var placesClient: GMSPlacesClient!
    var currentLocation: GMSPlace?
    var selectedFromDestination: GMSPlace?
    var selectedToDestination: GMSPlace?
    var likeHoodList: GMSPlaceLikelihoodList?
    
    var selectedPickUpAddress: String = ""
    var selectedDropAddress: String = ""
    var strTxtFieldType : String = ""
    var sourceCoordinate: CLLocationCoordinate2D!
    var destinationCoordinate: CLLocationCoordinate2D!
    
    var sourceMarker: GMSMarker! = nil
    var destinationMarker : GMSMarker! = nil
    
    var pickupName : String? = ""
    var pickupcityName  : String? = ""
    var destinationcityName : String? = ""
    
    var destionationName : String? = ""
    var pickupDateAndTime : String? = ""
    var dropDateAndTime : String? = ""
    var strSelectedTime : String? = ""
    var journeystartTime : String? = ""
    var journeyendTime : String? = ""
    var journeyDate : String? = ""
    var strDirection : String? = ""
    var strServiceType: String? = ""
    var strButtonTitle : String? = ""
    var userCurrentlocation: CLLocationCoordinate2D!
    var usercurrentLocationAddress : String? = ""
    
    //
    var selectedPickUpDate = Date()
    var selectedReturnDate = Date()
    
    var isconfirmLocation : Bool = false
    
    var responseArr : NSArray!
    
    var locationManager: CLLocationManager!
    var preciseLocationZoomLevel: Float = 15.0
    var approximateLocationZoomLevel: Float = 10.0
    let defaultLocation = CLLocationCoordinate2D(latitude:19.7515 , longitude: 75.7139) // Maharashtra Coordinates
    var googleMapKey = "AIzaSyDnaIPR6Tp0sgrhj-fcXLivvaILrOdQMhs"
    
    var dictForScheduleDates: NSDictionary! = nil
    var driverPopUpStartDate: String? = ""
    var driverPopUpStartTime: String? = ""
    var driverPopUpEndDate: String? = ""
    var driverContactNoValue: String? = ""
    
    
    //For Getting Distance Matrix Value
    var get_data = NSMutableData()
    var get_dest = NSArray()
    var org_add = NSArray()
    var row_arr = NSArray()
    var ele_arr = NSArray()
    var ele_dic = NSDictionary()
    var dist_dic = NSDictionary()
    var dur_dic = NSDictionary()
    var dur_dic_traffic = NSDictionary()
    var distanceWithoutValue : NSString!
    var distanceInKm : NSString!
    
    var distanceValue : Double? = 0
    var durationInTraffic : Double? = 0
    var durationInTrafficWithText : String? = ""
    
    //MARK:- SideBar
    var sidebarView: SidebarView!
    var blackScreen: UIView!
    
    
    var dataArray = ["Outstation", "Airport", "Rental"]
    var hoursArray = ["2hr", "4hr", "6hr", "8hr", "10hr", "12hr"]
    var kmArray = ["20km", "40km", "60km", "80km", "100km", "120km"]
    
    var dateArray: [String] = []
    var currentDateString : String? = ""
    var myPickerDateString : String? = ""
    
    var currentTimeString : String? = ""
    var myPickerTimeString : String? = ""
    
    var onehrTimeString : String? = ""
    var strTime : String? = ""
    var strDate : String? = ""
    
    var formatter = DateFormatter()
    var currentDate = Date()
    
    var hour: String = "0"
    var minute: String = "0"
    var ampm: String = ""
    var strStartTime : String = ""
    
    var arrSlots : [String] = []
    var timeFormatter = DateFormatter()
    
    var newdate = Date()
    var pickerdate = Date()
    
    let dropDown = DropDown()
    
    let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffect.Style.dark))
    let blurEffectofDriverPopUpView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffect.Style.dark))
    let newDatePicker: UIDatePicker = UIDatePicker()
    var datePickerTag = String()
    let cancelDatePickerButton = UIButton()
    let confirmDatePickerButton = UIButton()
    
    var estimatedDurationInTraffic: Int = 0
    var selectedTripType: String = ""
    var selectedTripTypeMode: String = ""
    
    var myPickUpDateString : String? = ""
    var myDropDateString : String? = ""
    var driverdetailsArray : [SocketReservationResponse] = []
    var imageurlString : String? = ""
    var selectedService : String? = ""
    
    let reachability = try! Reachability()
    
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        roundTripButton.titleLabel?.font = UIFont.fontStyle(13, .semiBold)
        oneWayButton.titleLabel?.font = UIFont.fontStyle(13, .semiBold)
        roundTripButton.backgroundColor = .buttonBackgroundColor
        roundTripButton.setTitleColor(.white, for: .normal)
        oneWayButton.backgroundColor = .white
        oneWayButton.setTitleColor(.buttonBackgroundColor, for: .normal)
        
        pickUpTextField.font = UIFont.fontStyle(14, .medium)
        dropTextField.font = UIFont.fontStyle(14, .medium)
        
        pickUpOnLable.font = UIFont.fontStyle(13, .medium)
        returnByLable.font = UIFont.fontStyle(13, .medium)
        
        pickUpOnTimePickerButton.titleLabel?.font = UIFont.fontStyle(15, .medium)
        pickUpDatePickerButton.titleLabel?.font = UIFont.fontStyle(15, .medium)
        returnByDatePickerButton.titleLabel?.font = UIFont.fontStyle(15, .medium)
        
        rentalSelectaPackageLable.font = UIFont.fontStyle(15, .medium)
        
        btnConfirmLocation.titleLabel?.font = UIFont.fontStyle(15, .medium)
        viewCabsButton.titleLabel?.font = UIFont.fontStyle(15, .medium)
        
        cancelDatePickerButton.titleLabel?.font = UIFont.fontStyle(15, .medium)
        confirmDatePickerButton.titleLabel?.font = UIFont.fontStyle(15, .medium)
        
        
        
        self.view .addSubview(self.mainView)
        self.mainView .addSubview(self.baseStackView)
        self.mainView .addSubview(self.mapView)
        
        
        blackScreen = UIView(frame: self.view.bounds)
        blackScreen.backgroundColor=UIColor(white: 0, alpha: 0.5)
        blackScreen.isHidden=true
        self.navigationController?.view.addSubview(blackScreen)
        blackScreen.layer.zPosition=99
        
        blurEffectofDriverPopUpView.frame = self.view.bounds
        blurEffectofDriverPopUpView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.mainView.addSubview(blurEffectofDriverPopUpView)
        self.mainView.addSubview(self.driverSchedulePopUpStackView)
        
        uiViewDesign(driverSchedulePopUpStackView)
        
        //        self.driverSchedulePopUpStackView.addSubview(doneButton)
        
        SocketIOManager.sharedInstance.establishConnection()
        self.blurEffectofDriverPopUpView.isHidden = true
        self.driverSchedulePopUpStackView.isHidden = true
        
        pickUpDatePickerButton.titleLabel!.adjustsFontSizeToFitWidth = true
        pickUpDatePickerButton.titleLabel!.minimumScaleFactor = 0.5
        
        newDatePicker.minimumDate = Date()
        pickUpDatePickerButton.titleLabel?.font =  UIFont(name: "", size: 14)
        
        pickUpTextField.setIcon(UIImage(named: "Pickuppoint")!)
        dropTextField.setIcon(UIImage(named: "DropPoint")!)
        
        self.mapView.bringSubviewToFront(locatePinImage)
        self.locatePinImage.isHidden = true
        
        //        buttonDesign(btnConfirmLocation, radius: 10.0, borderWidth: 0, borderColor: UIColor.buttonBackgroundColor.cgColor)
        //        buttonDesign(viewCabsButton, radius: 10.0, borderWidth: 0, borderColor: UIColor.buttonBackgroundColor.cgColor)
        buttonDesign(roundTripButton, radius: 5.0, borderWidth: 1.0, borderColor: UIColor.buttonBackgroundColor.cgColor)
        buttonDesign(oneWayButton, radius: 5.0, borderWidth: 1.0, borderColor: UIColor.buttonBackgroundColor.cgColor)
        
        dropShadow(viewCabsButton)
        dropShadow(btnConfirmLocation)
        
       
        //        oneWayButton.setTitleColor(UIColor.black, for: .normal)
        
        var currentTime: String {
            Date().description(with: .current)
        }
        print(currentTime)
        
        let formatter = DateFormatter()
        newDatePicker.layer.cornerRadius = 10.0
        formatter.dateFormat = "hh:mm a"
        let timeStr = formatter.string(from: Date())
        print(timeStr)
        
        formatter.dateFormat = "E, MMM d"
        let dateStr = formatter.string(from: Date())
        currentDateString = dateStr
        print("strDate", currentDateString ?? "")
        
        pickUpDatePickerButton.setTitle(dateStr, for: .normal)
        returnByDatePickerButton.setTitle(dateStr, for: .normal)
        myPickerDateString = dateStr
        currentDateString = dateStr
        
        // Add an event to call onDidChangeDate function when value is changed.
        newDatePicker.addTarget(self, action: #selector(datePickerAction), for: .valueChanged)
        cancelDatePickerButton.addTarget(self, action: #selector(cancelDatePickerButtonAction), for: .touchUpInside)
        confirmDatePickerButton.addTarget(self, action: #selector(confirmDatePickerButtonAction), for: .touchUpInside)
        
        // Add DataPicker to the view
        self.blurEffectView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(self.dismissBlurView(gesture:))))
        
        pickUpOnTimePickerButton.setTitle(timeStr, for: .normal)
        self.hoursPackegeCollectionView.register(UINib(nibName: "RentalHoursPackageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        
        selectPackageView.isHidden = true
        dateTimePickupView.layer.cornerRadius = 7.0
        dateTimePickupView.layer.borderWidth = 1.0
        dateTimePickupView.layer.borderColor = UIColor.lightGray.cgColor
        
        
        self.mapView.delegate = self
        self.mapView.clear()
        
        
        let camera = GMSCameraPosition.camera(withLatitude: defaultLocation.latitude,
                                              longitude: defaultLocation.longitude,
                                              zoom: 8)
        self.mapView.camera = camera
        self.mapView.mapType = .normal
        
        setTimeToPicker()
        
        formatter.dateFormat = "yyyy-MM-dd'T'hh:mm:ss.SSS'Z'"
        self.journeystartTime = formatter.string(from: newdate)
        selectedPickUpDate = newdate
        selectedReturnDate = newdate
        print("self.startTime:", self.journeystartTime ?? "")
        
        tripTypeCollectionView.allowsMultipleSelection = false
        let firstIndexPath = NSIndexPath(item: 0, section: 0)
        tripTypeCollectionView.selectItem(at: firstIndexPath as IndexPath, animated: false, scrollPosition: [])
        
        
        navigationController?.isNavigationBarHidden = true
        
        design(mapView)
        design(baseStackView)
        
        tripTypeCollectionView.layer.shadowColor = UIColor.clear.cgColor
        
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        
        
        self.mapView.settings.compassButton = true
        self.mapView.isMyLocationEnabled = true
        self.mapView.settings.myLocationButton = true
        self.mapView.isUserInteractionEnabled = false
        self.locatePinImage.isHidden = true
        
        pickUpTextField.addTarget(self, action: #selector(textFieldShouldBeginEditing), for: .touchDown)
        dropTextField.addTarget(self, action: #selector(textFieldShouldBeginEditing), for: .touchDown)
        placesClient = GMSPlacesClient.shared()
        self.nearbyPlaces()
        
        strDirection = "two-way"
        selectedTripTypeMode = "ROUND TRIP"
        strServiceType = "Outstation"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.view1.addSubview(self.sideMenuButton)
        
        sidebarView = SidebarView(frame: CGRect(x: 0, y: 0, width: 0, height: self.view.frame.height))
        sidebarView.delegate = self
        sidebarView.layer.zPosition=100
        self.view.isUserInteractionEnabled = true
        
        self.navigationController?.view.addSubview(sidebarView)
        
        let tapGestRecognizer = UITapGestureRecognizer(target: self, action: #selector(blackScreenTapAction(sender:)))
        blackScreen.addGestureRecognizer(tapGestRecognizer)
        
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
        
        
        SocketIOManager.sharedInstance.establishConnection()
        print("Reservation Array: " ,SocketIOManager.sharedInstance.reservationArray)
        
        if(SocketIOManager.sharedInstance.reservationArray .isEmpty){
            self.driverSchedulePopUpStackView.isHidden = true
        }
        else{
            self.blurEffectofDriverPopUpView.isHidden = false
            self.driverSchedulePopUpStackView.isHidden = false
            self.driverdetailsArray = SocketIOManager.sharedInstance.reservationArray
            let drivernameString : String = self.driverdetailsArray[0].driver?.name ?? ""
            let substring:String = drivernameString.components(separatedBy: " ")[0]
            drivernameLabel.text = substring
            
            let dataDecoded:NSData = NSData(base64Encoded:  self.driverdetailsArray[0].otp ?? "", options: NSData.Base64DecodingOptions(rawValue: 0))!
            let decodedString = String(data: dataDecoded as Data, encoding: .utf8)!
            driverOTPLabel.text = "OTP: \(decodedString)"
            
            let imageString : String
            imageString = self.driverdetailsArray[0].driverImageUrl ?? ""
            print("imageString : \(imageString)")
            
            imageurlString  = "\(imageString)"
            //            if(imageurlString.isEmpty == false){
            //                if let url = URL(string:imageurlString){
            //                    driverImageView.load(url: url)
            //                }
            //            }
            if(imageurlString?.isEmpty == false){
                let url = URL(string:imageurlString ?? "")
                let data = try? Data(contentsOf: url!)
                driverImageView.image = UIImage(data: data!)
            }
            
            let startTime = self.driverdetailsArray[0].startTime ?? ""
            let endTime = self.driverdetailsArray[0].endTime ?? ""
            
            let startTimeResult =  dateConversion(dateValue: startTime)
            let endTimeResult =  dateConversion(dateValue: endTime)
            
            let tripDirectionString : String
            tripDirectionString = self.driverdetailsArray[0].serviceType ?? ""
            let fullSeperatedArr = tripDirectionString.components(separatedBy: "-")
            let seperatedTripType: String = fullSeperatedArr[0]
            let seperatedTripType2: String = fullSeperatedArr[1]
            
            let directionStr = seperatedTripType+"-"+seperatedTripType2
            
            if directionStr == "one-way" {
                scheduledateLabel.text = startTimeResult.0 + "," + startTimeResult.1
            } else if directionStr == "two-way" {
                scheduledateLabel.text = startTimeResult.0 + "," + startTimeResult.1 + "-" + endTimeResult.0
            }
            
            driverCallButton.setTitle("", for: .normal)
            
            if(self.driverdetailsArray[0].driver?.name == ""){
                driverContactDetailsView.isHidden = true
                krnNumLabel.text = "Your KRN numb is \(self.driverdetailsArray[0].reservationId ?? 0). Your ride schedule and will send you driver details within few hours."
            }else{
                driverContactDetailsView.isHidden = false
                drivervehiclevalueLabel.text = "Vehicle Details : \(self.driverdetailsArray[0].vehicleNo ?? "")"
                drivercontactLabel.text = "Contact : \(self.driverdetailsArray[0].driver?.mobile ?? "")"
                driverContactNoValue = self.driverdetailsArray[0].driver?.mobile ?? ""
                krnNumLabel.text = "Your KRN numb is \(self.driverdetailsArray[0].reservationId ?? 0)."
            }
            estimatedFareValueLabel.text = "Rs.\(round(self.driverdetailsArray[0].estimatedPrice ?? 0.0))"
            onewaytripLabel.text = "\(seperatedTripType.firstCapitalized) \(seperatedTripType2)" + " To " +  "\(driverdetailsArray[0].endlocationCity ?? "")"
            
            dropShadow(doneButton)
        }
    }
    
    deinit{
        reachability.stopNotifier()
    }
    
    func dateConversion(dateValue: String) -> (String, String) {
        if let myDate = DateFormattingHelper.strToDateTime(strDateTime: dateValue)
        {
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
            formatter.timeZone = TimeZone(identifier: "UTC")
            let myString = formatter.string(from: myDate)
            let yourDate: Date? = formatter.date(from: myString)
            formatter.dateFormat = "E, MMM d"
            let dateStr = formatter.string(from: yourDate!)
            print("dateStr : ", dateStr)
            
            formatter.dateFormat = "hh:mm a"
            let timeStr = formatter.string(from: yourDate!)
            print("timeStr : ", timeStr)
            print("Str time from popup : ","\(dateStr), \(timeStr)" )
            return (dateStr,timeStr)
        } else {
            print("add another format")
            return ("", "")
        }
    }
    
    @IBAction func doneButonClicked(_ sender: UIButton) {
        print("Done Butoon Pressed")
        self.blurEffectofDriverPopUpView.isHidden = true
        self.driverSchedulePopUpStackView.isHidden = true
    }
    
    @objc func dismissBlurView(gesture: UITapGestureRecognizer){
        //        blurEffectView.removeFromSuperview()
        //        newDatePicker.removeFromSuperview()
        //        cancelDatePickerButton.removeFromSuperview()
        //        confirmDatePickerButton.removeFromSuperview()
    }
    
    
    
    @IBAction func pickUpDatePickerButtonPressed(_ sender: UIButton) {
        datePickerFunction()
        datePickerTag = "1"
    }
    
    @IBAction func returnByDatePickerButtonPressed(_ sender: UIButton) {
        datePickerFunction()
        datePickerTag = "2"
    }
    
    @IBAction func pickupTimeButtonPressed(_ sender: UIButton) {
        dropDown.dataSource = self.arrSlots
        dropDown.anchorView = sender
        dropDown.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height) //6
        dropDown.show() //7
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in //8
            guard let _ = self else { return }
            self!.pickUpOnTimePickerButton.setTitle(item, for: .normal)
            self?.strStartTime = item
        }
    }
    
    
    @objc func datePickerAction() {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "E, MMM d"
        let dateStr = formatter.string(from: newDatePicker.date)
        
        if datePickerTag == "1" {
            selectedPickUpDate = newDatePicker.date
            pickUpDatePickerButton.setTitle(dateStr, for: .normal)
            
            strDate = dateStr
            print("strDate ", strDate ?? "")
            myPickerDateString = strDate
            print("myPickerDateString: ", myPickerDateString ?? "")
            if(currentDateString != myPickerDateString){
                self.pickUpOnTimePickerButton.setTitle("12:00 AM", for: .normal)
                print("Set Successfully")
                
                let currentTime = "12:00 AM"
                print("Current time after button click ", currentTime)
                
                self.arrSlots = getTimeIntervals(fromTime: currentTime)
                print("After 12 AM Array data : ", self.arrSlots)
                
                strStartTime = ""
            }
            else{
                setTimeToPicker()
            }
            
        } else if datePickerTag == "2" {
            selectedReturnDate = newDatePicker.date
            //let dateStr = formatter.string(from: selectedReturnDate)
            returnByDatePickerButton.setTitle(dateStr, for: .normal)
            strDate = dateStr
            print("myReturnDateString:", strDate ?? "")
            timeFormatter.dateFormat = "yyyy-MM-dd"
            myDropDateString = timeFormatter.string(from: selectedReturnDate)
            print("myDropDateString : ",myDropDateString ?? "")
            
            strDate = myDropDateString
            print("Drop Date String : \(strDate!) ")
            let strDateTime = "\(strDate!) \("23:59")"
            print("drop strDateTime : ", strDateTime)
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm"
            let dd = formatter.date(from: strDateTime)
            print(dd ?? (Any).self)
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            self.journeyendTime = formatter.string(from: dd!)
            print("Drop Date Time : ", self.journeyendTime ?? "")
        }
        print("dateStr",dateStr)
    }
    
    @objc func cancelDatePickerButtonAction() {
        
        print("cancelDatePickerButtonAction")
        blurEffectView.removeFromSuperview()
        newDatePicker.removeFromSuperview()
        cancelDatePickerButton.removeFromSuperview()
        confirmDatePickerButton.removeFromSuperview()
        
    }
    
    @objc func confirmDatePickerButtonAction() {
        
        print("confirmDatePickerButtonAction")
        blurEffectView.removeFromSuperview()
        newDatePicker.removeFromSuperview()
        cancelDatePickerButton.removeFromSuperview()
        confirmDatePickerButton.removeFromSuperview()
        
    }
    
    
    
    
    
    //MARK:- TEXTFIELD DELEGATE for Pickup And Drop Textfield
    @objc func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == pickUpTextField
        {
            strTxtFieldType = "ToDestination"
            print(strTxtFieldType)
            
            pickUpTextField.text?.removeAll()
            sourceCoordinate = nil
            isconfirmLocation = false
            mapView.clear()
            
            let pickupLocationSearchView: PickupLocationOnSearchView = UINib(nibName: "PickupLocationOnSearchView", bundle: Bundle.main).instantiate(withOwner: nil, options: nil)[0] as! PickupLocationOnSearchView
            pickupLocationSearchView.delegate = self
            
            
            UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).inputAccessoryView = pickupLocationSearchView
            
            UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).text = self.usercurrentLocationAddress
        }
        else if textField == dropTextField
        {
            strTxtFieldType = "FromDestination"
            print(strTxtFieldType)
            dropTextField.text?.removeAll()
            destinationCoordinate = nil
            isconfirmLocation = false
            mapView.clear()
            
            let dropLocationSearchView: DropLocationOnSearchView = UINib(nibName: "DropLocationOnSearchView", bundle: Bundle.main).instantiate(withOwner: nil, options: nil)[0] as! DropLocationOnSearchView
            dropLocationSearchView.delegate = self
            UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).inputAccessoryView = dropLocationSearchView
        }
        btnConfirmLocation.isHidden = false
        UINavigationBar.appearance().tintColor = UIColor.red
        
        LocationDetect.shareInstance.acController.delegate = self
        self.present(LocationDetect.shareInstance.acController, animated: true, completion: nil)
        return false
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
    
    @IBAction func driverCallButtonAction(_ sender: UIButton) {
        if let phoneCallURL = URL(string: "telprompt://\(driverContactNoValue ?? "")") {
            
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
    
    @IBAction func roundtripButtonPressed(_ sender: UIButton) {
        print(roundTripButton.tag)
        clearMap()
//        if roundTripButton.tag == 0 {
//            if returnByDatePickerButton.isHidden == true {
//                returnByDatePickerButton.isHidden = false
//                returnByLable.isHidden = false
//                roundTripButton.backgroundColor = .buttonBackgroundColor
//                roundTripButton.setTitleColor(.white, for: .normal)
//                oneWayButton.backgroundColor = .white
//                oneWayButton.setTitleColor(.buttonBackgroundColor, for: .normal)
//            }
//        } else if roundTripButton.tag == 1 {
//            returnByDatePickerButton.isHidden = true
//            returnByLable.isHidden = true
//            roundTripButton.backgroundColor = .buttonBackgroundColor
//            roundTripButton.setTitleColor(.white, for: .normal)
//            oneWayButton.backgroundColor = .white
//            oneWayButton.setTitleColor(.buttonBackgroundColor, for: .normal)
//        } else if roundTripButton.tag == 2 {
//            returnByDatePickerButton.isHidden = true
//            returnByLable.isHidden = true
//            roundTripButton.backgroundColor = .buttonBackgroundColor
//            roundTripButton.setTitleColor(.white, for: .normal)
//            oneWayButton.backgroundColor = .white
//            oneWayButton.setTitleColor(.buttonBackgroundColor, for: .normal)
//        }
        
        roundTripButton.backgroundColor = .buttonBackgroundColor
        roundTripButton.setTitleColor(.white, for: .normal)
        oneWayButton.backgroundColor = .white
        oneWayButton.setTitleColor(.buttonBackgroundColor, for: .normal)
        
        self.pickUpTextField.text = self.usercurrentLocationAddress
        self.sourceCoordinate = userCurrentlocation
        self.mapView.isUserInteractionEnabled = false
        print("usercurrentLocationAddress:",usercurrentLocationAddress ?? "")
        selectedTripTypeMode = roundTripButton.titleLabel?.text ?? ""
        strDirection = "two-way"
        
    }
    @IBAction func oneWayTripButtonPressed(_ sender: UIButton) {
        print(oneWayButton.tag)
        newDatePicker.date = Date()
        clearMap()
        returnByDatePickerButton.isHidden = true
        returnByLable.isHidden = true
        roundTripButton.backgroundColor = .white
        roundTripButton.setTitleColor(.buttonBackgroundColor, for: .normal)
        oneWayButton.backgroundColor = .buttonBackgroundColor
        oneWayButton.setTitleColor(.white, for: .normal)

        self.pickUpTextField.text = self.usercurrentLocationAddress
        self.sourceCoordinate = userCurrentlocation
        print("usercurrentLocationAddress:",usercurrentLocationAddress ?? "")
        self.mapView.isUserInteractionEnabled = false
        selectedTripTypeMode = oneWayButton.titleLabel?.text ?? ""
        print("selectedTripTypeMode:", selectedTripTypeMode)
        strDirection = "one-way"
    }
    
    //MARK:- Confirm location Button Tapped
    @IBAction func confirmLocationButtonClicked(_ sender: UIButton) {
        
        
        self.isconfirmLocation = true
        print("Confirm Location button clicked")
        
        self.locatePinImage.isHidden = true
        self.btnConfirmLocation.isHidden = true
        
        
        mapView.isUserInteractionEnabled = false
        if(sourceCoordinate != nil && destinationCoordinate != nil)
        {
            self.viewCabsButton.isHidden = false
            
            
            wrapperFunctionToShowPosition(mapView: mapView, coordinate: sourceCoordinate, fieldtype: "ToDestination")
            wrapperFunctionToShowPosition(mapView: mapView, coordinate: destinationCoordinate, fieldtype: "FromDestination")
            
            self.drawpolyLine(from: sourceCoordinate, to: destinationCoordinate)
            
            mapView.isUserInteractionEnabled = true
            
        } else {
            print("sourceCoordinate or destinationCoordinate are nil")
        }
        
        print("destinationTextField text:",self.dropTextField.text ?? "" ,self.selectedDropAddress )
    }
    
    @IBAction func viewCabsButtonClicked(_ sender: UIButton) {
        if pickUpTextField.text == "" {
            customErrorPopup("Please select pickup location")
        } else if dropTextField.text == "" {
            customErrorPopup("Please select drop location")
        }
        else if ((selectedPickUpDate > selectedReturnDate) && (strDirection == "two-way")) {
            customErrorPopup("Please select pickup and return date correctly.")
        }
        else {
            let newdateformatter = DateFormatter()
            if strStartTime == "" {
                strStartTime = (pickUpOnTimePickerButton.titleLabel?.text!)!
                //                let newDateString = String(self.myPickerDateString! + " " + strStartTime)
                newdateformatter.dateFormat = "yyyy-MM-dd'T'hh:mm:ss.SSS'Z'"
                self.journeystartTime = newdateformatter.string(from: newdate)
            } else {
                let newDateString = String(self.myPickerDateString! + " " + strStartTime)
                newdateformatter.dateFormat = "yyyy-MM-dd'T'hh:mm:ss.SSS'Z'"
                let selecteddateformatter = DateFormatter()
                selecteddateformatter.dateFormat = "YYYY EEE, MMM dd hh:mm a"
                let currentDate = NSDate()
                let newFormatter = DateFormatter()
                newFormatter.dateFormat = "YYYY"
                let YearString = newFormatter.string(from: currentDate as Date)
                let newselectedDateString = String(YearString + " " + newDateString)
                let selecteddate = selecteddateformatter.date(from: newselectedDateString)
                self.journeystartTime = newdateformatter.string(from: selecteddate!)
            }
            
            if(strDirection == "one-way"){
                calculateEndTime(startTime: self.journeystartTime! as NSString)
            }
            else if(strDirection == "two-way"){
                if(self.distanceValue != nil){
                    self.distanceValue = 2 * (self.distanceValue ?? 0)
                    
                }
                if(myPickUpDateString == myDropDateString){
                    let formatter = DateFormatter()
                    formatter.dateFormat = "E, MMM d"
                    let dateStr = formatter.string(from: newDatePicker.date)
                    returnByDatePickerButton.setTitle(dateStr, for: .normal)
                    strDate = dateStr
                    print("myReturnDateString:", strDate ?? "")
                    timeFormatter.dateFormat = "yyyy-MM-dd"
                    myDropDateString = timeFormatter.string(from: newDatePicker.date)
                    print("myDropDateString : ",myDropDateString ?? "")
                    strDate = myDropDateString
                    print("Drop Date String : \(strDate!) ")
                    let strDateTime = "\(strDate!) \("23:59")"
                    print("drop strDateTime : ", strDateTime)
                    let newformatter = DateFormatter()
                    newformatter.dateFormat = "yyyy-MM-dd HH:mm"
                    let dd = newformatter.date(from: strDateTime)
                    print(dd ?? (Any).self)
                    newformatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                    self.journeyendTime = newformatter.string(from: dd!)
                }
            }
            
            if(self.distanceValue != nil){
                
                if(pickupcityName == destinationcityName){
                    customErrorPopup("Select Another City")
                }else if(destinationcityName == "" || ((destinationcityName?.isEmpty) == nil)){
                    customErrorPopup("Please select proper address.")
                } else {
                    
                    let getAllProjectionAvailable = GetAllProjectionScheduleRequestModel(startTime: self.journeystartTime ?? "", endTime: self.journeyendTime ?? "", startLocation: pickupcityName ?? "", direction: strDirection ?? "", serviceType: "outstation", vehicleType: "", classType: "", distance:self.distanceValue ?? 0 ,matchExactTime: true)
                    print("getAllProjectionAvailable: ",getAllProjectionAvailable)
                    UserDefaults.standard.setValue(self.journeystartTime, forKey: "journeyTime")
                    UserDefaults.standard.setValue(self.journeyendTime, forKey: "journeyEndTime")
                    UserDefaults.standard.setValue(pickupcityName, forKey: "fromLocation")
                    UserDefaults.standard.setValue(self.distanceValue, forKey: "distance")
                    UserDefaults.standard.setValue("outstation", forKey: "serviceType")
                    UserDefaults.standard.setValue(strDirection, forKey: "direction")
                    
                    
                    
                    self.showIndicator(withTitle: "Loading", and: "Please Wait")
                    
                    APIManager.shareInstance.getAllProjectionAvailableSchedules(getAllProjectionData: getAllProjectionAvailable) { result in
                        
                        switch result {
                        case .success(let dictscheduleDates):
                            
                            //                       print("Dict Schedule Dates",dictscheduleDates)
                            self.hideIndicator()
                            
                            if(dictscheduleDates.isEmpty){
                                print("No Data Found")
                                self.view.makeToast(ErrorMessage.list.nodatafound)
                            }
                            else{
                                let carTypeVc = UIStoryboard(name: "FindCar", bundle: nil).instantiateViewController(withIdentifier: "GoToFindCarStoryboard") as! CarTypesViewController
                                
                                carTypeVc.pickedSourceCoordinate = self.sourceCoordinate
                                carTypeVc.pickedDropCoordinate = self.destinationCoordinate
                                carTypeVc.estimatedKM = self.distanceValue ?? 0
                                carTypeVc.pickUpCityName = self.pickupcityName ?? ""
                                carTypeVc.dropCityName = self.destinationcityName ?? ""
                                carTypeVc.pickUpOnDate = self.myPickerDateString ?? "" //self.pickUpDatePickerButton.titleLabel?.text ?? ""
                                carTypeVc.returnByDate = self.returnByDatePickerButton.titleLabel?.text ?? ""
                                carTypeVc.pickUpOnTime = self.strStartTime //self.pickUpOnTimePickerButton.titleLabel?.text ?? ""
                                carTypeVc.dictForScheduleDates = dictscheduleDates as NSDictionary
                                
                                if self.selectedTripType == "" {
                                    self.selectedTripType = "Outstation"
                                    //                                self.selectedTripTypeMode = "ROUND TRIP"
                                    carTypeVc.tripType = self.selectedTripType
                                    carTypeVc.tripTypeMode = self.selectedTripTypeMode
                                } else {
                                    carTypeVc.tripType = self.selectedTripType
                                    carTypeVc.tripTypeMode = self.selectedTripTypeMode
                                }
                                self.navigationController?.pushViewController(carTypeVc, animated: true)
                                
                            }
                        case .failure(let error):
                            
                            self.hideIndicator()
                            print(error)
                            
                            switch error {
                            case .baseError(.notfound):
                                self.view.makeToast(ErrorMessage.list.nodatafound)
                            case .baseError(.internalservererror):
                                self.view.makeToast(ErrorMessage.list.somethingwentwrong)
                            case .baseError(.badRequest):
                                self.view.makeToast(ErrorMessage.list.somethingwentwrong)
                            case .baseError(.unauthorized):
                                self.view.makeToast(ErrorMessage.list.sessionexpired)
                            case .baseError(.forbidden):
                                self.view.makeToast(ErrorMessage.list.pleasewait)
                                
                            default:
                                self.view.makeToast(ErrorMessage.list.nodatafound)
                            }
                            
                            //                                self.view.makeToast(ErrorMessage.list.nodatafound)
                            
                        }
                    }
                }
            }
            else{
                self.view.makeToast(ErrorMessage.list.pleasewait)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == tripTypeCollectionView {
            return dataArray.count
        } else {
            return hoursArray.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == tripTypeCollectionView {
            let cell = tripTypeCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeCollectionViewCell
            cell.tripTypeLable.text = dataArray[indexPath.row]
            cell.tripTypeLable.textColor = .buttonBackgroundColor
            cell.layer.cornerRadius = 10.0
            if indexPath.row == 0 {
                cell.backgroundColor = .selectedbuttonbackgroundColor
                roundTripButton.backgroundColor = .buttonBackgroundColor
                roundTripButton.setTitleColor(.white, for: .normal)
                oneWayButton.backgroundColor = .white
                oneWayButton.setTitleColor(.buttonBackgroundColor, for: .normal)
            }
            return cell
        } else {
            let cell = hoursPackegeCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! RentalHoursPackageCollectionViewCell
            cell.hoursLable.text = hoursArray[indexPath.row]
            cell.kmLable.text = kmArray[indexPath.row]
            cell.layer.cornerRadius = 8.0
            cell.layer.borderColor = UIColor.lightGray.cgColor
            cell.layer.borderWidth = 0.5
            return cell
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == tripTypeCollectionView {
            let cell = tripTypeCollectionView.cellForItem(at: indexPath) as? HomeCollectionViewCell
            cell?.backgroundColor = .selectedbuttonbackgroundColor
            print("usercurrentLocationAddress :  ", usercurrentLocationAddress ?? "")
            self.mapView.isUserInteractionEnabled = false
            if indexPath.row == 0 {
                roundTripButton.tag = 0
                oneWayButton.tag = 0
                strServiceType = "Outstation"
                print("Selected Service Type : ", strServiceType ?? "")
                selectPackageView.isHidden = true
                if returnByDatePickerButton.isHidden == true {
                    returnByDatePickerButton.isHidden = false
                    returnByLable.isHidden = false
                }
                roundTripButton.setTitle("ROUND TRIP", for: .normal)
                oneWayButton.setTitle("ONE WAY", for: .normal)
                roundTripButton.backgroundColor = .buttonBackgroundColor
                roundTripButton.setTitleColor(.white, for: .normal)
                oneWayButton.backgroundColor = .white
                oneWayButton.setTitleColor(.buttonBackgroundColor, for: .normal)
                
                clearMap()
                self.pickUpTextField.text = self.usercurrentLocationAddress
                self.sourceCoordinate = userCurrentlocation
                print("usercurrentLocationAddress:",usercurrentLocationAddress ?? "")
                selectedTripType = "Outstation"
                print("Outstation:", roundTripButton.titleLabel?.text ?? "", oneWayButton.titleLabel?.text ?? "")
                pickUpDatePickerButton.setTitle(currentDateString, for: .normal)
                returnByDatePickerButton.setTitle(currentDateString, for: .normal)
            } else if indexPath.row == 1 {
                
                roundTripButton.tag = 1
                oneWayButton.tag = 1
                strServiceType = "Airport"
                print("Selected Service Type : ", strServiceType ?? "")
                roundTripButton.setTitle("AIRPORT PICKUP", for: .normal)
                oneWayButton.setTitle("AIRPORT DROP", for: .normal)
                roundTripButton.backgroundColor = .buttonBackgroundColor
                roundTripButton.setTitleColor(.white, for: .normal)
                oneWayButton.backgroundColor = .white
                oneWayButton.setTitleColor(.buttonBackgroundColor, for: .normal)
                
                returnByDatePickerButton.isHidden = true
                returnByLable.isHidden = true
                //                returnByDatePicker.isHidden = true
                //                returnByDatePickerImageView.isHidden = true
                selectPackageView.isHidden = true
                clearMap()
                //                pickUpOnDatePicker.date = Date()
                //                returnByDatePicker.date = Date()
                self.pickUpTextField.text = self.usercurrentLocationAddress
                self.sourceCoordinate = userCurrentlocation
                print("usercurrentLocationAddress:",usercurrentLocationAddress ?? "")
                selectedTripType = "Airport"
                //                selectedTripTypeMode = "Airport Pickup"
                strDirection = "AIRPORT PICKUP"
                selectedTripTypeMode = "AIRPORT PICKUP"
                strServiceType = "Airport"
                
                print("Airport:", roundTripButton.titleLabel?.text ?? "", oneWayButton.titleLabel?.text ?? "")
                pickUpDatePickerButton.setTitle(currentDateString, for: .normal)
                returnByDatePickerButton.setTitle(currentDateString, for: .normal)
            } else if indexPath.row == 2 {
                
                roundTripButton.tag = 2
                oneWayButton.tag = 2
                strServiceType = "Rental"
                print("Selected Service Type : ", strServiceType ?? "")
                roundTripButton.setTitle("CURRENT BOOKING", for: .normal)
                oneWayButton.setTitle("SCHEDULE BOOKING", for: .normal)
                roundTripButton.backgroundColor = .buttonBackgroundColor
                roundTripButton.setTitleColor(.white, for: .normal)
                oneWayButton.backgroundColor = .white
                oneWayButton.setTitleColor(.buttonBackgroundColor, for: .normal)
                
                returnByDatePickerButton.isHidden = true
                returnByLable.isHidden = true
                //                returnByDatePicker.isHidden = true
                //                returnByDatePickerImageView.isHidden = true
                selectPackageView.isHidden = false
                clearMap()
                //                pickUpOnDatePicker.date = Date()
                //                returnByDatePicker.date = Date()
                self.pickUpTextField.text = self.usercurrentLocationAddress
                self.sourceCoordinate = userCurrentlocation
                print("usercurrentLocationAddress:",usercurrentLocationAddress ?? "")
                selectedTripType = "Rental"
                //                selectedTripTypeMode = "CURRENT BOOKING"
                
                strDirection = "CURRENT BOOKING"
                selectedTripTypeMode = "CURRENT BOOKING"
                strServiceType = "Rental"
                print("Rental:", roundTripButton.titleLabel?.text ?? "", oneWayButton.titleLabel?.text ?? "")
                pickUpDatePickerButton.setTitle(currentDateString, for: .normal)
                returnByDatePickerButton.setTitle(currentDateString, for: .normal)
            }
            print("Select click")
        } else {
            let hoursCell = hoursPackegeCollectionView.cellForItem(at: indexPath) as! RentalHoursPackageCollectionViewCell
            hoursCell.layer.borderColor = UIColor.black.cgColor
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if collectionView == tripTypeCollectionView {
            let cell = tripTypeCollectionView.cellForItem(at: indexPath) as? HomeCollectionViewCell
            cell?.backgroundColor = .clear
            print("Deselect click")
        } else {
            let hoursCell = hoursPackegeCollectionView.cellForItem(at: indexPath) as! RentalHoursPackageCollectionViewCell
            hoursCell.layer.borderColor = UIColor.lightGray.cgColor
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func carTypes() {
        if rentalTag == 2 {
            let ctVC = UIStoryboard(name: "FindCar", bundle: nil).instantiateViewController(withIdentifier: "CarTypesViewController") as! CarTypesViewController
            navigationController?.pushViewController(ctVC, animated: true)
        } else {
            let ctVC = UIStoryboard(name: "FindCar", bundle: nil).instantiateViewController(withIdentifier: "CarTypesViewController") as! CarTypesViewController
            navigationController?.pushViewController(ctVC, animated: true)
        }
    }
    
    @objc func blackScreenTapAction(sender: UITapGestureRecognizer) {
        blackScreen.isHidden = true
        blackScreen.frame = self.view.bounds
        UIView.animate(withDuration: 0.3) {
            self.sidebarView.frame=CGRect(x: 0, y: 0, width: 0, height: self.sidebarView.frame.height)
        }
    }
    
    @IBAction func sideMenuButtonPressed(_ sender: UIButton) {
        
        blackScreen.isHidden = false
        UIView.animate(withDuration: 0.3, animations: {
            self.sidebarView.frame=CGRect(x: 0, y: 0, width: 300, height: self.sidebarView.frame.height)
        }) { (complete) in
            self.blackScreen.frame=CGRect(x: self.sidebarView.frame.width, y: 0, width: self.view.frame.width-self.sidebarView.frame.width, height: self.view.bounds.height+100)
        }
    }
    
    @IBAction func favirateButtonPressed(_ sender: UIButton) {
        print("Faviourate")
        guard let popupViewController = CustomPopupView.instantiate() else { return }
        popupViewController.delegate = self
        //        popupViewController.titleString = "I am custom popup"
        
        let popupVC = PopupViewController(contentController: popupViewController, position: .bottom(0), popupWidth: self.view.frame.width, popupHeight: 300)
        popupVC.cornerRadius = 15
        popupVC.backgroundAlpha = 0.0
        popupVC.backgroundColor = .clear
        popupVC.canTapOutsideToDismiss = true
        popupVC.shadowEnabled = true
        popupVC.delegate = self
        popupVC.modalPresentationStyle = .popover
        self.present(popupVC, animated: true, completion: nil)
    }
    
}


extension HomeViewController: SidebarViewDelegate {
    func sidebarDidSelectRow(row: Row) {
        blackScreen.isHidden = true
        blackScreen.frame = self.view.bounds
        UIView.animate(withDuration: 0.3) {
            self.sidebarView.frame=CGRect(x: 0, y: 0, width: 0, height: self.sidebarView.frame.height)
        }
        switch row {
        case .editProfile:
            let epvc = storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
            navigationController?.pushViewController(epvc, animated: true)
        case .myRides:
            print("MyRidesViewController")
            let mrvc = storyboard?.instantiateViewController(withIdentifier: "MyRidesViewController") as! MyRidesViewController
            navigationController?.pushViewController(mrvc, animated: true)
        case .payment:
            print("Payment")
            let pvc = storyboard?.instantiateViewController(withIdentifier: "PaymentViewController") as! PaymentViewController
            navigationController?.pushViewController(pvc, animated: true)
        case .offers:
            print("Offers")
            let ovc = storyboard?.instantiateViewController(withIdentifier: "OffersViewController") as! OffersViewController
            navigationController?.pushViewController(ovc, animated: true)
        case .safety:
            print("Safety")
            let ovc = storyboard?.instantiateViewController(withIdentifier: "SafetyViewController") as! SafetyViewController
            navigationController?.pushViewController(ovc, animated: true)
        case .faqs:
            print("FAQs")
            let faqvc = storyboard?.instantiateViewController(withIdentifier: "FAQViewController") as! FAQViewController
            navigationController?.pushViewController(faqvc, animated: true)
        case .feedback:
            print("Feedback")
            let fvc = storyboard?.instantiateViewController(withIdentifier: "FeedbackViewController") as! FeedbackViewController
            present(fvc, animated: true, completion: nil)
        case .shareApp:
            print("Share App")
            shareApp()
        case .referEarn:
            print("Refer & Earn")
            let svc = storyboard?.instantiateViewController(withIdentifier: "ReferandEarnViewController") as! ReferandEarnViewController
            navigationController?.pushViewController(svc, animated: true)
        case .support:
            print("Support")
            let svc = storyboard?.instantiateViewController(withIdentifier: "SupportViewController") as! SupportViewController
            navigationController?.pushViewController(svc, animated: true)
        case .about:
            print("About")
            let avc = storyboard?.instantiateViewController(withIdentifier: "AboutViewController") as! AboutViewController
            navigationController?.pushViewController(avc, animated: true)
        case .none:
            print("None")
            break
        }
    }
}


extension HomeViewController : PopupViewControllerDelegate, CustomPopupViewDelegate
{
    // MARK: Default Delegate Methods For Dismiss Popup
    public func popupViewControllerDidDismissByTapGesture(_ sender: PopupViewController)
    {
        dismiss(animated: true)
        {
            debugPrint("Popup Dismiss")
        }
    }
    
    // MARK: Custom Delegate Methods For Dismiss Popup on Action
    func customPopupViewExtension(sender: CustomPopupView, didSelectNumber: Int)
    {
        dismiss(animated: true)
        {
            if didSelectNumber == 1
            {
                debugPrint("Custom Popup Dismiss On Done Button Action")
            }
        }
    }
}
// Delegates to handle events for the location manager.
extension HomeViewController: CLLocationManagerDelegate
{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location: CLLocation = locations.last!
        print("Current Location: \(location)")
        
        
        
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        
        let zoomLevel = locationManager.accuracyAuthorization == .fullAccuracy ? preciseLocationZoomLevel : approximateLocationZoomLevel
        let camera = GMSCameraPosition.camera(withLatitude: locValue.latitude,
                                              longitude: locValue.longitude,
                                              zoom: zoomLevel)
        self.mapView?.camera = camera
        self.mapView?.animate(to: camera)
        
        sourceCoordinate = locValue
        print("sourceCoordinate in Location Manager: ",sourceCoordinate!)
        
        self.showIndicator(withTitle: "Loading", and: "Please Wait")
        let geocoder = GMSGeocoder()
        geocoder.reverseGeocodeCoordinate(sourceCoordinate) { response, error in
            if let location = response?.firstResult() {
                self.hideIndicator()
                if(self.sourceCoordinate != nil){
                    let marker = GMSMarker(position: self.sourceCoordinate) //locValue
                    let lines = location.lines! as [String]
                    marker.userData = lines.joined(separator: "\n")
                    marker.title = lines.joined(separator: "\n")
                    marker.infoWindowAnchor = CGPoint(x: 0.5, y: -0.25)
                    marker.accessibilityLabel = "current"
                    marker.snippet = response?.firstResult()?.locality
                    
                    
                    let markerImage = UIImage(named: "Pickuppoint")!.withRenderingMode(.alwaysTemplate)
                    //creating a marker view
                    let markerView = UIImageView(image: markerImage)
                    markerView.tintColor = UIColor.green
                    marker.iconView = markerView
                    
                    print("pickupCityName from geocooder : \(String(describing: self.pickupcityName))")
                    marker.map = self.mapView
                    
                    
                    UserDefaults.standard.setValue(lines.joined(separator: "\n"), forKey:"SourceAddress")
                    self.pickupcityName = response?.firstResult()?.locality
                    UserDefaults.standard.setValue(self.pickupcityName, forKey: "PickupCityName")
                    
                    self.strTxtFieldType = "ToDestination"
                    self.usercurrentLocationAddress = lines.joined(separator: "\n")
                    self.pickUpTextField.text = self.usercurrentLocationAddress
                    self.userCurrentlocation = locValue
                    let sourceLat = NSNumber(value:self.userCurrentlocation.latitude)
                    let sourceLon = NSNumber(value:self.userCurrentlocation.longitude)
                    let userSourceLocation : NSMutableDictionary
                    userSourceLocation = ["SourceLatitude": sourceLat, "SourceLongitude": sourceLon]
                    UserDefaults.standard.setValue(userSourceLocation, forKey:"SourceCoordinate")
                }
            }
        }
        
    }
    
    // Handle authorization for the location manager.
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            // Check accuracy authorization
            let accuracy = manager.accuracyAuthorization
            switch accuracy {
            case .fullAccuracy:
                print("Location accuracy is precise.")
                                
                navigationController?.popViewController(animated: true)
                locationManager.startUpdatingLocation()
                
            case .reducedAccuracy:
                print("Location accuracy is not precise.")
            @unknown default:
                fatalError()
            }
            
            // Handle authorization status
            switch status {
            case .restricted:
                print("Location access was restricted.")
            case .denied:
                print("User denied access to location.")
                // Display the map using the default location.
                mapView.isHidden = false
                
                let gotoSVC = storyboard?.instantiateViewController(withIdentifier: "GoTOSettingsViewController") as! GoTOSettingsViewController
                navigationController?.pushViewController(gotoSVC, animated: true)                
                
                
            case .notDetermined:
                print("Location status not determined.")
            case .authorizedAlways: fallthrough
            case .authorizedWhenInUse:
                print("Location status is OK.")
                //locationManager.startUpdatingLocation()
            @unknown default:
                fatalError()
            }
        }
        
        @objc func gotoSettingButtonClicked(){
            print("Move To Seeting.")
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                       return
                   }

                   if UIApplication.shared.canOpenURL(settingsUrl) {
                       UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                           print("Settings opened: \(success)") // Prints true
                       })
                   }
        }
        
        // Handle location manager errors.
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            locationManager.stopUpdatingLocation()
            print("Error: \(error)")
        }
}

extension HomeViewController: GMSAutocompleteViewControllerDelegate {
    
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        self.viewCabsButton?.isHidden = true
        print("Place name: \(String(describing: place.name))")
        print("Place address: \(place.formattedAddress ?? "null")")
        
        if strTxtFieldType == "ToDestination"
        {
            
            self.pickUpTextField.text = place.formattedAddress
            print("Place Fomated Add : ", place)
            self.selectedToDestination = place
            sourceCoordinate = place.coordinate
            print("sourceCoordinate",sourceCoordinate as Any)
            pickupName = place.name
            UserDefaults.standard.setValue(place.formattedAddress, forKey:"SourceAddress")
            
            let arrays : NSArray = place.addressComponents! as NSArray
            for i in 0..<arrays.count {
                
                let dics : GMSAddressComponent = arrays[i] as! GMSAddressComponent
                let str : String = dics.type as String
                
                print("Address Dics for pickup: \(dics)")
                
                if(str == "locality")
                {
                    pickupcityName = dics.shortName
                    print ("localoty name : \(dics.name)")
                    print("locality shortname : \(dics.shortName ?? "")")
                }
            }
            sourceMarker = GMSMarker()
            let markerImage = UIImage(named: "Pickuppoint")!.withRenderingMode(.alwaysTemplate)
            //creating a marker view
            let markerView = UIImageView(image: markerImage)
            markerView.tintColor = UIColor.green
            sourceMarker.position = sourceCoordinate
            sourceMarker.title = place.name
            sourceMarker.iconView = markerView
            sourceMarker.map = self.mapView
            sourceMarker.snippet = place.name
            
            let sourceLat = NSNumber(value:sourceCoordinate.latitude)
            let sourceLon = NSNumber(value:sourceCoordinate.longitude)
            let userSourceLocation : NSMutableDictionary
            userSourceLocation = ["SourceLatitude": sourceLat, "SourceLongitude": sourceLon]
            UserDefaults.standard.setValue(userSourceLocation, forKey:"SourceCoordinate")
            UserDefaults.standard.setValue(self.pickupcityName, forKey: "PickupCityName")
            self.btnConfirmLocation.isHidden = false
        }
        else if strTxtFieldType == "FromDestination"
        {
            self.dropTextField.text = place.formattedAddress
            UserDefaults.standard.setValue(place.formattedAddress, forKey:"DestinationAddress")
            
            destinationCoordinate = place.coordinate
            destionationName = place.name
            let arrays : NSArray = place.addressComponents! as NSArray
            for i in 0..<arrays.count {
                
                let dics : GMSAddressComponent = arrays[i] as! GMSAddressComponent
                let str : String = dics.type as String
                
                if(str == "locality")
                {
                    destinationcityName = dics.shortName
                }
            }
            destinationMarker = GMSMarker()
            let markerImage = UIImage(named: "DropPoint")!.withRenderingMode(.alwaysTemplate)
            //creating a marker view
            let markerView = UIImageView(image: markerImage)
            markerView.tintColor = UIColor.red
            destinationMarker.position = destinationCoordinate
            destinationMarker.title = place.name
            destinationMarker.iconView = markerView
            destinationMarker.map = self.mapView
            
            let camera = GMSCameraPosition.camera(withLatitude: destinationCoordinate.latitude,
                                                  longitude: destinationCoordinate.longitude,
                                                  zoom: 15)
            self.mapView?.camera = camera
            self.mapView?.animate(to: camera)
            
            if(self.pickupcityName == self.destinationcityName){
                self.view.makeToast(ErrorMessage.list.selectOtherCity)
                self.dropTextField.text = ""
            }else{
                //  self.mapView.animate(toLocation: self.destinationCoordinate)
                self.strTxtFieldType = "FromDestination"
            }
            let sourceLat = NSNumber(value:destinationCoordinate.latitude)
            let sourceLon = NSNumber(value:destinationCoordinate.longitude)
            let userDestinationLocation : NSMutableDictionary
            userDestinationLocation = ["DestinationLatitude": sourceLat, "DestinationLongitude": sourceLon]
            UserDefaults.standard.setValue(userDestinationLocation, forKey:"DestinationCoordinate")
            UserDefaults.standard.setValue(self.destinationcityName, forKey: "DestinationCityName")
            self.btnConfirmLocation.isHidden = false
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        customErrorPopup(error.localizedDescription)
        self.dismiss(animated: true, completion: nil)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        self.dismiss(animated: true) {
            if self.pickUpTextField.text == "" {
                self.strTxtFieldType = "ToDestination"
                self.pickUpTextField.text = self.usercurrentLocationAddress
                self.sourceCoordinate = self.userCurrentlocation
            }
        }
        //self.dismiss(animated: true, completion: nil)
    }
    
}

extension UITextField {
    func setIcon(_ image: UIImage) {
        let iconView = UIImageView(frame: CGRect(x: 5, y: 5, width: 20, height: 20))
        iconView.image = image
        let iconContainerView: UIView = UIView(frame: CGRect(x: 5, y: 0, width: 30, height: 30))
        iconContainerView.addSubview(iconView)
        rightView = iconContainerView
        rightViewMode = .always
    }
    
    
}


class LocationDetect {
    static let shareInstance = LocationDetect()
    let acController = GMSAutocompleteViewController()
    
}
