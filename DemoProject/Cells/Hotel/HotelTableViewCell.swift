//
//  HotelTableViewCell.swift
//  DemoProject
//
//  Created by Jose Luis Escolá on 22/05/2021.
//

import UIKit

class HotelTableViewCell: UITableViewCell {
    
    // MARK: vars
    public static let CELL_IDENTIFIER = "HotelTableViewCell"
    public static let CELL_NIBNAME = "HotelTableViewCell"
    var hotel: Hotel?
    
    // MARK: outlets
    @IBOutlet weak var cardBackgroundView: UIView!
    @IBOutlet weak var hotelImage: UIImageView!
    @IBOutlet weak var hotelName: UILabel!
    @IBOutlet weak var positionImage: UIImageView!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var ratingImage: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var perNightLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //----------------------------------
    // MARK: Data Loading
    //----------------------------------
    func setCellData(_ hotel: Hotel){
        self.hotel = hotel
        hotelName.text = hotel.name ?? ""
        priceLabel.text = String(Double.random(in: 0.0...1500.50).round(to:2) ) + " €"
        
        showPosition(withDistance: hotel.distance)
        
        if let urlText = hotel.image?.url, let url = URL.init(string: urlText){
            updateHotelImage(fromUrl: url)
        }
        
        if (hotel.rating?.reviewCount ?? 0) > 0 {
            ratingLabel.attributedText = NSMutableAttributedString().rating(rating: hotel.rating?.bubbleRating ?? 0, outOfTotal: 5, withFontSize: 10.0)
        }
    }
    
    /// Hides or shows the position label and image if distance parameter is not null (it will always prioritizes km over miles)
    private func showPosition(withDistance distance: HotelDistance?){
        
        if let dist = distance?.km ?? distance?.miles {
            positionImage.isHidden = false
            var distMeasure = " km"
            if distance?.km == nil{
                distMeasure = " miles"
            }
            positionLabel.text = String(dist.round(to: 2)) + distMeasure
        }else{
            positionImage.isHidden = true
        }
    }
    
    /// Gets image from cache if it exists or gets it with the url if it is not already on our cache
    private func updateHotelImage(fromUrl url: URL){
        DataLoader().loadData(url: url, completion: {data,error in
            if let image = data {
                DispatchQueue.main.sync {
                    self.hotelImage.image = UIImage(data: image)
                }
            }
        })
    }
}

