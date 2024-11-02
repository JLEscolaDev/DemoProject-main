//
//  Double.swift
//  DemoProject
//
//  Created by Jose Luis Escolá on 23/05/2021.
//

import Foundation

extension Double {
    func round(to places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
