//
//  profileVC.swift
//  Book2Buyer
//
//  Created by Nirbhay Singh on 23/02/20.
//  Copyright © 2020 Nirbhay Singh. All rights reserved.
//

import UIKit
import Firebase
import JGProgressHUD
class profileVC: UIViewController {

    @IBOutlet weak var addPhoneBtn: UIButton!
    @IBOutlet weak var purchasedLbl: UILabel!
    @IBOutlet weak var putUpLbl: UILabel!
    @IBOutlet weak var karmaLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        rootUser.refreshUser()
        do{
            try profileImg.load(url: URL(string: rootUser.photoUrl)!)
        }
        catch{
            //do nothing
        }
        karmaLbl.text = String(rootUser.karma) + " points"
        nameLbl.text = "Hi, " + rootUser.givenName
        putUpLbl.text = String(rootUser.booksPutUpForSale) + " books"
        purchasedLbl.text = String(rootUser.booksPurchased) + " books"
    }
    @IBAction func signOut(_ sender: Any) {
        let hud = JGProgressHUD.init()
        hud.show(in: self.view,animated: true)
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
          self.performSegue(withIdentifier: "signOut", sender: self)
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
        hud.dismiss()
    }
    override func viewDidAppear(_ animated: Bool) {
        if(rootUser.givenPhone){
            addPhoneBtn.isHidden = true
        }
    }
}
