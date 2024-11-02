//
//  Hotel.swift
//  DemoProject
//
//  Created by Jose Luis Escolá on 22/05/2021.
//

import Foundation

class Hotel: Codable {
    var tierDiscount: Bool?
    var code: String?
    var description: HotelDescription?
    var theatre: String?
    var distance: HotelDistance?
    var fullAddress: AddressData?
    var hotelStatus: HotelStatus?
    var memberOnlyRate: Bool?
    var globalSeo: Bool?
    var coordinates: Coordinates?
    var name: String?
    var overviewPath: String?
    var image: HotelImage?
    var address: String?
    var services: [HotelServices]?
    var galleries: [HotelGaleries]?
    var rating: HotelRating?
    
    init (tierDiscount: Bool? = nil, code: String? = nil, description: HotelDescription? = nil, theatre: String? = nil, distance: HotelDistance? = nil, fullAddress: AddressData? = nil, hotelStatus: HotelStatus? = nil, memberOnlyRate: Bool? = nil, globalSeo: Bool? = nil, coordinates: Coordinates? = nil, name: String? = nil, overviewPath: String? = nil, image: HotelImage? = nil, address: String? = nil, services: [HotelServices]? = nil, galleries: [HotelGaleries]? = nil, rating: HotelRating? = nil){
        
        self.tierDiscount = tierDiscount
        self.code = code
        self.description = description
        self.theatre = theatre
        self.distance = distance
        self.fullAddress = fullAddress
        self.hotelStatus = hotelStatus
        self.memberOnlyRate = memberOnlyRate
        self.globalSeo = globalSeo
        self.coordinates = coordinates
        self.name = name
        self.overviewPath = overviewPath
        self.image = image
        self.address = address
        self.services = services
        self.galleries = galleries
        self.rating = rating
    }
}

class HotelDescription: Codable {
    var shortDescription: String?
    var title: String?
    
    init (shortDescription: String?,title: String?){
        self.shortDescription = shortDescription
        self.title = title
    }
}

class HotelDistance: Codable {
    var miles: Double?
    var km: Double?
    
    init (miles: Double?,km: Double?){
        self.miles = miles
        self.km = km
    }
}

class AddressData: Codable {
    var country: String?
    var street: String?
    var zip: String?
    var countryCode: String?
    var city: String?
    
    init (country: String?,street: String?,zip: String?,countryCode: String?,city: String?){
        self.country = country
        self.street = street
        self.zip = zip
        self.countryCode = countryCode
        self.city = city
    }
    
    private enum CodingKeys: String, CodingKey {
        case country = "country", street = "street", zip = "zip", countryCode = "countryCode", city = "city"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        country = try container.decode(String.self, forKey: .country)
        street = try container.decode(String.self, forKey: .street)
        do {
            zip = try String(container.decode(Int.self, forKey: .zip))
        } catch DecodingError.typeMismatch {
            zip = try container.decode(String.self, forKey: .zip)
        }
        countryCode = try container.decode(String.self, forKey: .countryCode)
        city = try container.decode(String.self, forKey: .city)
    }
}

class HotelStatus: Codable {
    var Code: String?
    var Name: String?
    
    init (code: String?,name: String?){
        self.Code = code
        self.Name = name
    }
}

enum hotelStatusCodes: String, CodingKey {
    case ACTIVE = "active"
    case INACTIVE = "inactive"
}

class HotelImage: Codable {
    var mimeType: String?
    var width: Int?
    var altText: String?
    var url: String?
    var height: Int?
    
    init (mimeType: String? = nil,width: Int? = nil,altText: String? = nil,url: String? = nil,height: Int? = nil){
        self.mimeType = mimeType
        self.width = width
        self.altText = altText
        self.url = url
        self.height = height
    }
}

class HotelServices: Codable {
    var code: String?
    var name: String?
    
    init (code: String?,name: String?){
        self.code = code
        self.name = name
    }
}

class HotelGaleries: Codable {
    var category: String?
    var gallery: [HotelImage]?
    var shortDescription: String?
    var brand: String?
    var nearby: Bool?
    
    init (category: String?,gallery: [HotelImage]?,shortDescription: String?,brand: String?,nearby: Bool?){
        self.category = category
        self.gallery = gallery
        self.shortDescription = shortDescription
        self.brand = brand
        self.nearby = nearby
    }
}

class HotelRating: Codable {
    var hotelCode: String
    var bubbleRating: Float?
    var reviewCount: Int?
    
    init(hotelCode: String, bubbleRating: Float? = nil, reviewCount: Int? = nil) {
        self.hotelCode = hotelCode
        self.bubbleRating = bubbleRating
        self.reviewCount = reviewCount
    }
}
