//
//  Google Map Extension.swift
//  Kiwni
//
//  Created by Shubham Shinde on 03/05/22.
//

import Foundation
import GoogleMaps
import GooglePlaces

extension HomeViewController {
    
    private struct MapPath : Decodable{
       var routes : [Route]?
   }
   
    private struct Route : Decodable{
       
       var overview_polyline : OverView?
   }
   
    private struct OverView : Decodable {
       
       var points : String?
   }
    
    //MARK:- Calculate End Time
    func calculateEndTime(startTime: NSString){
        
        let str : String = (self.durationInTrafficWithText ?? "")
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
                self.journeyendTime = inputString.replacingOccurrences(of: "+0530", with: "Z")
                print("endTime : \(String(describing: self.journeyendTime))")
                
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
                self.journeyendTime = inputString.replacingOccurrences(of: "+0530", with: "Z")
                print("endTime : \(String(describing: self.journeyendTime))")
                
            } else if arr.count == 1
            {
                print(arr)
                min = arr[0]*60
                let addminutes = date.addingTimeInterval(TimeInterval(min))
                
                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                let after_add_time = formatter.string(from: addminutes)
                print("after add time-->",after_add_time as Any)
                
                let inputString = after_add_time
                self.journeyendTime = inputString.replacingOccurrences(of: "+0530", with: "Z")
                print("endTime : \(String(describing: self.journeyendTime))")
            }
        }
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
    
    func clearTextFieldWithMap() {
        pickUpTextField.text?.removeAll()
        sourceCoordinate = nil
        isconfirmLocation = false
        sourceCoordinate = userCurrentlocation
        
        dropTextField.text?.removeAll()
        destinationCoordinate = nil
        isconfirmLocation = false
        mapView.clear()
        
        setTimeToPicker()
        strStartTime = ""
        
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
    
    
    
    
    
    func drawPath(with points : String){
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
                        self.durationInTrafficWithText = self.dur_dic_traffic.object(forKey: "text") as? String
                        UserDefaults.standard.setValue(self.durationInTrafficWithText, forKey: "DurationInTraffic")
                    }
                }
                catch{
                    print("do not serialization :)");
                }
            }
        }.resume();
    }
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        let lat = position.target.latitude
        let lng = position.target.longitude
        
        let userLocation: CLLocationCoordinate2D!
        userLocation = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        
        guard let locValue: CLLocationCoordinate2D = userLocation else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        let geocoder = GMSGeocoder()
        geocoder.reverseGeocodeCoordinate(userLocation) { response, error in
            if let location = response?.firstResult() {
                let lines = location.lines! as [String]
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
    }
    
    
    
}
