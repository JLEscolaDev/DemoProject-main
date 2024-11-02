//
//  Center.swift
//  DemoProject
//
//  Created by Jose Luis Escolá on 22/05/2021.
//

import Foundation

class Center: Codable {
    var centerDetails: CenterDetails?
    var matchesSearch: Bool?
    var centerCoordinates: Coordinates?
    var destinationLocation: DestinationLocation?
    var hotels: [Hotel]?
}

class CenterDetails: Codable {
    var name: String?
    
    init (name: String?){
        self.name = name
    }
}

class Coordinates: Codable {
    var latitude: Double?
    var longitude: Double?
    
    init (latitude: Double?,longitude: Double?){
        self.latitude = latitude
    }
}

class DestinationLocation: Codable {
    var country: String?
    var cityCode: String?
    var countryCode: String?
    var city: String?
    
    
    init (country: String?,cityCode: String?,countryCode: String?,city: String?){
        self.country = country
        self.cityCode = cityCode
        self.countryCode = countryCode
        self.city = city
    }
}
