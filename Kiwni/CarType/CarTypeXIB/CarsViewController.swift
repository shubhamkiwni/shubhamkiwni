//
//  ViewController.swift
//  ExpandListDemo
//
//  Created by Damini on 14/03/22.
//

import UIKit

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
        let next = UIStoryboard(name: "FindCar", bundle: nil).instantiateViewController(withIdentifier: "BookingDetailsViewController") as! BookingDetailsViewController
        navigationController?.pushViewController(next, animated: true)
    }
    
    
    
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
    var carsArray: [ScheduleDate] = []
    var tableViewData = [cellData]()
    var carTypeString = ""
    var hoursArray = ["2hr", "4hr", "6hr", "8hr", "10hr", "12hr"]
    var kmArray = ["25km", "40km", "60km", "80km", "100km", "120km"]
    var carModelArray: [ScheduleDate] = []
    var modelyearArray : [String]=[]
    override func viewDidLoad() {
        super.viewDidLoad()
        //        carsTableView.sectionHeaderHeight = 5.0
        carTypeLabel.text = carTypeString
        print("carsArray count: ",carsArray.count)
       // carsTableView.reloadData()
        //print("vehicleType: ",carsArray[0].vehicle?.vehicleType ?? "")
        self.hoursPackegeCollectionView.register(UINib(nibName: "RentalHoursPackageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        
        detailsView.layer.cornerRadius = 8.0
        detailsView.layer.borderWidth = 1.0
        detailsView.layer.borderColor = UIColor.lightGray.cgColor
        
        packageDetailsView.layer.cornerRadius = 8.0
        packageDetailsView.layer.borderWidth = 1.0
        packageDetailsView.layer.borderColor = UIColor.lightGray.cgColor
        
        
        for (index, object) in carsArray.enumerated() {
          print("Item at \(index): \(object)")
            tableViewData.append(cellData(opened: false, carType: carsArray[index].vehicle?.classType ?? "", carName: carsArray[index].vehicle?.model ?? "", avaiLabel: "AvaiLabel: 4", amount: "8000", selectionData: modelyearArray))
        }
//        print("tableViewData: ",tableViewData)
//        print("tableViewData Count: ",tableViewData.count)

        
       /* tableViewData = [cellData(opened: false, carType: "Premium", carName: "Mahindra", avaiLabel: "AvaiLabel: 4", amount: "2000", selectionData: ["2012", "2013", "2014", "2015", "2012", "2013", "2014", "2015"]),
                         cellData(opened: false, carType: "Luxury", carName: "Tata", avaiLabel: "AvaiLabel: 3", amount: "3000", selectionData: ["2011", "2012", "2013"]),
                         cellData(opened: false, carType: "Ultra-Luxury", carName: "BMW", avaiLabel: "AvaiLabel: 2", amount: "10000", selectionData: ["2020", "2021"]),
                         cellData(opened: false, carType: "Ultra-Luxury", carName: "BMW", avaiLabel: "AvaiLabel: 2", amount: "10000", selectionData: ["2020", "2021"]),
                         cellData(opened: false, carType: "Ultra-Luxury", carName: "BMW", avaiLabel: "AvaiLabel: 2", amount: "10000", selectionData: ["2020", "2021"]),
                         cellData(opened: false, carType: "Ultra-Luxury", carName: "BMW", avaiLabel: "AvaiLabel: 2", amount: "10000", selectionData: ["2020", "2021"]),
                         cellData(opened: false, carType: "Ultra-Luxury", carName: "BMW", avaiLabel: "AvaiLabel: 2", amount: "10000", selectionData: ["2020", "2021"])]*/
        
        if rentalTag != 2 {
            packageView.isHidden = true
        }
        //        let screenWidth = screenRect.size.width
        //let screenHeight = screenRect.size.height
        tableBaseView.layer.cornerRadius = 20.0
        carsTableView.layer.cornerRadius = 20.0
        //  carsTableView.layer.masksToBounds = true
        tableBaseView.layer.shadowColor = UIColor.black.cgColor
        tableBaseView.layer.shadowOpacity = 0.2
        tableBaseView.layer.shadowOffset = CGSize.zero
        tableBaseView.layer.shadowRadius = 5
        
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        //        let hvc = navigationController?.viewControllers[1] as! CarTypesViewController
        //        navigationController?.popToViewController(hvc, animated: true)
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
        tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewData[section].opened == true {
            return tableViewData[section].selectionData.count + 1
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = self.carsTableView.dequeueReusableCell(withIdentifier: "carCell") as! CarsTableViewCell
            
            cell.carTypeLabel.text = tableViewData[indexPath.section].carType
            cell.carNameLabel.text = tableViewData[indexPath.section].carName
            cell.avaiLabelStatus.text = tableViewData[indexPath.section].avaiLabel
//            cell.carTypeLabel.text = tableViewData[indexPath.section].carType
//           // print("Model name: ",carsArray[indexPath.row].model)
//            cell.carNameLabel.text = tableViewData[indexPath.section].carName
//            cell.avaiLabelStatus.text = tableViewData[indexPath.section].avaiLabel
            cell.layer.cornerRadius = 10.0
            cell.carsDetailsView.layer.cornerRadius = 10.0
            cell.carsDetailsView.layer.masksToBounds = false
            cell.carsDetailsView.layer.shadowColor = UIColor.black.cgColor
            cell.carsDetailsView.layer.shadowOpacity = 0.5
            cell.carsDetailsView.layer.shadowOffset = CGSize(width: -1, height: 1)
            cell.carsDetailsView.layer.shadowRadius = 1
            
            return cell
        } else {
            let seconCell = self.carsTableView.dequeueReusableCell(withIdentifier: "carModelCell") as! CarModelsTableViewCell
            seconCell.delegate1 = self
            
//            let years = "2010"
//            print(years)
//            let myDate = DateFormattingHelper.strToDateTime(strDateTime: years)
//            print("myDate: ", myDate)
            
        /*    if let myDate = DateFormattingHelper.strToDateTime(strDateTime: years)
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
            }*/
        seconCell.carModelRegisterYearLabel.text = "2020" //tableViewData[indexPath.section].selectionData[indexPath.row - 1]
         
            return seconCell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 105
        } else {
            return 80
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        for i in carsArray {
//            if ((i.model == carsArray[indexPath.row].model) )
//            {
//                if (i.vehicle?.classType == carsArray[indexPath.row].vehicle?.classType){
//                    carModelArray.append(i)
//                }
//            }
//        }
        
        carModelArray = []
        for i in carsArray {
         
                if i.vehicle?.model == carsArray[indexPath.row].model {
                   // print("From vehicle class type:", i.vehicle?.classType)
                    //print("From carsArray: ",carsArray[indexPath.row].vehicle?.classType)
                   
                    if (i.vehicle?.classType == carsArray[indexPath.row].vehicle?.classType){
                        carModelArray.append(i)
                    }
                  
                }
        }
//        print("Sorted Array Count : ",carModelArray.count)
//        print("Sorted Array : ", carModelArray)
//
//        print("CarModelArray : ",carModelArray)
        
        modelyearArray = []
        
        for (index, object) in carModelArray.enumerated() {
            modelyearArray.append(carModelArray[index].vehicle?.regYear ?? "")
            tableViewData = []
            tableViewData.append(cellData(opened: false, carType: carModelArray[index].vehicle?.classType ?? "", carName: carModelArray[index].vehicle?.model ?? "", avaiLabel: "AvaiLabel: 4", amount: "8000", selectionData: modelyearArray))
        }
        
        print("tableViewData: ",tableViewData)
        print("tableViewData Count: ",tableViewData.count)
        
        print("Model Array : ",modelyearArray)
        print("Model year array count : ", modelyearArray.count)
       
        
        carsTableView.reloadData()
        
        if tableViewData[indexPath.section].opened == true {
            tableViewData[indexPath.section].opened = false
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none)
        } else {
            tableViewData[indexPath.section].opened = true
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none)
        }
    }
}

