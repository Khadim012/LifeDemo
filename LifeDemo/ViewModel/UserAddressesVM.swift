//
//  UserAddressesVM.swift
//  LifeDemo
//
//  Created by Khadim Hussain on 03/11/2021.
//

import UIKit

class UserAddressesVM: UIView {
    
    @IBOutlet weak var tbAdresses: UITableView!
    
    
    func registerCell() {

        tbAdresses.register(UINib(nibName: "UserAddressCell", bundle: nil), forCellReuseIdentifier: "UserAddressCell")
    }
}

