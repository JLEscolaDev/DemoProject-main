//
//  ApiServices.swift
//  DemoProject
//
//  Created by Jose Luis Escolá on 22/05/2021.
//

import Foundation
import CryptoKit

class APIService: NSObject {
    
    func getHotelsData(completion: @escaping (Center) -> ()) {
        guard let url = URL(string: EndpointDefinition.CENTER_DATA) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    return
                }
                
                guard let data = data else {
                    print("No data received")
                    return
                }
                
                // Decodifica el JSON en el modelo Center
                do {
                    let jsonDecoder = JSONDecoder()
                    let decodedData = try jsonDecoder.decode(Center.self, from: data)
                    completion(decodedData)
                } catch {
                    print("Decoding error: \(error)")
                }
            }
        }.resume()
    }

    func getHotelRatings(completion: @escaping ([HotelRating]?) -> ()) {
        guard let url = URL(string: EndpointDefinition.HOTEL_RATINGS) else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    return
                }
                
                guard let data = data else {
                    print("No data received")
                    return
                }
                
                // Decodifica el JSON en el modelo Center
                do {
                    let jsonDecoder = JSONDecoder()
                    let decodedData = try jsonDecoder.decode([HotelRating]?.self, from: data)
                    completion(decodedData)
                } catch {
                    print("Decoding error: \(error)")
                }
            }
        }.resume()
    }

}
