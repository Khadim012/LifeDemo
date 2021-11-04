//
//  SharedManager.swift
//  LifeDemo
//
//  Created by Khadim Hussain on 04/11/2021.
//

import UIKit
import SystemConfiguration

class SharedManager {
    
    static let shared = SharedManager()

    // MARK: - AlertView PopUp
    func showAlertView(source : UIViewController, title:String, message:String) {
        
        let alert = UIAlertController(title: title as String, message: message as String, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        source.present(alert, animated: true, completion: nil)
    }
}
