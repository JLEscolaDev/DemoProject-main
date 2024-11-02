//
//  ArrtibutedString+ReadOnlyRating.swift
//  DemoProject
//
//  Created by Jose Luis Escolá on 22/05/2021.
//

import UIKit

extension NSMutableAttributedString{

    func rating(rating:Float, outOfTotal totalNumberOfStars:NSInteger, withFontSize size:CGFloat, color: UIColor = .init(red: 66, green: 131, blue: 0, alpha: 1)) ->NSAttributedString{
        let currentFont = UIFont(name: "SSpika" , size: size)!

        let activeStarFormat = [ NSAttributedString.Key.font: currentFont, NSAttributedString.Key.foregroundColor: color]

        let inactiveStarFormat = [ NSAttributedString.Key.font:currentFont, NSAttributedString.Key.foregroundColor: UIColor.lightGray]

        let starString = NSMutableAttributedString()

        var iterator = 0
        
        repeat {
            if(rating >= Float(iterator+1)){
                // This is for selected star. Change the unicode value according to the font that you use
                starString.append(NSAttributedString(string: "\u{22C6} ", attributes: activeStarFormat))
            }
            else if (rating > Float(iterator)){
                // This is for selected star. Change the unicode value according to the font that you use
                starString.append(NSAttributedString(string: "\u{E1A1} ", attributes: activeStarFormat))
            }
            else{
                // This is for de-selected star. Change the unicode value according to the font that you use
                starString.append(NSAttributedString(string: "\u{22C6} ", attributes: inactiveStarFormat))
            }
            iterator += 1
        }while iterator < totalNumberOfStars

        return starString
    }
}
