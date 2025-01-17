//
//  Country.swift
//  CountryCodeInSwift3
//
//  Created by Cl-macmini-100 on 12/19/16.
//  Copyright © 2016 Suryakant. All rights reserved.
//

import Foundation
import UIKit

open class Country: NSObject {

    // MARK:- Variable
    @objc open var countryCode: String

    /// Name of the country
    @objc open var countryName: String
    
    /// - Returns: Dialing code for country instance with a `+` sign
    @objc open var dialingCode: String? {
        guard let digitCountrycode = digitCountrycode else {
            return nil
        }
        
        return "+" + digitCountrycode
    }
    
    /// - Returns: Digit country code without a `+` sign
    @objc open var digitCountrycode: String? {
        return isoToDigitCountryCodeDictionary[countryCode]
    }
    
    /// Image (Flag) of country
    @objc open var flag: UIImage? {
        if image != nil {
            return image
        }
        let bundle = Bundle(for: Country.self)
        let flagImg = UIImage(named: imagePath, in: bundle, compatibleWith: nil)
        image = flagImg
        return image
    }

    var imagePath: String
    private var image: UIImage?

    // MARK: - Functions
    @objc public init(countryCode code: String) {
        self.countryCode = code
        countryName = mapCountryName(self.countryCode)
        imagePath = "CountryPickerController.bundle/\(self.countryCode)"
    }

    @objc func countryName(with locale: Locale) -> String {
        guard let localisedCountryName = locale.localizedString(forRegionCode: self.countryCode) else {
            let message = "Failed to localised country name for Country Code:- \(self.countryCode)"
            fatalError(message)
        }
        return localisedCountryName
    }

    @objc func countryName(withLocaleIdentifier localeIdentifier: String) -> String {
        let locale = Locale(identifier: localeIdentifier)
        return self.countryName(with: locale)
    }
}

func mapCountryName(_ countryCode: String) -> String {
    let locale = Locale(identifier: Locale.preferredLanguages.first!)
    guard let localisedCountryName = locale.localizedString(forRegionCode: countryCode) else {
        let message = "Failed to localised country name for Country Code:- \(countryCode)"
        fatalError(message)
    }
    return localisedCountryName
}

//extension Country: Equatable {
//    public static func == (lhs: Country, rhs: Country) -> Bool {
//        return (lhs.countryCode == rhs.countryCode && lhs.dialingCode == rhs.dialingCode)
//    }
//}
