//
//  UserAddressCell.swift
//  LifeDemo
//
//  Created by Khadim Hussain on 03/11/2021.
//

import UIKit

class UserAddressCell: UITableViewCell {

    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var viewAddressesContainer: UIView!
    
    @IBOutlet weak var imgCheck: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
   
        viewAddressesContainer.layer.borderWidth = 1.5
        viewAddressesContainer.layer.borderColor = Constants.appColor.customButtonBorder.cgColor
    }
}
