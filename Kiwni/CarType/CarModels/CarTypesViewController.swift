//
//  CarTypesViewController.swift
//  Kiwni_User_App
//
//  Created by Shubham Shinde on 10/02/22.
//

import UIKit
import MapKit
import GoogleMaps
import GooglePlaces

class CarTypesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, GMSMapViewDelegate {
    
    @IBOutlet weak var packageBorderView: UIView!
    @IBOutlet weak var hoursPackegeCollectionView: UICollectionView!
    @IBOutlet weak var packageView: UIView!
    var hoursArray = ["2hr", "4hr", "6hr", "8hr", "10hr", "12hr"]
    var kmArray = ["25km", "40km", "60km", "80km", "100km", "120km"]
    
    var carArray = ["Sedan", "Suv", "Tempo Traveller"]
    var carImageArray = ["sedan", "SUV"]
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var tripTypeLabel: UILabel!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var tripVenueLabel: UILabel!
    @IBOutlet weak var dateTimeView: UIView!
    @IBOutlet weak var dateImage: UIImageView!
    @IBOutlet weak var timeImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var carTypeTableView: UITableView!
    @IBOutlet weak var packageDetailsLabel: UILabel!
    @IBOutlet weak var rentalPackageRuleLabel: UILabel!
    @IBOutlet weak var viewDetailsButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var estKMImage: UIImageView!
    @IBOutlet weak var estKMLabel: UILabel!
    
    var googleMapKey = "AIzaSyDnaIPR6Tp0sgrhj-fcXLivvaILrOdQMhs"
    
    var pickedSourceCoordinate : CLLocationCoordinate2D!
    var pickedDropCoordinate : CLLocationCoordinate2D!
    
    private struct Route : Decodable{
        
        var overview_polyline : OverView?
    }
    
    private struct MapPath : Decodable{
        var routes : [Route]?
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
    
    var selectedPickUpAddress: String = ""
    var selectedDropAddress: String = ""
    
    var estimatedKM : Double = 0
    var pickUpCityName: String = ""
    var dropCityName: String = ""
    var pickUpOnDate: String = ""
    var returnByDate: String = ""
    var pickUpOnTime: String = ""
    var tripType: String = ""
    var tripTypeMode: String = ""
//    var finalArray : [ScheduleDate] = []
//    var selectedArray : [ScheduleDate] = []
    
    var dictForScheduleDates: NSDictionary! = nil
    var vehicleDetailsList : [VehicleDetails] = []
    var finalArray : [VehicleDetails] = []
    var keyArray : [String] = []
    
    @IBOutlet weak var callButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(estimatedKM)
//        print("dictForScheduleDates:",dictForScheduleDates)
        estKMLabel.text = "Est.km -\(forTrailingZero(temp: round(estimatedKM)))km"

        pickUpCityName = UserDefaults.standard.string(forKey: "PickupCityName") ?? ""
        dropCityName = UserDefaults.standard.string(forKey: "DestinationCityName") ?? ""
        
        tripVenueLabel.text = "\(pickUpCityName) To \(dropCityName)"
        dateLabel.text = pickUpOnDate
        timeLabel.text = pickUpOnTime
        tripTypeLabel.text = "\(tripType) (\(tripTypeMode))"
        UserDefaults.standard.setValue(tripTypeLabel.text, forKey: "tripType")
        UserDefaults.standard.setValue(dateLabel.text, forKey: "pickupDate")
        UserDefaults.standard.setValue(timeLabel.text, forKey: "pickupTime")
        print(pickedSourceCoordinate as Any, pickedDropCoordinate as Any)
        print(pickUpCityName, dropCityName)
        print(pickUpOnDate, returnByDate)
        print(pickUpOnTime)
        print(tripType)
        
        self.hoursPackegeCollectionView.register(UINib(nibName: "RentalHoursPackageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        if rentalTag != 2 {
            packageView.isHidden = true
        }
        hoursPackegeCollectionView.reloadData()
        hoursPackegeCollectionView.allowsMultipleSelection = false
        
        mapView.isUserInteractionEnabled = false
        if(pickedSourceCoordinate != nil && pickedDropCoordinate != nil)
        {
            wrapperFunctionToShowPosition(mapView: mapView, coordinate: pickedSourceCoordinate, fieldtype: "ToDestination")
            wrapperFunctionToShowPosition(mapView: mapView, coordinate: pickedDropCoordinate, fieldtype: "FromDestination")
            
            self.drawpolyLine(from: pickedSourceCoordinate, to: pickedDropCoordinate)
            
        } else {
            print("sourceCoordinate or destinationCoordinate are nil")
        }
        
//        self.dictForScheduleDates = dictscheduleDates as NSDictionary
        self.vehicleDetailsList.removeAll()
        for (key, value) in self.dictForScheduleDates { //SUV, SEDAN
            self.keyArray.append(key as! String)
            if let classType = value as? [String:[String:[VehicleDetails]]] {  // LUXURY, ULTRA-LUXURY, PREMIUM
                print("classType value found:")
                
                for value in classType.values{
                    if let model = value as? [String:[VehicleDetails]] {  // AUDI 8, AUDI 4, MAHINDRA
                        print("model value found")
                        for value in model.values{
                            if let vehicleDetails = value as? [VehicleDetails]{
                                print("vehicleDetails found")
                                self.vehicleDetailsList.append(contentsOf: vehicleDetails)
                            }
                        }
                        
                    }
                }
            }
        }
        carTypeTableView.reloadData()
        
    }
    
    @IBAction func viewDetailsButtonPressed(_ sender: UIButton) {
        guard let popupViewController = ViewDetailsViewController.instantiate() else { return }
        popupViewController.delegate = self
        
        //        popupViewController.titleString = "I am custom popup"
        
        let popupVC = PopupViewController(contentController: popupViewController, position: .bottom(0), popupWidth: self.view.frame.width, popupHeight: 468)
        popupVC.cornerRadius = 15
        popupVC.backgroundAlpha = 0.0
        popupVC.backgroundColor = .clear
        popupVC.canTapOutsideToDismiss = true
        popupVC.shadowEnabled = true
        popupVC.delegate = self
        popupVC.modalPresentationStyle = .popover
        self.present(popupVC, animated: true, completion: nil)
    }
    
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        
//        let homeVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GoToHome") as! HomeViewController
//        navigationController?.pushViewController(homeVc, animated: true)
        
        navigationController?.popViewController(animated: true)
        
//        let hvc = navigationController?.viewControllers[2] as! HomeViewController
//        navigationController?.popToViewController(hvc, animated: true)
//        rentalTag = 0
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return keyArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = carTypeTableView.dequeueReusableCell(withIdentifier: "cell") as! CarTypeTableViewCell
        
        let selectedVehicles =  vehicleDetailsList.filter { vehicleDetails in
            vehicleDetails.vehicle?.vehicleType == keyArray[indexPath.row]
        }
        
        var modelClassInfoSet :Set<ModelClassInfo> = []
        
        for selectedVehicle in selectedVehicles {
            let modelClassInfo = ModelClassInfo(modelName: selectedVehicle.model, className: selectedVehicle.classType, selectionData: [])
            modelClassInfoSet.insert(modelClassInfo)
        }
       
        var estimatedPriceList : [Double] = []
        estimatedPriceList = []
        estimatedPriceList.removeAll()
        for selectedVehicle in selectedVehicles {
            estimatedPriceList.append(round(selectedVehicle.price))
        }
        
        print("estimatedPriceList Array : ", estimatedPriceList)
        print("estimatedPriceList array count:", estimatedPriceList.count)
        estimatedPriceList.sort()
        print("estimatedPriceList sorted Array : ", estimatedPriceList)
        print(estimatedPriceList.first, estimatedPriceList.last)
       
        var modelClassInfoList : [ModelClassInfo] = []
        
        for list in modelClassInfoSet {
            modelClassInfoList.append(list)
        }
        
        print("selectedVehicles Array : ", modelClassInfoList)
        print("selectedVehicles array count:", modelClassInfoList.count)
        cell.selectionStyle = .none
        cell.baseView.layer.cornerRadius = 10.0
        cell.baseView.layer.borderWidth = 1.0
        cell.baseView.layer.borderColor = UIColor.lightGray.cgColor
        cell.carTypeLabel.text = keyArray[indexPath.row]
        cell.availabelStatus.text = "Availabel \(modelClassInfoList.count)"
        cell.seaterLabel.text = "\(selectedVehicles[indexPath.row].vehicle?.capacity ?? 0) + 1 Seater"
        cell.carTypeImage.image = UIImage(named: keyArray[indexPath.row])
//        cell.priceLabel.text = "₹ \(estimatedPriceList.first ?? 0) - \(estimatedPriceList.last ?? 0)"
        cell.priceLabel.text = "₹ \(forTrailingZero(temp: estimatedPriceList.first ?? 0)) - \(forTrailingZero(temp: estimatedPriceList.last ?? 0))"
        return cell
    }
    
    

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 143
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
            
        print("Vehicle type: ",keyArray[indexPath.row])
        let selectedVehicles =  vehicleDetailsList.filter { vehicleDetails in
            vehicleDetails.vehicle?.vehicleType == keyArray[indexPath.row]
            
        }
        
        var modelClassInfoSet :Set<ModelClassInfo> = []
        self.showIndicator(withTitle: "Loading", and: "Please Wait")
        for selectedVehicle in selectedVehicles {
            let modelClassInfo = ModelClassInfo(modelName: selectedVehicle.model, className: selectedVehicle.classType, imagePath: selectedVehicle.imagePath, selectionData: [])
            
            modelClassInfoSet.insert(modelClassInfo)
        }
        
        
        
        var modelClassInfoList : [ModelClassInfo] = []
        
        for list in modelClassInfoSet {
            modelClassInfoList.append(list)
        }
        self.hideIndicator()
        print("selectedVehicles Array : ", modelClassInfoList)
        print("selectedVehicles array count:", modelClassInfoList.count)
     
        
        
        let VC = UIStoryboard(name: "FindCar", bundle: nil).instantiateViewController(withIdentifier: "CarsViewController") as! CarsViewController
        VC.carTypeString = keyArray[indexPath.row]
        VC.carsArray = modelClassInfoList
        VC.vehicleDetailsList = vehicleDetailsList
        VC.estimatedKM = round(estimatedKM)
        navigationController?.pushViewController(VC, animated: true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hoursArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = hoursPackegeCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! RentalHoursPackageCollectionViewCell
        cell.hoursLable.text = hoursArray[indexPath.row]
        cell.kmLable.text = kmArray[indexPath.row]
        cell.layer.cornerRadius = 8.0
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.5
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("didSelectItemAt")
        let hoursCell = hoursPackegeCollectionView.cellForItem(at: indexPath) as! RentalHoursPackageCollectionViewCell
        if hoursCell.layer.borderColor == UIColor.lightGray.cgColor {
            hoursCell.layer.borderColor = UIColor.black.cgColor
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let hoursCell = hoursPackegeCollectionView.cellForItem(at: indexPath) as! RentalHoursPackageCollectionViewCell
        hoursCell.layer.borderColor = UIColor.lightGray.cgColor
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    
}


extension CarTypesViewController : PopupViewControllerDelegate, ViewDetailsPopupViewDelegate {
    
    
    public func popupViewControllerDidDismissByTapGesture(_ sender: PopupViewController)
    {
        dismiss(animated: true)
        {
            debugPrint("Popup Dismiss")
        }
    }
    
    func customPopupViewExtension(sender: ViewDetailsViewController, didSelectNumber: Int) {
        dismiss(animated: true)
        {
            if didSelectNumber == 1
            {
                debugPrint("Custom Popup Dismiss On Done Button Action")
            }
        }
    }
    
    
}

extension CarTypesViewController {
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
        
        
        let originMarker = GMSMarker(position: self.pickedSourceCoordinate)
        originMarker.map = self.mapView
        originMarker.iconView = originmarkerView
        //        originMarker.title = self.pickupName
        
        let destinationMarker = GMSMarker(position: self.pickedDropCoordinate)
        destinationMarker.map = self.mapView
        destinationMarker.iconView = destinationmarkerView
        //        destinationMarker.title = self.destionationName
        
        
        
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
            
            if(self.pickedSourceCoordinate != nil && self.pickedDropCoordinate != nil){
                self.durationDistance(origin: self.pickedSourceCoordinate, destination: self.pickedDropCoordinate)
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
                    print("duration_in_traffic text is--->",self.dur_dic_traffic.object(forKey: "text")as! String)
                    
                    self.durationInTrafficWithText = self.dur_dic_traffic.object(forKey: "text") as? NSString
                    
                    UserDefaults.standard.setValue(self.durationInTrafficWithText, forKey: "DurationInTraffic")
                    
                    //                                self.distanceInKm = (inputString! as AnyObject).replacingOccurrences(of: "hours", with: "") as NSString
                    //
                    self.durationInTraffic  = Double(self.dur_dic_traffic.object(forKey: "value")as! Int)/3600.0
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
                        //                        self.pickUpTextField.text = self.selectedPickUpAddress
                        UserDefaults.standard.setValue(self.selectedPickUpAddress, forKey:"SourceAddress")
                        //                        self.pickupcityName = response?.firstResult()?.locality
                        //                        UserDefaults.standard.setValue(self.pickupcityName, forKey:"PickupCityName")
                        //                            print("sourceTextfield text:  ",self.pickupTextField.text , self.selectedAddress)
                        
                    }else if(fieldtype == "FromDestination"){
                        self.selectedDropAddress = lines.joined(separator: "\n")
                        //                        self.dropTextField.text = self.selectedDropAddress
                        print(self.selectedDropAddress)
                        UserDefaults.standard.setValue(self.selectedDropAddress, forKey:"DestinationAddress")
                        //                        self.destinationcityName = response?.firstResult()?.locality
                        //                        UserDefaults.standard.setValue(self.destinationcityName, forKey: "DestinationCityName")
                    }
                }
            }
        }
    }
}
