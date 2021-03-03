//
//  Extensions.swift
//  CurrencyExchangeApp
//
//  Created by User on 02.03.2021.
//

import Foundation

extension String {
    func convertNumberFormat(number: Any, maximimFractions: Int) -> String? {
        
        guard let isANumber = number as? NSNumber else { return nil}
                
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = maximimFractions
        
        return formatter.string(from: isANumber)!
        
    }
}
