import Foundation
import UIKit
import SCLAlertView

func showAlert(msg:String){
    SCLAlertView().showError("Oops!", subTitle:msg)
}
func showSuccess(msg:String){
    SCLAlertView().showSuccess("Success", subTitle: msg)
}
func showNotice(msg:String){
    SCLAlertView().showNotice("Loading",subTitle:msg)
}
func splitString(str:String,delimiter:String) -> String{
    var returnString = ""
    for char in str {
        if(String(char) != delimiter){
            returnString += String(char)
        }else{
            returnString += String("-")
        }
    }
    return returnString
}
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}


