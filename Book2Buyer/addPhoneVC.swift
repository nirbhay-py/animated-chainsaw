//
//  addPhoneVC.swift
//  Book2Buyer
//
//  Created by Nirbhay Singh on 24/02/20.
//  Copyright © 2020 Nirbhay Singh. All rights reserved.
//

import UIKit
import JGProgressHUD

class addPhoneVC: UIViewController {

    @IBOutlet weak var mainTf: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
         navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    @IBAction func submit(_ sender: Any) {
        if(mainTf.text==""){
            showAlert(msg: "You can't leave this field blank!")
        }
        else if(mainTf.text?.count != 10){
            showAlert(msg: "That does not look like a valid phone number.")
        }else{
            let hud = JGProgressHUD.init()
            hud.show(in: self.view)
            let res = rootUser.updatePhone(phoneNo: mainTf.text!)
            if(res){
                showAlert(msg: "There was an error in updating your information")
            }else{
                showSuccess(msg: "Updated with success.")
                self.performSegue(withIdentifier: "updated", sender: self)
            }
        }
    }
    
}
