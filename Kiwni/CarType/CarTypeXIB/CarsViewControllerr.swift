////
////  CarsViewController.swift
////  Kiwni_User_App
////
////  Created by Shubham Shinde on 10/02/22.
////
//
//import UIKit
//
//
//class CarsViewControllerr: UIViewController, UITableViewDelegate, UITableViewDataSource, PaymentDelegate3, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, PaymentDelegate {
//    func payment(getName: String) {
//        let next = storyboard?.instantiateViewController(withIdentifier: "BookingDetailsViewController") as! BookingDetailsViewController
//        navigationController?.pushViewController(next, animated: true)
//    }
//
//    func goPaymeny() {
//        print("PaymentDelegate3 call")
//        let next = storyboard?.instantiateViewController(withIdentifier: "BookingDetailsViewController") as! BookingDetailsViewController
//
//        navigationController?.pushViewController(next, animated: true)
//
//    }
//
//
//
//
//    
//
//
//    @IBOutlet weak var tripTypeLabel: UILabel!
//    @IBOutlet weak var tripLabel: UILabel!
////    @IBOutlet weak var dateTimeView: UIView!
//    @IBOutlet weak var calenderImageView: UIImageView!
//    @IBOutlet weak var timeImageView: UIImageView!
//    @IBOutlet weak var dateLabel: UILabel!
//    @IBOutlet weak var timeLabel: UILabel!
//    @IBOutlet weak var filterView: UIView!
////    @IBOutlet weak var sortImageView: UIImageView!
////    @IBOutlet weak var filterImageView: UIImageView!
////    @IBOutlet weak var mapImageView: UIImageView!
//    @IBOutlet weak var sortButton: UIButton!
//    @IBOutlet weak var filterButton: UIButton!
//    @IBOutlet weak var mapButton: UIButton!
////    @IBOutlet weak var carsUIView: UIView!
//    @IBOutlet weak var viewheight: NSLayoutConstraint!
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
////        self.view.addSubview(self.navigationView)
////        self.view.addSubview(self.baseStackView)
////        self.view.addSubview(self.tableBaseView)
////        self.baseStackView.addSubview(self.packageView)
////        self.baseStackView.addSubview(self.vehicletypeView)
////        self.tableBaseView.addSubview(self.carsTableView)
//       
//
//
//
////      navigationView.addBottomBorderWithColor(color: .black, width: 0.5, frameWidth: screenWidth)
//    }
//
//    @IBAction func viewDetailsButtonPressed(_ sender: UIButton) {
//        guard let popupViewController = ViewDetailsViewController.instantiate() else { return }
//        popupViewController.delegate = self
//
//        //        popupViewController.titleString = "I am custom popup"
//
//        let popupVC = PopupViewController(contentController: popupViewController, position: .bottom(0), popupWidth: self.view.frame.width, popupHeight: 468)
//        popupVC.cornerRadius = 15
//        popupVC.backgroundAlpha = 0.0
//        popupVC.backgroundColor = .clear
//        popupVC.canTapOutsideToDismiss = true
//        popupVC.shadowEnabled = true
//        popupVC.delegate = self
//        popupVC.modalPresentationStyle = .popover
//        self.present(popupVC, animated: true, completion: nil)
//    }
//
//    @IBAction func sortButtonPressed(_ sender: UIButton) {
//        let svc = storyboard?.instantiateViewController(withIdentifier: "SortViewController") as! SortViewController
//        navigationController?.pushViewController(svc, animated: true)
//    }
//
//    @IBAction func filterButtonPressed(_ sender: UIButton) {
//        let fvc = storyboard?.instantiateViewController(withIdentifier: "FilterViewController") as! FilterViewController
//        navigationController?.pushViewController(fvc, animated: true)
//    }
//
//    @IBAction func mapButtonPressed(_ sender: UIButton) {
//    }
//
//
//
//    @IBAction func backButtonPressed(_ sender: UIButton) {
//        let hvc = navigationController?.viewControllers[3] as! CarTypesViewController
//        navigationController?.popToViewController(hvc, animated: true)
//    }
//
//
//
//    
//
//}
//
//extension CarsViewController : PopupViewControllerDelegate, ViewDetailsPopupViewDelegate {
//
//
//    public func popupViewControllerDidDismissByTapGesture(_ sender: PopupViewController)
//    {
//        dismiss(animated: true)
//        {
//            debugPrint("Popup Dismiss")
//        }
//    }
//
//    func customPopupViewExtension(sender: ViewDetailsViewController, didSelectNumber: Int) {
//        dismiss(animated: true)
//        {
//            if didSelectNumber == 1
//            {
//                debugPrint("Custom Popup Dismiss On Done Button Action")
//            }
//        }
//    }
//
//
//}
