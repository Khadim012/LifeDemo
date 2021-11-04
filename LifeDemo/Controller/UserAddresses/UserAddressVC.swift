//
//  UserAddressVC.swift
//  LifeDemo
//
//  Created by Khadim Hussain on 03/11/2021.
//

import UIKit

class UserAddressVC: UIViewController {

    
    @IBOutlet var userAddressesVM: UserAddressesVM!
    
    var arrAddress : [Address]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.userAddressesVM.registerCell()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.performWSToGetAddresses()
    }
    
    @IBAction func didTapBack(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapAddAddress(_ sender: Any) {

        let vc = AddAddressVC.instantiate(fromAppStoryboard: .Main)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK:- UITableView Delegates & DataSource
extension UserAddressVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let addresses = self.arrAddress {

            return addresses.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
        // We can make it dynaimic but i use static according to the data
        return 86
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "UserAddressCell") as? UserAddressCell {
            
            if let address = self.arrAddress?[indexPath.row] {
                
                
                cell.imgCheck.isHidden = true
                cell.lblAddress.text = "\(address.name ?? "") \(address.phone ?? "") \(address.flatno ?? "") \(address.building ?? "") \(address.city ?? "") \(address.state ?? "") \(address.country ?? "")"
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let address = self.arrAddress?[indexPath.row] {
            
            let vc = AddAddressVC.instantiate(fromAppStoryboard: .Main)
            vc.isUpdateAddress = true
            vc.userAddress = address
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

//MARK:- WebServices
extension UserAddressVC {
    
    func performWSToGetAddresses() {
       
        WebServices.URLResponse("Address_Update", method: .get, parameters: nil, headers: nil, withSuccess: { (response) in
            
            do{
                let FULLResponse = try
                    JSONDecoder().decode(userAddressDC.self, from: response)
                
                if let userAddresses = FULLResponse.data?.address {
                    
                    
                    self.arrAddress = userAddresses
                    DispatchQueue.main.async {
                        
                        self.userAddressesVM.tbAdresses.reloadData()
                    }
                }
            }catch let jsonerror{
                
                print("error parsing json objects",jsonerror)
            }
        }){ (error) in
        }
    }
}
