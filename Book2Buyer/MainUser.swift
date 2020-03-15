
import Foundation
import Firebase
import JGProgressHUD


class MainUser
{
    var name:String!
    var email:String!
    var photoUrl:String!
    var booksPutUpForSale:Int!
    var booksPurchased:Int!
    var karma:Int!
    var givenName:String!
    var phone:String!
    var givenPhone:Bool!
    init(name:String,email:String,photoUrl:String,booksPutUpForSale:Int,givenName:String,booksPurchased:Int,karma:Int,phone:String,givenPhone:Bool) {
        self.name = name
        self.email = email
        self.photoUrl = photoUrl
        self.booksPutUpForSale = booksPutUpForSale
        self.booksPurchased = booksPurchased
        self.karma = karma
        self.givenName = givenName
        self.phone = phone
        self.givenPhone = givenPhone
       }
    func addKarma(toAdd:Int) -> Bool {
        var err = false
        self.karma += toAdd
        let ref = Firebase.Database.database().reference().child("user-node").child(splitString(str: self.email, delimiter: "."))
        let updates:[String:Int]=["karma":self.karma]
        ref.updateChildValues(updates,withCompletionBlock: { error,ref in
            if(error != nil){
                showAlert(msg: error!.localizedDescription)
                err = true
            }
        })
        return err
    }
    func putBookUpWithSuccess() -> Bool {
        var err = false
        self.booksPutUpForSale += 1
        let ref = Firebase.Database.database().reference().child("user-node").child(splitString(str: self.email, delimiter: "."))
        let updates:[String:Int]=["booksPutUp":self.booksPutUpForSale]
        ref.updateChildValues(updates,withCompletionBlock: { error,ref in
            if(error != nil){
                showAlert(msg: error!.localizedDescription)
                err = true
            }
        })
        return err
    }
    func purchasedBook() -> Bool {
        var err = false
        self.booksPurchased += 1
        let ref = Firebase.Database.database().reference().child("user-node").child(splitString(str: self.email, delimiter: "."))
        let updates:[String:Int]=["booksPurchased":self.booksPurchased]
        ref.updateChildValues(updates,withCompletionBlock: { error,ref in
            if(error != nil){
                showAlert(msg: error!.localizedDescription)
                err = true
            }
        })
        return err
    }
    func refreshUser() {
        let ref = Firebase.Database.database().reference().child("user-node").child(splitString(str: self.email, delimiter: "."))
        ref.observeSingleEvent(of: .value, with: {(snapshot) in
            let value = snapshot.value as? NSDictionary
            let karma = value!["karma"] as! Int
            let booksPurchased = value!["booksPurchased"] as! Int
            let booksPutUp = value!["booksPutUp"] as! Int
            self.karma = karma
            self.booksPurchased = booksPurchased
            self.booksPutUpForSale = booksPutUp
        }){ (error) in
            print(error.localizedDescription)
            showAlert(msg: error.localizedDescription)
        }
    }
    func updatePhone(phoneNo:String) -> Bool{
        var err = false
        self.phone = phoneNo
        self.givenPhone = true
        let ref = Firebase.Database.database().reference().child("user-node").child(splitString(str: self.email, delimiter: "."))
        let updates:[String:Any]=["phoneNo":self.phone as Any,"givenPhone":true]
        ref.updateChildValues(updates,withCompletionBlock: { error,ref in
            if(error != nil){
                showAlert(msg: error!.localizedDescription)
                err = true
            }
        })
        return err
    }
}
