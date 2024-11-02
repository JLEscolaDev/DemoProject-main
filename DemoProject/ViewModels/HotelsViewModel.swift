//
//  HotelsViewModels.swift
//  DemoProject
//
//  Created by Jose Luis Escolá on 22/05/2021.
//

import Foundation

class HotelsViewModel : NSObject {
    
    private var apiService : APIService!
    private(set) var hotelsData : Center! {
        didSet {
            self.bindHotelsViewModelToController()
        }
    }
    
    var bindHotelsViewModelToController : (() -> ()) = {}
    
    override init() {
        super.init()
        self.apiService =  APIService()
        getHotels()
    }
    
    func getHotels() {
        self.apiService.getHotelsData {[weak self] (center) in
            self?.hotelsData = center
            self?.getHotelsRatings()
        }
    }
    
    func getHotelsRatings() {
        self.apiService.getHotelRatings {[weak self] (hotelsRatings) in
            if let hotelsRatings = hotelsRatings {
                for rating in hotelsRatings {
                    if let hotelIndex = self?.hotelsData.hotels?.firstIndex(where: {$0.code == rating.hotelCode}) {
                        self?.hotelsData.hotels?[hotelIndex].rating = rating
                    }
                }
                self?.bindHotelsViewModelToController()
            }
        }
    }
    
    func getHotelsfilterHotelsByService(hotels: [Hotel]? = HotelsViewModel().hotelsData.hotels,services: [String]) -> [Hotel]?{
        var hotelList = [Hotel]()
        
        hotels?.forEach({hotel in
            var append = true
            services.forEach({service in
                if let _ = hotel.services?.first(where: {$0.name == service}){}
                else{
                    append = false
                }
            })
            if append {
                hotelList.append(hotel)
            }
        })
        
        
        return hotelList
    }
    
    func getHotelsFilteredByDiscount(hotels: [Hotel]? = nil)->[Hotel]?{
        if let hotels = hotels ?? HotelsViewModel().hotelsData?.hotels {
            return hotels.filter({$0.tierDiscount == true })
        }
        return nil
    }
    
    func getAllServices()->[String]{
        var servicesList = [String]()
        hotelsData.hotels?.forEach({hotel in
            hotel.services?.forEach({service in
                if let _ = servicesList.first(where: {$0 == service.name}){}
                else{
                    if let serviceName = service.name {
                        servicesList.append(serviceName)
                    }
                }
            })
        })
        return servicesList
    }

}
