//
//  HomeScreenViewModel.swift
//  LifeDemo
//
//  Created by Khadim Hussain on 03/11/2021.
//

import UIKit

class HomeScreenViewModel: UIView {

    @IBOutlet weak var viewCreateOrder: UIView!
    @IBOutlet weak var viewMyAddresses: UIView!
    
    var arrAddresses: [String]?
  
    func setupUI() {
        
        viewCreateOrder.addRoundedShadow()
        viewMyAddresses.addRoundedShadow()
    }
}
