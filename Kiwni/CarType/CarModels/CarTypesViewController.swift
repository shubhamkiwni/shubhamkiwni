//
//  CarTypesViewController.swift
//  Kiwni_User_App
//
//  Created by Shubham Shinde on 10/02/22.
//

import UIKit
import MapKit
class CarTypesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var packageBorderView: UIView!
    @IBOutlet weak var hoursPackegeCollectionView: UICollectionView!
    @IBOutlet weak var packageView: UIView!
    var hoursArray = ["2hr", "4hr", "6hr", "8hr", "10hr", "12hr"]
    var kmArray = ["25km", "40km", "60km", "80km", "100km", "120km"]
    
    var carArray = ["Sedan", "Suv", "Tempo Traveller"]
    var carImageArray = ["sedan", "SUV", "TEMPO TRAVELLER"]
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var tripTypeLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        packageBorderView.layer.borderColor = UIColor.lightGray.cgColor
        packageBorderView.layer.borderWidth = 1
        self.hoursPackegeCollectionView.register(UINib(nibName: "RentalHoursPackageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        if rentalTag != 2 {
            packageView.isHidden = true
        }
        hoursPackegeCollectionView.reloadData()
        hoursPackegeCollectionView.allowsMultipleSelection = false
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
        let hvc = navigationController?.viewControllers[2] as! HomeViewController
        navigationController?.popToViewController(hvc, animated: true)
        rentalTag = 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = carTypeTableView.dequeueReusableCell(withIdentifier: "cell") as! CarTypeTableViewCell
        cell.baseView.layer.cornerRadius = 10.0
        cell.baseView.layer.borderWidth = 1.0
        cell.baseView.layer.borderColor = UIColor.lightGray.cgColor
        cell.carTypeLabel.text = carArray[indexPath.row]
        cell.carTypeImage.image = UIImage(named: carImageArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 143
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let VC = UIStoryboard(name: "FindCar", bundle: nil).instantiateViewController(withIdentifier: "CarsViewController") as! CarsViewController
        navigationController?.pushViewController(VC, animated: true)
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
