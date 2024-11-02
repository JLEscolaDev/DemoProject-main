//
//  HotelServiceSelectionTableViewCell.swift
//  DemoProject
//
//  Created by Jose Luis Escolá on 24/05/2021.
//

import UIKit

class HotelServiceSelectionTableViewCell: UITableViewCell {

    // MARK: vars
    public static let CELLIDENTIFIER = "serviceSelectionStoryboardTableViewCell"
    var isServiceSelected = false{
        didSet{
            if isServiceSelected {
                self.accessoryType = .checkmark
            }else{
                self.accessoryType = .none
            }
        }
    }
    
    // MARK: outlets
    @IBOutlet weak var serviceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
