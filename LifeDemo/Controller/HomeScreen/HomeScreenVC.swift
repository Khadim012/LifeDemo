//
//  HomeScreenVC.swift
//  LifeDemo
//
//  Created by Khadim Hussain on 03/11/2021.
//

import UIKit

class HomeScreenVC: UIViewController {

    @IBOutlet var homeScreenVM: HomeScreenViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.homeScreenVM.setupUI()
    }
    
    @IBAction func didTapAction(_ sender: UIButton) {
       
        //CREATE NEW ORDER
        if sender.tag == 0 {
            
            let vc = CreateNewOrderVC.instantiate(fromAppStoryboard: .Main)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else {
           
            //MY ADDRESSES
            let vc = UserAddressVC.instantiate(fromAppStoryboard: .Main)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
