//
//  HotelDetailViewController.swift
//  DemoProject
//
//  Created by Jose Luis Escolá on 23/05/2021.
//

import UIKit

class HotelDetailViewController: UIViewController {

    // MARK: vars
    var hotelData: Hotel?
    private var dataSource : HotelTableViewDataSource<HotelServicesTableViewCell,HotelServices>!
    
    // MARK: outlets
    @IBOutlet weak var hotelImage: UIImageView!
    @IBOutlet weak var HotelName: UILabel!
    @IBOutlet weak var hotelDescription: UILabel!
    @IBOutlet weak var hotelAddress: UILabel!
    @IBOutlet weak var servicesTableView: UITableView!
    
    //---------------------------------
    // MARK: App lifecycle
    //---------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        if let data = hotelData{
            refreshView(data)
        }
    }
    
    //----------------------------------
    // MARK: View Management
    //----------------------------------
    private func refreshView(_ data: Hotel) {
        getImageFromUrl(data)
        HotelName.text = data.name ?? ""
        hotelDescription.text = (data.description?.title ?? "") + "\n" +  (data.description?.shortDescription ?? "")
        hotelAddress.text = data.address
        if let serviceList = data.services {
            self.dataSource = HotelTableViewDataSource(cellIdentifier: HotelServicesTableViewCell.CELL_IDENTIFIER, items: serviceList, configureCell: { (cell, service) in
                cell.serviceLabel.text = service.name
            })
            DispatchQueue.main.async {
                self.servicesTableView.dataSource = self.dataSource
                self.servicesTableView.reloadData()
            }
        }
    }
    
    //----------------------------------
    // MARK: Data load / treatment
    //----------------------------------
    private func getImageFromUrl(_ data: Hotel){
        if let urlText = data.image?.url, let url = URL(string: urlText) {
            DataLoader().loadData(url: url, completion: {data,error in
                if let image = data {
                    DispatchQueue.main.sync {
                        self.hotelImage.image = UIImage(data: image)
                    }
                }
            })
        }
    }

}
