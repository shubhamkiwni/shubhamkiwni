//
//  ViewController.swift
//  ExpandListDemo
//
//  Created by Damini on 14/03/22.
//

import UIKit
import Reachability

struct cellData {
    var opened = Bool()
    var carType = String()
    var carName = String()
    var avaiLabel = String()
    var amount = String()
    var selectionData = [String]()
}

class CarsViewController: UIViewController, UITableViewDelegate,UITableViewDataSource,  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, PaymentDelegate {
    func payment(getName: String) {
        print("Click")
    }
    
    func review() {
        let reviewVC = storyboard?.instantiateViewController(withIdentifier: "ReviewViewController") as! ReviewViewController
        present(reviewVC, animated: true, completion: nil)
    }
    
    
//    func payment(getName: String) {
//
//        let next = UIStoryboard(name: "FindCar", bundle: nil).instantiateViewController(withIdentifier: "BookingDetailsViewController") as! BookingDetailsViewController
//        navigationController?.pushViewController(next, animated: true)
//    }
    
    
    
    //    @IBOutlet weak var viewDetailsButton: UIButton!
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var packageView: UIView!
    @IBOutlet weak var packageDetailsView: UIView!
    @IBOutlet weak var baseStackView : UIStackView!
    @IBOutlet weak var vehicletypeView : UIView!
    @IBOutlet weak var tableBaseView : UIView!
    @IBOutlet weak var carsTableView: UITableView!
    @IBOutlet weak var carTypeLabel: UILabel!
    @IBOutlet weak var acLabel: UILabel!
    @IBOutlet weak var tripTypeLabel: UILabel!
    @IBOutlet weak var tripLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var seatCapacityLabel: UILabel!
    @IBOutlet weak var acImageView: UIImageView!
    @IBOutlet weak var seatImageView: UIImageView!
    @IBOutlet weak var bagImageView: UIImageView!
    @IBOutlet weak var luggageCapasityLabel: UILabel!
    @IBOutlet weak var packageDetailsLabel: UILabel!
    @IBOutlet weak var rentalPackageRuleLabel: UILabel!
    @IBOutlet weak var viewDetailsButton: UIButton!
    @IBOutlet weak var hoursPackegeCollectionView: UICollectionView!
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var estimatedKmLabel: UILabel!
    @IBOutlet weak var sortButton: UIButton!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var mapButton: UIButton!
    
    var tableViewData = [VehicleDetails]()
//    var tableViewData = [cellData]()
    var carTypeString = ""
    var hoursArray = ["2hr", "4hr", "6hr", "8hr", "10hr", "12hr"]
    var kmArray = ["25km", "40km", "60km", "80km", "100km", "120km"]
    var carModelArray: [VehicleDetails] = []
    var imageurlString : String? = ""
    
    var carsArray: [ModelClassInfo] = []
    var vehicleSortedArray : [VehicleDetails] = []
    var vehicleDetailsList : [VehicleDetails] = []
    var selectedIndex : NSInteger! = nil
    var clickedPath: IndexPath? = nil
    
    var estimatedKM : Double = 0
    var pickUpCityName: String = ""
    var dropCityName: String = ""
    var pickUpOnDate: String = ""
    var returnByDate: String = ""
    var pickUpOnTime: String = ""
    var tripType: String = ""
    var tripTypeMode: String = ""
    let reachability = try! Reachability()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        acLabel.font = UIFont.fontStyle(13, .regular)
        tripTypeLabel.font = UIFont.fontStyle(17, .regular)
        tripLabel.font = UIFont.fontStyle(15, .semiBold)
        dateLabel.font = UIFont.fontStyle(12, .regular)
        timeLabel.font = UIFont.fontStyle(12, .regular)
        estimatedKmLabel.font = UIFont.fontStyle(12, .regular)
        seatCapacityLabel.font = UIFont.fontStyle(13, .regular)
        luggageCapasityLabel.font = UIFont.fontStyle(13, .regular)
        packageDetailsLabel.font = UIFont.fontStyle(10, .regular)
        rentalPackageRuleLabel.font = UIFont.fontStyle(10, .regular)
        viewDetailsButton.titleLabel?.font = UIFont.fontStyle(10, .regular)
        sortButton.titleLabel?.font = UIFont.fontStyle(15, .regular)
        filterButton.titleLabel?.font = UIFont.fontStyle(15, .regular)
        mapButton.titleLabel?.font = UIFont.fontStyle(15, .regular)
        
        carTypeLabel.text = carTypeString
        estimatedKmLabel.text = "Est.Km - \(forTrailingZero(temp: estimatedKM) )km "

        pickUpCityName = UserDefaults.standard.string(forKey: "PickupCityName") ?? ""
        dropCityName = UserDefaults.standard.string(forKey: "DestinationCityName") ?? ""
        
        tripLabel.text = "\(pickUpCityName) To \(dropCityName)"
        dateLabel.text = UserDefaults.standard.string(forKey: "pickupDate") ?? ""
        timeLabel.text = UserDefaults.standard.string(forKey: "pickupTime") ?? ""
        tripTypeLabel.text = UserDefaults.standard.string(forKey: "tripType") ?? ""
        print(pickUpCityName, dropCityName)
        print(pickUpOnDate, returnByDate)
        print(pickUpOnTime)
        print(tripType)
        

        self.hoursPackegeCollectionView.register(UINib(nibName: "RentalHoursPackageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        
        detailsView.layer.cornerRadius = 8.0
        detailsView.layer.borderWidth = 1.0
        detailsView.layer.borderColor = UIColor.lightGray.cgColor
        
        packageDetailsView.layer.cornerRadius = 8.0
        packageDetailsView.layer.borderWidth = 1.0
        packageDetailsView.layer.borderColor = UIColor.lightGray.cgColor
        
        
        if rentalTag != 2 {
            packageView.isHidden = true
        }
        
        tableBaseView.layer.cornerRadius = 20.0
        carsTableView.layer.cornerRadius = 20.0
        tableBaseView.layer.shadowColor = UIColor.black.cgColor
        tableBaseView.layer.shadowOpacity = 0.2
        tableBaseView.layer.shadowOffset = CGSize.zero
        tableBaseView.layer.shadowRadius = 5
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
    
    @IBAction func sortButtonPressed(_ sender: UIButton) {
        let svc = storyboard?.instantiateViewController(withIdentifier: "SortViewController") as! SortViewController
        navigationController?.pushViewController(svc, animated: true)
    }
    
    @IBAction func filterButtonPressed(_ sender: UIButton) {
        let fvc = storyboard?.instantiateViewController(withIdentifier: "FilterViewController") as! FilterViewController
        navigationController?.pushViewController(fvc, animated: true)
    }
    
    @IBAction func mapButtonPressed(_ sender: UIButton) {
        let mvc = storyboard?.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        navigationController?.pushViewController(mvc, animated: true)
    }
    
    @IBAction func callButtonAction(_ sender: UIButton) {
        if let phoneCallURL = URL(string: "telprompt://1234567890") {

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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hoursArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = hoursPackegeCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! RentalHoursPackageCollectionViewCell
        cell.hoursLable.text = hoursArray[indexPath.row]
        cell.kmLable.text = kmArray[indexPath.row]
        cell.hoursLable.font = UIFont.fontStyle(13, .regular)
        cell.kmLable.font = UIFont.fontStyle(10, .regular)
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 100, height: 42)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        carsArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if carsArray[section].opened == true {
            return carsArray[section].selectionData.count + 1
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = self.carsTableView.dequeueReusableCell(withIdentifier: "carCell") as! CarsTableViewCell
        
            selectedIndex = indexPath.section
            
            if(carsArray.isEmpty == false){
                let selectedModelInfo = carsArray[selectedIndex]
                vehicleSortedArray.removeAll()
                vehicleSortedArray = vehicleDetailsList.filter({ vehicleDetails in
                    vehicleDetails.model == selectedModelInfo.modelName &&
                    vehicleDetails.classType == selectedModelInfo.className
                })
            }
            else{
                print("Out of range")
            }
            print("After selecting vehicle key value",vehicleSortedArray)
            print("After selecting vehicle key value.count",vehicleSortedArray.count)
            
            var estimatedPriceArr : [Double] = []
            estimatedPriceArr.removeAll()
            for pricevalue in vehicleSortedArray{
                estimatedPriceArr.append(pricevalue.price)
            }
            estimatedPriceArr.sort()
            print("estimatedPriceArr: ",estimatedPriceArr)
            print("estimatedPriceArr.count: ",estimatedPriceArr.count)
            
            
//            let firstprice = String(round(estimatedPriceArr.first ?? 0))
//            let lastPrice = String(round(estimatedPriceArr.last ?? 0))
          
            carsArray[selectedIndex].selectionData = []
            
            for i in 0 ..< vehicleSortedArray.count
            {
                
                carsArray[selectedIndex].selectionData.append(carDetails(regyear: vehicleSortedArray[i].vehicle?.regYear,
                                                                         providername: vehicleSortedArray[i].vehicle?.provider?.name,
                                                                         providerID: vehicleSortedArray[i].vehicle?.provider?.id, vehicalID: vehicleSortedArray[i].vehicleId, vehicleNumb: vehicleSortedArray[i].vehicle?.regNo,
                                                                         driverID: 0,
                                                                         driverLicense: "",
                                                                         driverName: "",
                                                                         driverPhone: "",
                                                                         scheduleID: vehicleSortedArray[i].vehicle?.id,
                                                                         distance: "",
                                                                         fromLocation: "",
                                                                         toLocation: "",
                                                                         journeyEndTime: "",
                                                                         journeyTime: "",
                                                                         estimatedPrice: vehicleSortedArray[i].price, rate: vehicleSortedArray[i].vehicle?.rates ?? []))
            }
            print("finalArray[selectedIndex]",carsArray[selectedIndex])
 
            cell.carTypeLabel.text = carsArray[indexPath.section].className
            cell.carNameLabel.text = carsArray[indexPath.section].modelName
            
            let imageString : String
            imageString = carsArray[indexPath.section].imagePath ?? ""
//          print("imageString : \(imageString)")
            
           
            let url = URL(string: "https://kiwni.com/car_images/\(imageString)")
            let data = try? Data(contentsOf: url!)
            cell.carImage.image = UIImage(data: data!)
            
        
            if estimatedPriceArr.count == 1 {
                cell.priceLabel.text = "??? \(forTrailingZero(temp: round(estimatedPriceArr.first ?? 0)))"
            } else {
                cell.priceLabel.text = "??? \(forTrailingZero(temp: round(estimatedPriceArr.first ?? 0))) - \(forTrailingZero(temp: round(estimatedPriceArr.last ?? 0)))"
            }
            
            UserDefaults.standard.setValue(cell.carTypeLabel.text, forKey: "classType")
            UserDefaults.standard.setValue(cell.carNameLabel.text, forKey: "modelName")
            
            print("Count Value:",carsArray[indexPath.section].selectionData.count)
            cell.avaiLabelStatus.text = "Availabel \(vehicleSortedArray.count)"
            return cell
        } else {
            let seconCell = self.carsTableView.dequeueReusableCell(withIdentifier: "carModelCell") as! CarModelsTableViewCell
            seconCell.delegate1 = self
            seconCell.star1.setTitle("", for: .normal)
            seconCell.star2.setTitle("", for: .normal)
            seconCell.star3.setTitle("", for: .normal)
            seconCell.star4.setTitle("", for: .normal)
            seconCell.star5.setTitle("", for: .normal)
            
            dropShadow(seconCell.bookButton)
            
       if let myDate = DateFormattingHelper.strToDateTime(strDateTime: carsArray[indexPath.section].selectionData[indexPath.row - 1].regyear)
            {
                print("myDate: ", myDate)
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
                formatter.timeZone = TimeZone(identifier: "UTC")
                let myString = formatter.string(from: myDate)
                let yourDate: Date? = formatter.date(from: myString)
                formatter.dateFormat = "yyyy"
                let dateStr = formatter.string(from: yourDate!)
                print("dateStr : ", dateStr)
                
                formatter.dateFormat = "hh:mm a"
                let timeStr = formatter.string(from: yourDate!)
                print("timeStr : ", timeStr)
                seconCell.carModelRegisterYearLabel.text = dateStr
//                scheduledateLabel.text = "\(dateStr), \(timeStr)"
                print("Str time from popup : ","\(dateStr), \(timeStr)" )
            } else {
                print("add another format")
            }
            seconCell.vehicalProviderLabel.text = carsArray[indexPath.section].selectionData[indexPath.row - 1].providername
            
//            let priceString =  String(round(carsArray[indexPath.section].selectionData[indexPath.row - 1].estimatedPrice ?? 0))
            seconCell.fareLabel.text = "??? \(forTrailingZero(temp: round(carsArray[indexPath.section].selectionData[indexPath.row - 1].estimatedPrice ?? 0)))/-"
            seconCell.delegate1 = self
            return seconCell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return 110
        } else {
            return 100
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if carsArray[indexPath.section].opened == true {
            carsArray[indexPath.section].opened = false
            let sections = IndexSet.init(integer: indexPath.section)
            carsTableView.reloadSections(sections, with: .none)
        } else {
            selectedIndex = indexPath.section
            
            if(carsArray.isEmpty == false){
                let selectedModelInfo = carsArray[selectedIndex]
                vehicleSortedArray.removeAll()
                vehicleSortedArray = vehicleDetailsList.filter({ vehicleDetails in
                    vehicleDetails.model == selectedModelInfo.modelName &&
                    vehicleDetails.classType == selectedModelInfo.className
                })
            }
            else{
                print("Out of range")
            }
            print("After selecting vehicle key value",vehicleSortedArray)
            print("After selecting vehicle key value.count",vehicleSortedArray.count)
          
            carsArray[selectedIndex].selectionData = []
            
            for i in 0 ..< vehicleSortedArray.count
            {
                carsArray[selectedIndex].selectionData.append(carDetails(regyear: vehicleSortedArray[i].vehicle?.regYear, providername: vehicleSortedArray[i].vehicle?.provider?.name, rate:vehicleSortedArray[i].vehicle?.rates ?? []))
                
            }
            print("finalArray[selectedIndex]",carsArray[selectedIndex])
            carsArray[indexPath.section].opened = true
            let sections = IndexSet.init(integer: indexPath.section)
            
            self.showIndicator(withTitle: "Loading", and: "Please Wait")
            DispatchQueue.main.async {
                self.hideIndicator()
                self.carsTableView.reloadSections(sections, with: .none)
            }
        }
    }
    
    func bookButtonPressed(_ cell: CarModelsTableViewCell) {
        if let indexPath = self.carsTableView.indexPath(for: cell) {
            clickedPath = indexPath
            print(clickedPath ?? "")
            if let indexPath = clickedPath {
                print(indexPath)
                print("cell selected data: ",carsArray[indexPath.section].selectionData[indexPath.row - 1])
                print(carsArray[indexPath.section])
                
            }
            let next = UIStoryboard(name: "FindCar", bundle: nil).instantiateViewController(withIdentifier: "BookingDetailsViewController") as! BookingDetailsViewController
            next.selectedCarValue = carsArray[indexPath.section].selectionData[indexPath.row - 1]
            next.strClasstype = carsArray[indexPath.section].className ?? ""
            next.carImagePath = carsArray[indexPath.section].imagePath ?? ""
            navigationController?.pushViewController(next, animated: true)
        }
    }
}

extension UIView{
    func applyShadow(cornerRadius : CGFloat){
        
        layer.cornerRadius = 10.0
        layer.masksToBounds = false
        layer.shadowRadius = 4.0
        layer.shadowOpacity = 0.30
        layer.shadowColor = UIColor.gray.cgColor
//        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowOffset = CGSize(width: 1, height: 1)
        
    }
}
