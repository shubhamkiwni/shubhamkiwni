//
//  UpdateAlertDetailViewController.swift
//  Kiwni
//
//  Created by Damini on 09/03/22.
//

import UIKit

class UpdateAlertDetailViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
   
    
    
    
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var updateAlertLabel: UILabel!
    @IBOutlet weak var contactDetailLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var footerView : UIView!
    @IBOutlet weak var cancelButton : UIButton!
    @IBOutlet weak var saveButton : UIButton!
    
    @IBOutlet weak var addPersonTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        addPersonTableView.delegate = self
        addPersonTableView.dataSource = self
//        button.addTarget(self, action: #selector(pressed), for: .touchUpInside)
    }
    
   
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return 2
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == 0){
            let cell  = tableView.dequeueReusableCell(withIdentifier: "ContactPersonTableViewCell") as! ContactPersonTableViewCell
            return cell
        }
        else{
            let cell  = tableView.dequeueReusableCell(withIdentifier: "AddNewPersonTableViewCell") as! AddNewPersonTableViewCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.row == 0){
            return 216
        }
        else{
            return 58
        }
    }
    
    
    @objc func pressed() {
        print("PROCEED TO PAY")
 
    }

    
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
