//
//  AddressSearchViewController.swift
//  AutoTextFieldDemo
//
//  Created by Damini on 07/06/22.
//

import UIKit
import GoogleMaps
import GooglePlaces
import DropDown
import CoreLocation

typealias callback  = (String) -> Void

typealias getSelectedAddressBack = (String,String, CLLocationCoordinate2D) -> Void

class AddressSearchViewController: UIViewController , UITextFieldDelegate, pickupOnlocateSearchdelegate , UITableViewDelegate, UITableViewDataSource {
    func pickupGetCurrentLocation() {
        print("Pickup Get Current Location")
        navigationController?.popToRootViewController(animated: true)
        if let locateonmapcallback = locateonmapcallback{
            locateonmapcallback("CurrentLocation")
        }
    }
    
    func pickupLocateUserOnMap() {
        print("Pickup Get Current Location")
        navigationController?.popToRootViewController(animated: true)
        if let locateonmapcallback = locateonmapcallback{
            locateonmapcallback("ToDestination")
        }
        
    }
    
    func dropLocateUserOnMap() {
        print("Drop Locate User on Map")
        navigationController?.popToRootViewController(animated: true)
        if let locateonmapcallback = locateonmapcallback{
            locateonmapcallback("FromDestination")
        }
    }
    
    let pickupLocationSearchView: PickupLocationOnSearchView = UINib(nibName: "PickupLocationOnSearchView", bundle: Bundle.main).instantiate(withOwner: nil, options: nil)[0] as! PickupLocationOnSearchView
    
    
    @IBOutlet weak var addressSerachTextField : UITextField!
    
    var locateonmapcallback : callback?
    var searchAddressLocation : getSelectedAddressBack?
    
    var strTxtFieldType : String = ""
    var strAddressPickupTextFieldType : String = ""
    var strLocationAddress : String = ""
    
    @IBOutlet weak var addressTableView : UITableView!
    @IBOutlet weak var backButton: UIButton!
    var predictionData = [String]()
    var fetcher: GMSAutocompleteFetcher?
    var placesClient: GMSPlacesClient!
    var tableData = [String]()
    let dropDown = DropDown()
    
    let footerView = UIView()
    
    var selectedAddressCoordinate: CLLocationCoordinate2D!
    var selectedAddress : String = ""
    var address = [LocationAddress]()
    var pickupDelegate : pickupOnlocateSearchdelegate!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        address = DataBaseHelper.shareinstance.getData()
        
        addressSerachTextField.becomeFirstResponder()
        addressSerachTextField.delegate = self
        addressSerachTextField.text = strLocationAddress
       
        print("addressSerachTextField.text: ", addressSerachTextField.text)
        
        UITextField.appearance(whenContainedInInstancesOf: [AddressSearchViewController.self]).inputAccessoryView = pickupLocationSearchView
        pickupLocationSearchView.delegate = self
        
        if(strTxtFieldType == "ToDestination"){
            pickupLocationSearchView.pickupCurrentLocation.isHidden = false
            pickupLocationSearchView.pickupLocateOnMap.isHidden = false
            pickupLocationSearchView.dropLocateOnMap.isHidden = true
            
        }else if(strTxtFieldType == "FromDestination"){
            pickupLocationSearchView.pickupCurrentLocation.isHidden = true
            pickupLocationSearchView.pickupLocateOnMap.isHidden = true
            pickupLocationSearchView.dropLocateOnMap.isHidden = false
            
        }
        
        addressSerachTextField.delegate = self
        addressTableView.delegate = self
        addressTableView.dataSource = self
        addressTableView.backgroundColor = .lightGray
        addressTableView.allowsSelection = true
        addressTableView.bounces = false
        addressTableView.showsVerticalScrollIndicator = true
     
        
        pickupLocationSearchView.delegate = self
        placesClient = GMSPlacesClient.shared()
        
        self.edgesForExtendedLayout = []
       
        let neBoundsCorner = CLLocationCoordinate2D(latitude: -33.843366,
                                                    longitude: 151.134002)
        let swBoundsCorner = CLLocationCoordinate2D(latitude: -33.875725,
                                                    longitude: 151.200349)
        let bounds = GMSCoordinateBounds(coordinate: neBoundsCorner,
                                         coordinate: swBoundsCorner)
        
        // Set up the autocomplete filter.
        let filter = GMSAutocompleteFilter()
        filter.type = .establishment
        
        // Create the fetcher.
        fetcher = GMSAutocompleteFetcher(filter: filter)
        fetcher?.delegate = self as? GMSAutocompleteFetcherDelegate
        addressSerachTextField.addTarget(self, action: #selector(textFieldDidChanged), for: UIControl.Event.editingChanged)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        addressSerachTextField.becomeFirstResponder()
        addressSerachTextField.selectedTextRange = addressSerachTextField.textRange(from: addressSerachTextField.beginningOfDocument, to: addressSerachTextField.endOfDocument)
        
        
    }
    
    @IBAction func backButtonClick(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        if let locateonmapcallback = locateonmapcallback{
            locateonmapcallback("NoLocationSelected")
        }
    }
    
 
    @objc func textFieldDidChanged(_ textField:UITextField ){
        
        self.fetcher?.sourceTextHasChanged(self.addressSerachTextField.text!)
        dropDown.dataSource = predictionData
        dropDown.anchorView = textField
        dropDown.bottomOffset = CGPoint(x: 0, y: addressSerachTextField.frame.size.height) //6
        dropDown.show()
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in //8
            guard let _ = self else { return }
            self!.addressSerachTextField.text = item
            let place_id : String = self?.tableData[index] ?? ""
            print("Place Id : ", place_id)
            self?.getCoordinate(placeidString: place_id)
            
        }
    }
    
    func getCoordinate(placeidString : String){
        
        let placesClient = placesClient
        placesClient?.lookUpPlaceID(placeidString) { (place, error) in
            if let error = error {
                print("lookup place id query error: \(error.localizedDescription)")
                return
            }
            
            guard let place = place else {
                print("No place details for \(placeidString)")
                return
            }
            
            let searchedLatitude = place.coordinate.latitude
            let searchedLongitude = place.coordinate.longitude
            let place_name  = place.formattedAddress
            
            print("Place Name : ", place.formattedAddress ?? "")
            print("searchedLatitude: ",searchedLatitude)
            print("searchedLongitude: ",searchedLongitude)
            
            self.selectedAddressCoordinate = CLLocationCoordinate2D(latitude: searchedLatitude, longitude: searchedLongitude)
            self.selectedAddress = place_name ?? ""
            
            if(self.strTxtFieldType == "ToDestination"){
                self.strAddressPickupTextFieldType = "pickupTextFieldFromDropDown"
                self.navigationController?.popToRootViewController(animated: true)
                if let locateonmapcallback = self.searchAddressLocation{
                    locateonmapcallback(self.strAddressPickupTextFieldType, self.selectedAddress, self.selectedAddressCoordinate)
                    
                }
                
              
                
            }else  if(self.strTxtFieldType == "FromDestination"){
                self.strAddressPickupTextFieldType = "destinationTextFieldFromDropDown"
                self.navigationController?.popToRootViewController(animated: true)
                if let locateonmapcallback = self.searchAddressLocation{
                    locateonmapcallback(self.strAddressPickupTextFieldType, self.selectedAddress, self.selectedAddressCoordinate)
                    
                }
               
              
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return address.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = addressTableView.dequeueReusableCell(withIdentifier: "cell") as! AddressTableViewCell
        if address[indexPath.row].addressType == "Home" {
            cell.addressTypeImageView.image = UIImage(named: "Home")
        } else if address[indexPath.row].addressType == "Work" {
            cell.addressTypeImageView.image = UIImage(named: "Work")
        } else {
            cell.addressTypeImageView.image = UIImage(named: "Other")
        }
        
        
        
        cell.addressTypeValue.text = address[indexPath.row].addressType
        cell.addressValue.text = address[indexPath.row].addressValue
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("IndexPath : ", indexPath.row)
        
        let getLatitude = Double(address[indexPath.row].addressLat ?? "")
        let getLongitude = Double(address[indexPath.row].addressLong ?? "")
        
        selectedAddressCoordinate = CLLocationCoordinate2D(latitude: getLatitude ?? 0.0, longitude: getLongitude ?? 0.0)
        selectedAddress = address[indexPath.row].addressValue ?? ""
        
        if(self.strTxtFieldType == "ToDestination"){
            self.strAddressPickupTextFieldType = "pickupTextFieldFromDropDown"
            self.navigationController?.popToRootViewController(animated: true)
            if let locateonmapcallback = self.searchAddressLocation{
                locateonmapcallback(self.strAddressPickupTextFieldType, self.selectedAddress, self.selectedAddressCoordinate)
                
            }
        }
        navigationController?.popToRootViewController(animated: true)
    }
        
}


extension AddressSearchViewController: GMSAutocompleteFetcherDelegate {
    func didAutocomplete(with predictions: [GMSAutocompletePrediction]) {
        predictionData.removeAll()
        tableData.removeAll()
        for prediction in predictions {
            predictionData.append(prediction.attributedFullText.string)
            tableData.append(prediction.placeID)
        }
        
        
        print("Prediction data count : ", predictionData.count)
    }
    
    func didFailAutocompleteWithError(_ error: Error) {
        print(error.localizedDescription)
    }
}
