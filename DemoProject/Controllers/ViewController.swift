//
//  ViewController.swift
//  DemoProject
//
//  Created by Jose Luis Escolá on 22/05/2021.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: vars
    private var hotelsViewModel : HotelsViewModel!
    private var hotels: [Hotel]?
    private var filterByServices: [String]?
    private var dataSource : HotelTableViewDataSource<HotelTableViewCell,Hotel>!
    private let hotelDetailIdentifier = "hotelDetailStoryboardSegueIdentifier"
    private let hotelServices = "serviceSelectionListSegue"
    
    // MARK: outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var discountButton: UIButton!
    @IBOutlet weak var discountCheck: UIImageView!
    @IBOutlet weak var servicesButton: UIButton!
    @IBOutlet weak var servicesCheck: UIImageView!

    //---------------------------------
    // MARK: App lifecycle
    //---------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        tableView.delegate = self
        callToViewModelForUIUpdate()
    }
    
    //----------------------------------
    // MARK: Actions
    //----------------------------------
    @IBAction func DiscountButtonTapped(_ sender: UIButton) {
        discountCheck.isHidden = !discountCheck.isHidden
        if !discountCheck.isHidden {
            updateDataSource(hotelsViewModel.getHotelsFilteredByDiscount(hotels: hotels))
        }else if !servicesCheck.isHidden{
            if let services = self.filterByServices{
                updateDataSource(hotelsViewModel.getHotelsfilterHotelsByService(hotels: hotelsViewModel.hotelsData.hotels,services: services))
            }
        }else{
            updateDataSource()
        }
    }
    @IBAction func ServiceButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: hotelServices, sender: self)
    }
    
    //----------------------------------
    // MARK: TableView Management
    //----------------------------------
    func callToViewModelForUIUpdate(){
        self.hotelsViewModel = HotelsViewModel()
        self.hotelsViewModel.bindHotelsViewModelToController = {
            self.updateDataSource()
        }
    }
    
    private func registerCell(){
        self.tableView.register(UINib(nibName: HotelTableViewCell.CELL_NIBNAME, bundle: nil), forCellReuseIdentifier: HotelTableViewCell.CELL_IDENTIFIER)
    }
    
    func updateDataSource(_ items: [Hotel]? = nil){
        if let centerData = self.hotelsViewModel.hotelsData, let hotelsList = items ?? self.hotelsViewModel.hotelsData.hotels {
            self.titleLabel.text = (centerData.centerDetails?.name ?? "") + " - " +  (centerData.destinationLocation?.country ?? "")
            self.dataSource = HotelTableViewDataSource(cellIdentifier: HotelTableViewCell.CELL_IDENTIFIER, items: hotelsList, configureCell: { (cell, hotelsData) in
                cell.setCellData(hotelsData)
            })
            hotels = hotelsList
            DispatchQueue.main.async {
                self.tableView.dataSource = self.dataSource
                self.tableView.reloadData()
            }
        }
    }
    
    //----------------------------------
    // MARK: Segue
    //----------------------------------
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case self.hotelDetailIdentifier:
            if let hotelDetailVC = segue.destination as? HotelDetailViewController, let hotelData = sender as? Hotel{
                hotelDetailVC.hotelData = hotelData
            }
        case self.hotelServices:
            if let serviceSelectionListTBC = segue.destination as? ServiceSelectionTableViewController {
                serviceSelectionListTBC.setServiceList(list: hotelsViewModel.getAllServices(), alreadySelectedServices: self.filterByServices)
            }
        default:
            print("Pending segue implementation")
        }
    }
    
    @IBAction func unwind( _ sender: UIStoryboardSegue) {
        if let serviceSelectorListTBC = sender.source as? ServiceSelectionTableViewController{
            // Save data from the unwind segue
            self.filterByServices = serviceSelectorListTBC.getSelectedServices()
            
            // Show or hide check mark indicator based on the selected services
            if (filterByServices?.isEmpty ?? true) {
                servicesCheck.isHidden = true
            }else{
                servicesCheck.isHidden = false
            }
            
            // Update tableView data
            if !servicesCheck.isHidden {
                if let services = self.filterByServices{
                    updateDataSource(hotelsViewModel.getHotelsfilterHotelsByService(hotels: hotelsViewModel.hotelsData.hotels,services: services))
                }
            }else if !discountCheck.isHidden{
                updateDataSource(hotelsViewModel.getHotelsFilteredByDiscount())
            }else{
                updateDataSource()
            }
        }
    }
    
}//Eoc
extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let hotelData = tableView.cellForRow(at: indexPath) as! HotelTableViewCell
        performSegue(withIdentifier: self.hotelDetailIdentifier, sender: hotelData.hotel)
    }
}
