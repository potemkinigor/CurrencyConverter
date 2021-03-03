//
//  CurrencyRatesDataModel.swift
//  CurrencyExchangeApp
//
//  Created by User on 02.03.2021.
//

import Foundation


class CurrencyRatesDataModel: Decodable {
    var base: String
    var date: String
    var rates: CurrencyRates
}

class CurrencyRates: Decodable {
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
    
    func returnRequiredValue (currencyName: String) -> (String?, Double?) {
        switch currencyName {
        case "AUD": return ("AUD", self.AUD)
        case "BGN": return ("BGN", self.BGN)
        case "BRL": return ("BRL", self.BRL)
        case "CAD": return ("CAD", self.CAD)
        case "CHF": return ("CHF", self.CHF)
        case "CNY": return ("CNY", self.CNY)
        case "CZK": return ("CZK", self.CZK)
        case "DKK": return ("DKK", self.DKK)
        case "EUR": return ("EUR", self.EUR)
        case "GBP": return ("GBP", self.GBP)
        case "HKD": return ("HKD", self.HKD)
        case "HRK": return ("HRK", self.HRK)
        case "HUF": return ("HUF", self.HUF)
        case "IDR": return ("IDR", self.IDR)
        case "ILS": return ("ILS", self.ILS)
        case "INR": return ("INR", self.INR)
        case "ISK": return ("ISK", self.ISK)
        case "JPY": return ("JPY", self.JPY)
        case "KRW": return ("KRW", self.KRW)
        case "MXN": return ("MXM", self.MXN)
        case "MYR": return ("MYR", self.MYR)
        case "NOK": return ("NOK", self.NOK)
        case "NZD": return ("NZD", self.NZD)
        case "PHP": return ("PHP", self.PHP)
        case "PLN": return ("PLN", self.PLN)
        case "RON": return ("RON", self.RON)
        case "RUB": return ("RUB", self.RUB)
        case "SEK": return ("SEK", self.SEK)
        case "SGD": return ("SGD", self.SGD)
        case "THB": return ("THB", self.THB)
        case "TRY": return ("TRY", self.TRY)
        case "USD": return ("USD", self.USD)
        case "ZAR": return ("ZAR", self.ZAR)
        default: return ("", nil)
        }
    }
    
    
}
