//
//  CustomPopupView.swift
//  BottomPopup
//
//  Created by Apple on 03/09/21.
//

import UIKit

protocol CustomPopupViewDelegate: AnyObject
{
    func customPopupViewExtension(sender: CustomPopupView, didSelectNumber : Int)
}

class CustomPopupView: UIViewController {
    
    @IBOutlet weak var saveFavLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var homeLabel: UILabel!
    @IBOutlet weak var workLabel: UILabel!
    @IBOutlet weak var otherLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    var buttonTag: Int = 0
    
    @IBOutlet var allCollection: [UIButton]!
    
    weak var delegate: CustomPopupViewDelegate?
    static func instantiate() -> CustomPopupView? {
        return CustomPopupView(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        if buttonTag == 1 {
            print(buttonTag)
        } else if buttonTag == 2 {
            print(buttonTag)
        } else if buttonTag == 3 {
            print(buttonTag)
        }
    }
    
    @IBAction func radioButtonPressed(_ sender: UIButton) {
        for button in allCollection {
            if button.tag == sender.tag {
                button.setImage(UIImage(named: "Check"), for: .normal)
                buttonTag = sender.tag
            } else {
                button.setImage(UIImage(named: "Uncheck"), for: .normal)
            }
        }
    }
}
