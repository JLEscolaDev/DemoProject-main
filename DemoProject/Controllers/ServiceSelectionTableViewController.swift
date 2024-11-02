//
//  ServiceSelectionTableViewController.swift
//  DemoProject
//
//  Created by Jose Luis Escolá on 24/05/2021.
//

import UIKit

class ServiceSelectionTableViewController: UITableViewController {

    // MARK: vars
    private var serviceList: [String]?
    private var selectedServices = [String]()
    
    //---------------------------------
    // MARK: From outside
    //---------------------------------
    func getSelectedServices()->[String]{
        return selectedServices
    }
    
    func setServiceList(list: [String]?, alreadySelectedServices: [String]?){
        self.serviceList = list
        if let services = alreadySelectedServices {
            self.selectedServices = services
        }
    }
    
    //---------------------------------
    // MARK: App lifecycle
    //---------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func doneButtonTapped(_ sender: Any) {
        // Return the selectedServices to the main viewController
        performSegue(withIdentifier: "selectedServicesUnwindSegueIdentifier", sender: self)
    }
    
    //----------------------------------
    // MARK: TableView Management
    //----------------------------------
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return serviceList?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HotelServiceSelectionTableViewCell.CELLIDENTIFIER, for: indexPath) as! HotelServiceSelectionTableViewCell
        if let serviceName = serviceList?[indexPath.row] {
            cell.serviceLabel.text = serviceName
            if (selectedServices.first(where: {$0 == serviceName }) != nil) {
                cell.isServiceSelected = true
            }else{
                cell.isServiceSelected = false
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! HotelServiceSelectionTableViewCell
        // Show or hide checkMark
        cell.isServiceSelected = !cell.isServiceSelected
        
        // Append or remove service on the selectedServices array
        if let serviceName = cell.serviceLabel.text {
            var iteratorVar = 0
            var found = false
            for service in selectedServices {
                if service == serviceName{
                    selectedServices.remove(at: iteratorVar)
                    found = true
                    break
                }
                iteratorVar += 1
            }
            if !found {
                selectedServices.append(serviceName)
            }
        }
    }
    

}
