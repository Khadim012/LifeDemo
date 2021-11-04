//
//  CreateNewOrderVM.swift
//  LifeDemo
//
//  Created by Khadim Hussain on 03/11/2021.
//

import UIKit

class CreateNewOrderVM: UIView {


    @IBOutlet weak var viewPrescriptionDetails: UIView!
    @IBOutlet weak var viewAddressesDetails: UIView!
    @IBOutlet weak var viewAddNew: UIView!
    
    @IBOutlet weak var btnEntereRXNumber: UIButton!
    @IBOutlet weak var btnUploadeRXFile: UIButton!
    
    @IBOutlet weak var tbUserAdresses: UITableView!
    
    @IBOutlet weak var constraintTbAddressesHeight: NSLayoutConstraint!
    
    
    func setupUI() {
        
        viewPrescriptionDetails.addRoundedShadow()
        viewAddressesDetails.addRoundedShadow()
        
        btnEntereRXNumber.layer.borderWidth = 1.5
        btnUploadeRXFile.layer.borderWidth = 1.5
        
        btnEntereRXNumber.layer.borderColor = Constants.appColor.customButtonBorder.cgColor
        btnUploadeRXFile.layer.borderColor = Constants.appColor.customButtonBorder.cgColor
    }
    
    func registerCell() {

        tbUserAdresses.register(UINib(nibName: "UserAddressCell", bundle: nil), forCellReuseIdentifier: "UserAddressCell")
    }
}
