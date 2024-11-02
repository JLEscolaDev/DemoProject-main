//
//  HotelServicesTableViewCell.swift
//  DemoProject
//
//  Created by Jose Luis Escolá on 23/05/2021.
//

import UIKit

class HotelServicesTableViewCell: UITableViewCell {
    
    public static let CELL_IDENTIFIER = "HotelServicesTableViewCell"
    public static let CELL_NIBNAME = "HotelServicesTableViewCell"
    
    @IBOutlet weak var serviceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
