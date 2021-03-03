//
//  ConverterDataModel.swift
//  CurrencyExchangeApp
//
//  Created by User on 27.02.2021.
//

import Foundation

class ConverterDataModel: Decodable {
    var base: String
    var date: String
    var rates: ConventerRates
}

class ConventerRates: Decodable {
    var AUD: Double?
    var BGN: Double?
    var BRL: Double?
    var CAD: Double?
    var CHF: Double?
    var CNY: Double?
    var CZK: Double?
    var DKK: Double?
    var EUR: Double?
    var GBP: Double?
    var HKD: Double?
    var HRK: Double?
    var HUF: Double?
    var IDR: Double?
    var ILS: Double?
    var INR: Double?
    var ISK: Double?
    var JPY: Double?
    var KRW: Double?
    var MXN: Double?
    var MYR: Double?
    var NOK: Double?
    var NZD: Double?
    var PHP: Double?
    var PLN: Double?
    var RON: Double?
    var RUB: Double?
    var SEK: Double?
    var SGD: Double?
    var THB: Double?
    var TRY: Double?
    var USD: Double?
    var ZAR: Double?
    
    func returnRequiredValue (currencyName: String) -> Double? {
        switch currencyName {
        case "AUD": return self.AUD
        case "BGN": return self.BGN
        case "BRL": return self.BRL
        case "CAD": return self.CAD
        case "CHF": return self.CHF
        case "CNY": return self.CNY
        case "CZK": return self.CZK
        case "DKK": return self.DKK
        case "EUR": return self.EUR
        case "GBP": return self.GBP
        case "HKD": return self.HKD
        case "HRK": return self.HRK
        case "HUF": return self.HUF
        case "IDR": return self.IDR
        case "ILS": return self.ILS
        case "JPY": return self.JPY
        case "KRW": return self.KRW
        case "MXN": return self.MXN
        case "MYR": return self.MYR
        case "NOK": return self.NOK
        case "NZD": return self.NZD
        case "PHP": return self.PHP
        case "PLN": return self.PLN
        case "RON": return self.RON
        case "RUB": return self.RUB
        case "SEK": return self.SEK
        case "SGD": return self.SGD
        case "THB": return self.THB
        case "TRY": return self.TRY
        case "USD": return self.USD
        case "ZAR": return self.ZAR
        default: return nil
        }
    }
    
}
