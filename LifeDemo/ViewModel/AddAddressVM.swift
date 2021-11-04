//
//  AddAddressVM.swift
//  LifeDemo
//
//  Created by Khadim Hussain on 03/11/2021.
//

import UIKit
import GoogleMaps

class AddAddressVM: UIView {

    @IBOutlet weak var lblHeading: UILabel!
    @IBOutlet weak var btnUpdate: UIButton!
    
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var viewSearchContainer: UIView!
    
    @IBOutlet var viewDashedLine: [UIView]!
    @IBOutlet weak var googleMaps: GMSMapView!
    
    //SearchView varibales and outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewMapSearch: UIView!
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtHhone: UITextField!
    @IBOutlet weak var txtFlatno: UITextField!
    @IBOutlet weak var txtBuilding: UITextField!
    @IBOutlet weak var txtStreetaddress: UITextField!
    @IBOutlet weak var txtArea: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtState: UITextField!
    @IBOutlet weak var txtCountry: UITextField!
    
    var locationManager = CLLocationManager()
    var isInitialised = false
    var currLocationLat = "0.0"
    var currLocationLng = "0.0"

    func setupUI(isUpdateAddress:Bool) {
        
        viewContainer.addRoundedShadow()
        viewSearchContainer.addRoundedShadow(0.5)
        
        viewDashedLine.forEach {
            
            $0.backgroundColor = .clear
            $0.makeDashedBorderLine()
        }
        
        
        //I'm inserting the values for update state
        if isUpdateAddress {
            
            btnUpdate.setTitle("UPDATE ADDRESS", for: .normal)
            lblHeading.text = "EDIT ADDRESS"
        }
        else {

            btnUpdate.setTitle("ADD NEW ADDRESS", for: .normal)
            lblHeading.text = "ADD NEW ADDRESS"
        }
    }
    
    func updateUserAddress(address: Address) {
        
        txtName.text = address.name
        txtHhone.text = address.phone
        txtFlatno.text = address.flatno
        txtBuilding.text = address.building
        txtStreetaddress.text = address.streetaddress
        txtArea.text = address.area
        txtCity.text = address.city
        txtState.text = address.state
        txtCountry.text = address.country
        
        currLocationLat = address.latitude ?? "0.0"
        currLocationLng = address.longitude ?? "0.0"
    }
    
    func registerCell() {

        tableView.register(UINib(nibName: "LocationCC", bundle: nil), forCellReuseIdentifier: "LocationCC")
    }
}
