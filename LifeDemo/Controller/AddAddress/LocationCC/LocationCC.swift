//
//  LocationCC.swift
//  LifeDemo
//
//  Created by Khadim Hussain on 04/11/2021.
//

import UIKit

class LocationCC: UITableViewCell {

    @IBOutlet weak var lblLocationName: UILabel!
    @IBOutlet weak var lblLocationAddress: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupLocation(location: locationData) {
        
        self.lblLocationName.text = location.name ?? ""
        if let address = location.formatted_address {
            
            self.lblLocationAddress.isHidden = false
            self.lblLocationAddress.text = address
        }
        else {
            
            self.lblLocationAddress.isHidden = true
        }
    }
}
