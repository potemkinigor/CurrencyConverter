//
//  CurrencyRatestNetworkRequest.swift
//  CurrencyExchangeApp
//
//  Created by User on 02.03.2021.
//
import Foundation
import UIKit

protocol CurrencyRatestNetworkRequestProtocol  {
    func getCurrenciesExchangeData(fromCurerency: String, completion: @escaping ([(String, Double)]?, String?) -> Void)
}

class CurrencyRatestNetworkRequest: CurrencyRatestNetworkRequestProtocol  {
    
    let requestMethod = "GET"
    
    func getCurrenciesExchangeData (fromCurerency: String, completion: @escaping ([(String, Double)]?, String?) -> Void) {
        
        var returnArray: [(String, Double)] = []
        
        
        let urlString = "https://api.exchangeratesapi.io/latest?base=\(fromCurerency)"
        
        let URL = NSURL(string: urlString)
        
        let request = NSMutableURLRequest(url: URL! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = self.requestMethod
        
        let session = URLSession.shared
        
        session.dataTask(with: request as URLRequest, completionHandler: { (data, respond, error) in
            if (error != nil) {
                completion(nil, "Ошибка при получении данных с сервера")
                return
            } else {
                if let listOfCurrenciesExchangeRates = try? JSONDecoder().decode(CurrencyRatesDataModel.self, from: data!) {
                    
                    for index in 0..<listOfCurrencies.count {
                        let exhangeRate = listOfCurrenciesExchangeRates.rates.returnRequiredValue(currencyName: listOfCurrencies[index].0).1
                        if exhangeRate != nil {
                            returnArray.append((listOfCurrencies[index].0, exhangeRate!))
                        }
                    }
                    
                    returnArray = returnArray.sorted(by: { (s1, s2) -> Bool in
                        s1.0 < s2.0
                    })
                    completion(returnArray, nil)
                }
            }
        }).resume()
    }
    
}
