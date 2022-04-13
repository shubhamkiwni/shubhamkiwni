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

var tabletagArray = [0]
var dateTag: Int = 0
var rentalTag: Int = 0
var timeTag: Int = 0

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, GMSMapViewDelegate, dropOnlocateSearchdelegate, UITextFieldDelegate, pickupOnlocateSearchdelegate  {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var tripTypeCollectionView: UICollectionView!
    
    @IBOutlet weak var pickUpTextField: UITextField!
    @IBOutlet weak var dropTextField: UITextField!
    
    @IBOutlet weak var roundTripButton: UIButton!
    @IBOutlet weak var oneWayButton: UIButton!
    @IBOutlet weak var locatePinImage : UIImageView!
    
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view5: UIView!
    @IBOutlet weak var view6: UIView!
    
    //MARK:- MapView
    @IBOutlet weak var mapView: GMSMapView!
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
    var startTime : String? = ""
    var endTime : String? = ""
    var journeyDate : String? = ""
    var strDirection : String? = ""
    var strServiceType: String? = ""
    var strButtonTitle : String? = ""
    var userCurrentlocation: CLLocationCoordinate2D!
    var usercurrentLocationAddress : String? = ""
    
    var isconfirmLocation : Bool = false
    
    var responseArr : NSArray!
    
    var locationManager: CLLocationManager!
    var preciseLocationZoomLevel: Float = 15.0
    var approximateLocationZoomLevel: Float = 10.0
    let defaultLocation = CLLocationCoordinate2D(latitude:19.7515 , longitude: 75.7139) // Maharashtra Coordinates
    var googleMapKey = "AIzaSyDnaIPR6Tp0sgrhj-fcXLivvaILrOdQMhs"
    
    
    var dictForScheduleDates: NSDictionary! = nil

    
    private struct MapPath : Decodable{
        var routes : [Route]?
    }
    
    private struct Route : Decodable{
        
        var overview_polyline : OverView?
    }
    
    private struct OverView : Decodable {
        
        var points : String?
    }
    
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
    
    var distanceValue : Double!
    var durationInTraffic : Double!
    var durationInTrafficWithText : NSString! = ""
    
    //MARK:- SideBar
    var sidebarView: SidebarView!
    var blackScreen: UIView!
    //    @IBOutlet weak var datePicker: UIView!
    
    //    @IBOutlet weak var datePickerView: UIView!
    
    var dataArray = ["Outstation", "Airport", "Rental"]
    var hoursArray = ["2hr", "4hr", "6hr", "8hr", "10hr", "12hr"]
    var kmArray = ["20km", "40km", "60km", "80km", "100km", "120km"]
    
    var dateArray: [String] = []
    var currentDateString : String? = ""
    var myPickerDateString : String? = ""
    
    var currentTimeString : String?
    var myPickerTimeString : String?
    
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
    
    @IBOutlet weak var sideMenuButton: UIButton!
    @IBOutlet weak var faviourateButton: UIButton!
    
    @IBOutlet weak var viewCabsButton: UIButton!
    @IBOutlet weak var pickUpOnLable: UILabel!
    @IBOutlet weak var returnByLable: UILabel!
    @IBOutlet weak var dateTimePickupView: UIView!
    
    
    @IBOutlet weak var pickUpDatePickerButton: UIButton!
    @IBOutlet weak var returnByDatePickerButton: UIButton!
    
    
    @IBOutlet weak var pickUpOnTimePickerButton: UIButton!
    @IBOutlet weak var callButton: UIButton!
    
    @IBOutlet weak var rentalSelectaPackageLable: UILabel!
    @IBOutlet weak var hoursPackegeCollectionView: UICollectionView!
    @IBOutlet weak var btnConfirmLocation : UIButton!
    
    @IBOutlet weak var selectPackageView: UIView!
    @IBOutlet weak var baseStackView: UIStackView!
    
    let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffect.Style.dark))
    let newDatePicker: UIDatePicker = UIDatePicker()
    var datePickerTag = String()
    
    var estimatedDurationInTraffic: Int = 0
    var selectedTripType: String = ""
    var selectedTripTypeMode: String = ""
    
    var myDropDateString : String? = ""
    
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickUpDatePickerButton.titleLabel!.adjustsFontSizeToFitWidth = true
        pickUpDatePickerButton.titleLabel!.minimumScaleFactor = 0.5
        
        newDatePicker.minimumDate = Date()
        pickUpDatePickerButton.titleLabel?.font =  UIFont(name: "", size: 14)
        
        pickUpTextField.setIcon(UIImage(named: "Pickuppoint")!)
        dropTextField.setIcon(UIImage(named: "DropPoint")!)
        
        self.mapView.bringSubviewToFront(locatePinImage)
        self.locatePinImage.isHidden = true
        
        buttonDesign(btnConfirmLocation, radius: 10.0, borderWidth: 0, borderColor: UIColor.black.cgColor)
        buttonDesign(viewCabsButton, radius: 10.0, borderWidth: 0, borderColor: UIColor.black.cgColor)
        buttonDesign(roundTripButton, radius: 5.0, borderWidth: 1.0, borderColor: UIColor.black.cgColor)
        buttonDesign(oneWayButton, radius: 5.0, borderWidth: 1.0, borderColor: UIColor.black.cgColor)
        oneWayButton.backgroundColor = .white
        
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
        self.startTime = formatter.string(from: newdate)
        print("self.startTime:", self.startTime ?? "")
        
        tripTypeCollectionView.allowsMultipleSelection = false
        let firstIndexPath = NSIndexPath(item: 0, section: 0)
        tripTypeCollectionView.selectItem(at: firstIndexPath as IndexPath, animated: false, scrollPosition: [])
        
        
        sidebarView = SidebarView(frame: CGRect(x: 0, y: 0, width: 0, height: self.view.frame.height))
        sidebarView.delegate = self
        sidebarView.layer.zPosition=100
        self.view.isUserInteractionEnabled=true
        self.navigationController?.view.addSubview(sidebarView)
        
        blackScreen = UIView(frame: self.view.bounds)
        blackScreen.backgroundColor=UIColor(white: 0, alpha: 0.5)
        blackScreen.isHidden=true
        self.navigationController?.view.addSubview(blackScreen)
        blackScreen.layer.zPosition=99
        let tapGestRecognizer = UITapGestureRecognizer(target: self, action: #selector(blackScreenTapAction(sender:)))
        blackScreen.addGestureRecognizer(tapGestRecognizer)
        
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
        
        strDirection = "ROUND TRIP"
        selectedTripTypeMode = "ROUND TRIP"
        strServiceType = "Outstation"
    }
    
    @objc func dismissBlurView(gesture: UITapGestureRecognizer){
        blurEffectView.removeFromSuperview()
        newDatePicker.removeFromSuperview()
    }
    
    
    
    @IBAction func pickUpDatePickerButtonPressed(_ sender: UIButton) {
        
        datePickerFunction()
        datePickerTag = "1"
    }
    
    @IBAction func returnByDatePickerButtonPressed(_ sender: UIButton) {
        
        datePickerFunction()
        datePickerTag = "2"
        timeFormatter.dateFormat = "yyyy-MM-dd"
        myDropDateString = timeFormatter.string(from: newDatePicker.date)
        print("myDropDateString : ",myDropDateString ?? "")
        
        strDate = myDropDateString
        print("Drop Date String : \(strDate!) ")
        if( myPickerDateString != myDropDateString){
           
            let strDateTime = "\(strDate!) \("23:59")"
            print("drop strDateTime : ", strDateTime)
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm"
            let dd = formatter.date(from: strDateTime)
            print(dd ?? (Any).self)
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            self.endTime = formatter.string(from: dd!)
            //print(dd!)
           print("Drop Date Time : ", self.endTime)
        }else{
            //setTimeToPicker()
            print("Select drop date and time")
        }
    }
    
    @IBAction func pickupTimeButtonPressed(_ sender: UIButton) {
        dropDown.dataSource = self.arrSlots
        dropDown.anchorView = sender
        dropDown.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height) //6
        dropDown.show() //7
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in //8
            guard let _ = self else { return }
            //            self!.pickUpOnTimeLable.text = item //9
            self!.pickUpOnTimePickerButton.setTitle(item, for: .normal)
            self?.strStartTime = item
            print("strStartTime : ", self?.strStartTime)
        }
    }
    //MARK:- Calculate End Time
    func calculateEndTime(startTime: NSString){
        print("StartTime : \(self.startTime)")
        print("duration_in_traffic text value is--->",self.durationInTrafficWithText as NSString)
//        "2021-12-30T14:28:00.000Z"
        let str : String = self.durationInTrafficWithText as String
        let strArr = str.components(separatedBy: " ")

        var arr: [Int] = []
        for item in strArr {
            let part = item.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
            
            if let intVal = Int(part) {
                print("this is a number -> \(intVal)")
                arr.append(intVal)
            }
            
        }
        print(arr)

        var day: Int
        var hur: Int
        var min: Int

        let formatter = DateFormatter()
//        formatter.locale = Locale(identifier: "IST")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        
        if let date = formatter.date(from: startTime as String) {
            
            formatter.dateFormat = "hh:mm a"
            let timeStr = formatter.string(from: date)
            print(timeStr)
            formatter.dateFormat = "yyyy-MM-dd"
            let dateStr = formatter.string(from: date)
            print(dateStr)
            
            if arr.count == 3
            {
                print(arr)
                day = arr[0]*86400
                hur = arr[1]*3600
                min = arr[2]*60
                let addminutes = date.addingTimeInterval(TimeInterval(day+hur+min))
                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                
                let after_add_time = formatter.string(from: addminutes)
                print("after add time-->",after_add_time as Any)
                let inputString = after_add_time
                self.endTime = inputString.replacingOccurrences(of: "+0530", with: "Z")
                print("endTime : \(String(describing: self.endTime))")
                
            } else if arr.count == 2
            {
                print(arr)
                hur = arr[0]*3600
                min = arr[1]*60
                let addminutes = date.addingTimeInterval(TimeInterval(hur+min))
                
                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                let after_add_time  = formatter.string(from: addminutes)
                print("after add time-->",after_add_time as Any)
                let inputString = after_add_time
                self.endTime = inputString.replacingOccurrences(of: "+0530", with: "Z")
                print("endTime : \(String(describing: self.endTime))")
                
            } else if arr.count == 1
            {
                print(arr)
                min = arr[0]*60
                let addminutes = date.addingTimeInterval(TimeInterval(min))
                
                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                let after_add_time = formatter.string(from: addminutes)
                print("after add time-->",after_add_time as Any)

                let inputString = after_add_time
                self.endTime = inputString.replacingOccurrences(of: "+0530", with: "Z")
                print("endTime : \(String(describing: self.endTime))")
            }
        }
    }
    
    @objc func datePickerAction() {
        print(newDatePicker.date)
        let formatter = DateFormatter()
        
        formatter.dateFormat = "E, MMM d"
        let dateStr = formatter.string(from: newDatePicker.date)
        if datePickerTag == "1" {
            pickUpDatePickerButton.setTitle(dateStr, for: .normal)
            myPickerDateString = dateStr
            strDate = myPickerDateString
            print("myPickerDateString:", myPickerDateString)
            
            
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
            returnByDatePickerButton.setTitle(dateStr, for: .normal)
        }
        print("dateStr",dateStr)
        
       
        
    }
    
    func nearbyPlaces() {
        placesClient.currentPlace(callback: { (placeLikelihoodList, error) -> Void in
            if let error = error {
                print("Pick Place error: \(error.localizedDescription)")
                return
            }
            
            if let placeLikelihoodList = placeLikelihoodList {
                self.likeHoodList = placeLikelihoodList
                print("self.likeHoodList:",self.likeHoodList as Any)
                //                   tableView.reloadData()
            }
        })
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
    @IBAction func roundtripButtonPressed(_ sender: UIButton) {
       
        clearMap()
        if rentalTag == 0 {
            if returnByDatePickerButton.isHidden == true {
                returnByDatePickerButton.isHidden = false
                returnByLable.isHidden = false
                roundTripButton.backgroundColor = .black
                oneWayButton.backgroundColor = .white
            }
        } else if rentalTag == 1 {
            returnByDatePickerButton.isHidden = true
            returnByLable.isHidden = true
            roundTripButton.backgroundColor = .black
            oneWayButton.backgroundColor = .white
        } else if rentalTag == 2 {
            returnByDatePickerButton.isHidden = true
            returnByLable.isHidden = true
            roundTripButton.backgroundColor = .black
            oneWayButton.backgroundColor = .white
        }
        self.pickUpTextField.text = self.usercurrentLocationAddress
        self.sourceCoordinate = userCurrentlocation
        self.mapView.isUserInteractionEnabled = false
        print("usercurrentLocationAddress:",usercurrentLocationAddress ?? "")
        selectedTripTypeMode = roundTripButton.titleLabel?.text ?? ""
        strDirection = "two-way"
        
    }
    @IBAction func oneWayTripButtonPressed(_ sender: UIButton) {
       
        clearMap()
        if returnByDatePickerButton.isHidden == false {
            returnByDatePickerButton.isHidden = true
            returnByLable.isHidden = true
            
        }
        roundTripButton.backgroundColor = .white
        oneWayButton.backgroundColor = .black
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
        
        print("strDirection: ",strDirection)
        print("selectedTripTypeMode: ",selectedTripTypeMode)
        print("strServiceType: ",strServiceType)
        
        if pickUpTextField.text == "" {
            print("Please Select a Pickup location")
            customErrorPopup("Please select pickup location")
            
        } else if dropTextField.text == "" {
            print("Please Select a drop location")
            customErrorPopup("Please select drop location")
        } else {
            print("View Cabs Button Pressed")
            
            let newdateformatter = DateFormatter()
            newdateformatter.dateFormat = "EEE, MMM d hh:mm a"
            if strStartTime == "" {
                strStartTime = (pickUpOnTimePickerButton.titleLabel?.text!)!
                print("confirm Button startTime : ", strStartTime)
                let newDateString = String(self.myPickerDateString! + " " + strStartTime)
                print("newDateString: ", newDateString)
                newdateformatter.dateFormat = "yyyy-MM-dd'T'hh:mm:ss.SSS'Z'"
                self.startTime = newdateformatter.string(from: newdate)
                print("self.startTime on confirm button clicked:", self.startTime ?? "")
            } else {
                print("confirm Button startTime : ", strStartTime)
                let newDateString = String(self.myPickerDateString! + " " + strStartTime)
                print("newDateString: ", newDateString)
                
                let datevalue = newdateformatter.date(from: newDateString)
                print(datevalue ?? (Any).self)
                newdateformatter.dateFormat = "yyyy-MM-dd'T'hh:mm:ss.SSS'Z'"
                self.startTime = newdateformatter.string(from: datevalue!)
                print("self.startTime on confirm button clicked:", self.startTime ?? "")
            }
            
//            if(roundTripButton.titleLabel?.text == "ROUND TRIP"){
//                strDirection = "two-way"
//            }else  if(oneWayButton.titleLabel?.text == "ONE WAY") {
//                strDirection = "one-way"
//            }
            if(strDirection == "one-way"){
                calculateEndTime(startTime: self.startTime! as NSString)
            }
            else if(strDirection == "two-way"){
                self.distanceValue = 2 * (self.distanceValue)
                print("Distance Value for two way : ", self.distanceValue)
            }
            
            /*if(strDirection == "ONE-WAY" || strButtonTitle == "AIRPORT PICKUP" || strDirection == "AIRPORT DROP" || strDirection == "CURRENT BOOKING" || strDirection == "SCHEDULE BOOKING"){
                calculateEndTime(startTime: self.startTime! as NSString)
            }
            else if(strButtonTitle == "ROUND TRIP"){
                self.distanceValue = 2 * (self.distanceValue)
                print("Distance Value for two way : ", self.distanceValue)
            }*/
            
            if(self.distanceValue != nil){
                
                let getAllProjectionAvailable = GetAllProjectionScheduleRequestModel(startTime: self.startTime ?? "", endTime: self.endTime ?? "", startLocation: pickupcityName ?? "", direction: strDirection ?? "", serviceType: "outstation", vehicleType: "", classType: "", distance:self.distanceValue ,matchExactTime: true)
                print("getAllProjectionAvailable: ",getAllProjectionAvailable)
                UserDefaults.standard.setValue(self.startTime, forKey: "journeyTime")
                UserDefaults.standard.setValue(self.endTime, forKey: "journeyEndTime")
                UserDefaults.standard.setValue(pickupcityName, forKey: "fromLocation")
                UserDefaults.standard.setValue(self.distanceValue, forKey: "distance")
                UserDefaults.standard.setValue("outstation", forKey: "serviceType")
                UserDefaults.standard.setValue(strDirection, forKey: "direction")
                
                if (NetworkMonitor.share.isConnected == false){
                        self.view.makeToast(ErrorMessage.list.checkyourinternetconnectivity)
                            return
                }
                    
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
                            carTypeVc.estimatedKM = self.estimatedDurationInTraffic
                            carTypeVc.pickUpCityName = self.pickupcityName ?? ""
                            carTypeVc.dropCityName = self.destinationcityName ?? ""
                            carTypeVc.pickUpOnDate = self.pickUpDatePickerButton.titleLabel?.text ?? ""
                            carTypeVc.returnByDate = self.returnByDatePickerButton.titleLabel?.text ?? ""
                            carTypeVc.pickUpOnTime = self.pickUpOnTimePickerButton.titleLabel?.text ?? ""
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
            else{
                self.view.makeToast(ErrorMessage.list.pleasewait)
            }
        }
    }
    
    func pickupGetCurrentLocation() {
        print("Current Location Button Clicked")
        self.btnConfirmLocation.isHidden = false
        self.viewCabsButton.isHidden = true
        self.pickUpTextField.text = usercurrentLocationAddress
        self.sourceCoordinate = userCurrentlocation
        
        print("userCurrentlocation:", userCurrentlocation ?? "")
        print("sourceCoordinate:", self.sourceCoordinate ?? "")
        
        strTxtFieldType = "ToDestination"
        mapView.isUserInteractionEnabled = false
        //        mapView.animate(toZoom: 20)
        
        let originmarkerImage = UIImage(named: "Pickuppoint")!.withRenderingMode(.alwaysTemplate)
        //creating a marker view
        let originmarkerView = UIImageView(image: originmarkerImage)
        originmarkerView.tintColor = UIColor.green
        
        if(self.sourceCoordinate != nil) {
            let originMarker = GMSMarker(position: self.sourceCoordinate)
            originMarker.map = self.mapView
            originMarker.iconView = originmarkerView
            originMarker.title = self.pickupName
        }
        
    }
    
    func pickupLocateUserOnMap() {
        print("Locate User on Map")
        self.btnConfirmLocation.isHidden = false
        self.locatePinImage.isHidden = false
        self.viewCabsButton.isHidden = true
        mapView.animate(toZoom: 10)
        mapView.isUserInteractionEnabled = true
        strTxtFieldType = "ToDestination"
        
        self.pickUpTextField.text = ""
        self.sourceCoordinate = nil
        
    }
    
    func dropLocateUserOnMap() {
        self.btnConfirmLocation.isHidden = false
        self.locatePinImage.isHidden = false
        self.viewCabsButton.isHidden = true
        mapView.animate(toZoom: 10)
        mapView.isUserInteractionEnabled = true
        strTxtFieldType = "FromDestination"
        
        self.dropTextField.text = ""
        self.destinationCoordinate = nil
    }
    
    func clearMap() {
        pickUpTextField.text?.removeAll()
        sourceCoordinate = nil
        isconfirmLocation = false
        sourceCoordinate = userCurrentlocation
        
        dropTextField.text?.removeAll()
        destinationCoordinate = nil
        isconfirmLocation = false
        mapView.clear()
        
        roundTripButton.backgroundColor = .black
        oneWayButton.backgroundColor = .white
        
        setTimeToPicker()
        strStartTime = ""
        
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
           
            cell.layer.cornerRadius = 10.0
            if indexPath.row == 0 {
                cell.backgroundColor = .systemGray5
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
            cell?.backgroundColor = .systemGray5
            print("usercurrentLocationAddress :  ", usercurrentLocationAddress ?? "")
            self.mapView.isUserInteractionEnabled = false
            if indexPath.row == 0 {
                rentalTag = 0
                strServiceType = "Outstation"
                print("Selected Service Type : ", strServiceType ?? "")
                selectPackageView.isHidden = true
                if returnByDatePickerButton.isHidden == true {
                    returnByDatePickerButton.isHidden = false
                    returnByLable.isHidden = false
                }
                roundTripButton.setTitle("ROUND TRIP", for: .normal)
                oneWayButton.setTitle("ONE WAY", for: .normal)
                
                clearMap()
                self.pickUpTextField.text = self.usercurrentLocationAddress
                self.sourceCoordinate = userCurrentlocation
                print("usercurrentLocationAddress:",usercurrentLocationAddress ?? "")
                selectedTripType = "Outstation"
                print("Outstation:", roundTripButton.titleLabel?.text, oneWayButton.titleLabel?.text)
                pickUpDatePickerButton.setTitle(currentDateString, for: .normal)
                returnByDatePickerButton.setTitle(currentDateString, for: .normal)
            } else if indexPath.row == 1 {
                
                rentalTag = 1
                strServiceType = "Airport"
                print("Selected Service Type : ", strServiceType ?? "")
                roundTripButton.setTitle("AIRPORT PICKUP", for: .normal)
                oneWayButton.setTitle("AIRPORT DROP", for: .normal)
                
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
                print("usercurrentLocationAddress:",usercurrentLocationAddress)
                selectedTripType = "Airport"
//                selectedTripTypeMode = "Airport Pickup"
                strDirection = "AIRPORT PICKUP"
                selectedTripTypeMode = "AIRPORT PICKUP"
                strServiceType = "Airport"
                
                print("Airport:", roundTripButton.titleLabel?.text, oneWayButton.titleLabel?.text)
                pickUpDatePickerButton.setTitle(currentDateString, for: .normal)
                returnByDatePickerButton.setTitle(currentDateString, for: .normal)
            } else if indexPath.row == 2 {
                
                rentalTag = 2
                strServiceType = "Rental"
                print("Selected Service Type : ", strServiceType ?? "")
                roundTripButton.setTitle("CURRENT BOOKING", for: .normal)
                oneWayButton.setTitle("SCHEDULE BOOKING", for: .normal)
                
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
                print("usercurrentLocationAddress:",usercurrentLocationAddress)
                selectedTripType = "Rental"
//                selectedTripTypeMode = "CURRENT BOOKING"
                
                strDirection = "CURRENT BOOKING"
                selectedTripTypeMode = "CURRENT BOOKING"
                strServiceType = "Rental"
                print("Rental:", roundTripButton.titleLabel?.text, oneWayButton.titleLabel?.text)
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
        blackScreen.isHidden=false
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
    
    
    func wrapperFunctionToShowPosition(mapView:GMSMapView, coordinate : CLLocationCoordinate2D, fieldtype: String){
        
        mapView.isUserInteractionEnabled = false
        
        let geocoder = GMSGeocoder()
        let latitute = coordinate.latitude
        let longitude = coordinate.longitude
        let position = CLLocationCoordinate2DMake(latitute, longitude)
        geocoder.reverseGeocodeCoordinate(position) { response , error in
            if error != nil {
                print("GMSReverseGeocode Error: \(String(describing: error?.localizedDescription))")
            }else {
                if let location = response?.firstResult() {
                    let lines = location.lines! as [String]
                    
                    print("address from wrapperfunct ",self.selectedPickUpAddress)
                    
                    
                    if(fieldtype == "ToDestination"){
                        self.selectedPickUpAddress = lines.joined(separator: "\n")
                        self.pickUpTextField.text = self.selectedPickUpAddress
                        UserDefaults.standard.setValue(self.selectedPickUpAddress, forKey:"SourceAddress")
                        self.pickupcityName = response?.firstResult()?.locality
                        print("pickupcityName:", self.pickupcityName ?? "")
                        UserDefaults.standard.setValue(self.pickupcityName, forKey:"PickupCityName")
                        //                            print("sourceTextfield text:  ",self.pickupTextField.text , self.selectedAddress)
                        
                    }else if(fieldtype == "FromDestination"){
                        self.selectedDropAddress = lines.joined(separator: "\n")
                        self.dropTextField.text = self.selectedDropAddress
                        print(self.selectedDropAddress)
                        UserDefaults.standard.setValue(self.selectedDropAddress, forKey:"DestinationAddress")
                        self.destinationcityName = response?.firstResult()?.locality
                        print("destinationcityName:", self.destinationcityName ?? "")
                        UserDefaults.standard.setValue(self.destinationcityName, forKey: "DestinationCityName")
                    }
                }
            }
        }
    }
    
    
    
    //MARK:- DRAW POLYLINE
    func drawpolyLine(from source: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D){
        
        print("Draw Polyline")
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        guard let url = URL(string: "https://maps.googleapis.com/maps/api/directions/json?origin=\(source.latitude),\(source.longitude)&destination=\(destination.latitude),\(destination.longitude)&sensor=false&mode=driving&key=\(googleMapKey)") else {
            return
        }
        let originmarkerImage = UIImage(named: "Pickuppoint")!.withRenderingMode(.alwaysTemplate)
        //creating a marker view
        let originmarkerView = UIImageView(image: originmarkerImage)
        originmarkerView.tintColor = UIColor.green
        
        let destinationmarkerImage = UIImage(named: "DropPoint")!.withRenderingMode(.alwaysTemplate)
        //creating a marker view
        let destinationmarkerView = UIImageView(image: destinationmarkerImage)
        destinationmarkerView.tintColor = UIColor.red
        
        
        let originMarker = GMSMarker(position: self.sourceCoordinate)
        originMarker.map = self.mapView
        originMarker.iconView = originmarkerView
        originMarker.title = self.pickupName
        
        let destinationMarker = GMSMarker(position: self.destinationCoordinate)
        destinationMarker.map = self.mapView
        destinationMarker.iconView = destinationmarkerView
        destinationMarker.title = self.destionationName
        
        
        
        DispatchQueue.main.async {
            
            session.dataTask(with: url) { (data, response, error) in
                print("Inside Polyline ", data != nil)
                guard data != nil else {
                    return
                }
                do {
                    let route = try JSONDecoder().decode(MapPath.self, from: data!)
                    if let points = route.routes?.first?.overview_polyline?.points {
                        
                        self.drawPath(with: points)
                    }
                    //                     print(route.routes?.first?.overview_polyline?.points)
                    
                } catch let error {
                    print("Failed to draw ",error.localizedDescription)
                    //                    self.view.makeToast(ErrorMessage.list.notabletodrawroute.localize())
                }
            }.resume()
        }
    }
    
    private func drawPath(with points : String){
        print("Drawing Polyline ", points)
        DispatchQueue.main.async {
            guard let path = GMSPath(fromEncodedPath: points) else { return }
            let polyline = GMSPolyline(path: path)
            polyline.strokeWidth = 3.0
            polyline.strokeColor = .black
            polyline.map = self.mapView
            var bounds = GMSCoordinateBounds()
            for index in 1...path.count() {
                bounds = bounds.includingCoordinate(path.coordinate(at: index))
            }
            
            self.mapView.animate(with: GMSCameraUpdate.fit(bounds))
            
            if(self.sourceCoordinate != nil && self.destinationCoordinate != nil){
                self.durationDistance(origin: self.sourceCoordinate, destination: self.destinationCoordinate)
            }
            
        }
    }
    
    func durationDistance(origin: CLLocationCoordinate2D, destination: CLLocationCoordinate2D) {
        
        if (NetworkMonitor.share.isConnected == false){
            self.view.makeToast(ErrorMessage.list.checkyourinternetconnectivity)
            return
        }
        
        var urlString : String = "https://maps.googleapis.com/maps/api/distancematrix/json?departure_time=now&destinations=\(destination.latitude),\(destination.longitude)&origins=\(origin.latitude),\(origin.longitude)&key=\(googleMapKey)"
        
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!
        let session = URLSession.shared
        let url = URL(string:urlString)!
        session.dataTask(with: url) { [self] (data: Data?, response: URLResponse?, erorr: Error?) -> Void in
            print("url: \(urlString)")
            if let responseData = data {
                
                do{
                    let json = try JSONSerialization.jsonObject(with: responseData, options: JSONSerialization.ReadingOptions.allowFragments);
                    print(json);
                    
                    
                    let jsondata = try JSONSerialization.jsonObject(with: responseData, options: [])as! NSDictionary
                    
                    // print("json data is--->",jsondata)
                    self.get_dest = jsondata.object(forKey: "destination_addresses")as! NSArray
                    //                    var get_dest1 : String = ""
                    //                    get_dest1 = self.get_dest.object(at: 0) as! String
                    // print("destination is--->",get_dest1)
                    self.org_add = jsondata.object(forKey: "origin_addresses")as! NSArray
                    //                    let get_org : String = self.org_add.object(at: 0)as! String
                    // print("original address is--->",get_org)
                    self.row_arr = jsondata.object(forKey: "rows")as! NSArray
                    //print("Rows Array is--->",self.row_arr)
                    let row_dic = self.row_arr.object(at: 0)as! NSDictionary
                    // print("Rows Dictionary is--->",row_dic)
                    self.ele_arr = row_dic.object(forKey: "elements")as! NSArray
                    // print("Elements is--->",self.ele_arr)
                    self.ele_dic = self.ele_arr.object(at: 0)as! NSDictionary
                    self.dist_dic = self.ele_dic.value(forKey: "distance")as! NSDictionary
                    self.distanceValue = ((self.dist_dic.object(forKey: "value")as? Double)!)/1000
                    print("distance value is--->",self.distanceValue as Any)
                    self.dur_dic = self.ele_dic.value(forKey: "duration")as! NSDictionary
                    // print("duration text is--->",self.dur_dic.object(forKey: "text")as! String)
                    // print("duration value is--->",self.dur_dic.object(forKey: "value")as! Int)
                    
                    self.dur_dic_traffic = self.ele_dic.value(forKey: "duration_in_traffic")as! NSDictionary
                    if (self.dur_dic_traffic.count == 0 ) {
                        print("Empty")
                    }
                    else {
                        print("Not Empty")
                        print("duration_in_traffic text is--->",self.dur_dic_traffic.object(forKey: "text")as! String)
                        print("duration_in_traffic value is--->",self.dur_dic_traffic.object(forKey: "value")as! Int)
                        estimatedDurationInTraffic = self.dur_dic_traffic.object(forKey: "value")as! Int / 100
                        print("estimatedDurationInTraffic:", estimatedDurationInTraffic)
                        self.durationInTrafficWithText = self.dur_dic_traffic.object(forKey: "text") as? NSString
                        UserDefaults.standard.setValue(self.durationInTrafficWithText, forKey: "DurationInTraffic")
                    }
                    
                    
                    
                    //                                self.distanceInKm = (inputString! as AnyObject).replacingOccurrences(of: "hours", with: "") as NSString
                    //
                    //                    self.durationInTraffic  = Double(self.dur_dic_traffic.object(forKey: "value")as! Int)/3600.0
                    //                                print("duration_in_traffic value is--->",self.durationInTraffic as Any)
                    //
                    //                                print("duration_in_traffic value is--->",self.dur_dic_traffic.object(forKey: "value")as! Int)
                    //print("status---->",self.ele_dic.object(forKey: "status")as! String)
                    
                }
                catch{
                    print("do not serialization :)");
                }
            }
        }.resume();
    }
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        
        
        
        //        if(sourceCoordinate == nil || destinationCoordinate == nil){
        
        let lat = position.target.latitude
        let lng = position.target.longitude
        
        debugPrint(lat,lng)
        
        let userLocation: CLLocationCoordinate2D!
        userLocation = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        
        guard let locValue: CLLocationCoordinate2D = userLocation else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        let geocoder = GMSGeocoder()
        geocoder.reverseGeocodeCoordinate(userLocation) { response, error in
            if let location = response?.firstResult() {
                let lines = location.lines! as [String]
                //                        self.selectedAddress = lines.joined(separator: "\n")
                if(self.isconfirmLocation == false){
                    if(self.strTxtFieldType == "ToDestination")
                    {
                        self.selectedPickUpAddress = lines.joined(separator: "\n")
                        self.sourceCoordinate = userLocation
                        self.pickUpTextField.text = self.selectedPickUpAddress
                    }
                    else if self.strTxtFieldType == "FromDestination" {
                        self.selectedDropAddress = lines.joined(separator: "\n")
                        self.destinationCoordinate = userLocation
                        self.dropTextField.text = self.selectedDropAddress
                        print(self.selectedDropAddress)
                    }
                }
            }
            
        }
        //        }
        //       else{
        //                print("Coordinates are there")
        //        }
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
            let epvc = storyboard?.instantiateViewController(withIdentifier: "EditProfileVC") as! EditProfileVC
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
        case .safty:
            print("Safty")
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
                    
                    //                    self.mapView.animate(toLocation: self.sourceCoordinate)
                    //                    self.mapView.selectedMarker = marker
                    self.strTxtFieldType = "ToDestination"
                    self.usercurrentLocationAddress = lines.joined(separator: "\n")
                    self.pickUpTextField.text = self.usercurrentLocationAddress
                    self.userCurrentlocation = locValue
                }
            }
        }
        
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
                let str : NSString = dics.type as NSString
                
                print("Address Dics for pickup: \(dics)")
                
                if (str == "country") {
                    print("Country: \(dics.name)")
                    //self.pais = dics.name
                }
                else if (str == "administrative_area_level_2") {
                    print("City: \(dics.name)")
                    //                            pickupcityName = dics.name
                    //  self.ciudad = dics.name
                }
                else if(str == "locality")
                {
                    
                    pickupcityName = dics.shortName
                    print ("localoty name : \(dics.name)")
                    print("locality shortname : \(dics.shortName)")
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
            userSourceLocation = ["sourceLat": sourceLat, "sourceLon": sourceLon]
            //UserDefaults.standard.set(["lat": sourceLat, "lon": sourceLon], forKey:"SourceCoordinate")
            UserDefaults.standard.setValue(userSourceLocation, forKey:"SourceCoordinate")
            UserDefaults.standard.setValue(self.pickupcityName, forKey: "PickupCityName")
            self.btnConfirmLocation.isHidden = false
            
            
        }
        else if strTxtFieldType == "FromDestination"
        {
            self.dropTextField.text = place.formattedAddress
            print(place.formattedAddress)
            UserDefaults.standard.setValue(place.formattedAddress, forKey:"DestinationAddress")
            
            //            self.selectedFromDestination = place
            destinationCoordinate = place.coordinate
            destionationName = place.name
            
            let arrays : NSArray = place.addressComponents! as NSArray
            for i in 0..<arrays.count {
                
                let dics : GMSAddressComponent = arrays[i] as! GMSAddressComponent
                let str : NSString = dics.type as NSString
                
                if (str == "country") {
                    print("Country: \(dics.name)")
                    //self.pais = dics.name
                }
                else if (str == "administrative_area_level_2") {
                    print("City: \(dics.name)")
                    //                         destinationcityName = dics.name
                    //  self.ciudad = dics.name
                }
                else if(str == "locality")
                {
                    destinationcityName = dics.shortName
                    print ("localoty name : \(dics.name)")
                    print("locality shortname : \(dics.shortName)")
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
            
            UserDefaults.standard.setValue(self.destinationcityName, forKey: "DestinationCityName")
            self.btnConfirmLocation.isHidden = false
            
            
        }
        
        print("Place attributions: \(String(describing: place.attributions))")
        self.dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        //print("Error: \(error.description)")
        self.dismiss(animated: true, completion: nil)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        print("Autocomplete was cancelled.")
        
        // self.strTxtFieldType = "ToDestination"
        // self.pickupTextField.text = self.usercurrentLocationAddress
        self.dismiss(animated: true) {
            if self.pickUpTextField.text == "" {
                self.strTxtFieldType = "ToDestination"
                self.pickUpTextField.text = self.usercurrentLocationAddress
                self.sourceCoordinate = self.userCurrentlocation
            }
            //                   else if (self.pickupTextField.text?.isEmpty == false){
            //                    self.strTxtFieldType = "ToDestination"
            //                    self.pickupTextField.text = "Previously selected value"
            //                   }
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
