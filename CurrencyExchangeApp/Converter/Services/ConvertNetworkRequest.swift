//
//  ConvertNetworkRequest.swift
//  CurrencyExchangeApp
//
//  Created by User on 27.02.2021.
//
//  Data is taken from https://exchangeratesapi.io
//

import Foundation
import CoreData
import UIKit

enum CoreDataState {
    case updated
    case notFound
}

protocol CurrencyNetworkRequestProtocol  {
    func getTwoCurrencyExchangeData(fromCurerency: String, toCurrency: String, completion: @escaping (Double?, String?) -> Void)
}

class ConvertNetworkRequest: CurrencyNetworkRequestProtocol  {
    
    let requestMethod = "GET"
    
    func getTwoCurrencyExchangeData (fromCurerency: String, toCurrency: String, completion: @escaping (Double?, String?) -> Void) {
        
        var currencyExchangeRate = 0.0
            
        let urlString = "https://api.exchangeratesapi.io/latest?base=\(fromCurerency)&symbols=\(toCurrency)"
        
        let URL = NSURL(string: urlString)
        
        let request = NSMutableURLRequest(url: URL! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = self.requestMethod
        
        let session = URLSession.shared
        
        session.dataTask(with: request as URLRequest, completionHandler: { (data, respond, error) in
            
            if (error != nil) {
                print(error?.localizedDescription ?? "Error")
                
                let exchangeRate = self.checkCoreDataInCaseOfNetworkError(fromCurrency: fromCurerency, toCurrency: toCurrency).0
                let date = self.checkCoreDataInCaseOfNetworkError(fromCurrency: fromCurerency, toCurrency: toCurrency).1
                
                if exchangeRate == nil && date == nil {
                    completion(nil, "Сеть недоступна, локальные данные не обнаружены")
                    return
                }
                
                completion(self.checkCoreDataInCaseOfNetworkError(fromCurrency: fromCurerency, toCurrency: toCurrency).0, "Сеть надоступна, обнаружены локальные данные от \(self.checkCoreDataInCaseOfNetworkError(fromCurrency: fromCurerency, toCurrency: toCurrency).1 ?? "")")
                
                return
            } else {
                if let listOfCurrencies = try? JSONDecoder().decode(ConverterDataModel.self, from: data!) {
                    currencyExchangeRate = listOfCurrencies.rates.returnRequiredValue(currencyName: toCurrency) ?? 0
                    
                    if self.checkAndUpdateOldExchangeRate(fromCurrency: fromCurerency, toCurrency: toCurrency, exchangeRate: currencyExchangeRate, date: listOfCurrencies.date) == .notFound {
                        let context = PersistanceContainer.shared.container.viewContext
                        let newItem = TwoCurrencysExchangeRate(context: context)
                        newItem.exchangeRate = currencyExchangeRate
                        newItem.date = listOfCurrencies.date
                        newItem.fromCurrency = fromCurerency
                        newItem.toCurrency = toCurrency
                        
                        PersistanceContainer.shared.saveContext()
                    }
                    
                    completion(currencyExchangeRate, nil)
                }
            } 
            
        }).resume()
    }
    
    func checkAndUpdateOldExchangeRate (fromCurrency: String, toCurrency: String, exchangeRate: Double, date: String) -> CoreDataState {
        let context = PersistanceContainer.shared.container.viewContext
        let fetchRequest = TwoCurrencysExchangeRate.fetchRequest() as NSFetchRequest<TwoCurrencysExchangeRate>
        fetchRequest.predicate = NSCompoundPredicate(type: .and, subpredicates: [NSPredicate(format: "fromCurrency == %@", fromCurrency), NSPredicate(format: "toCurrency == %@", toCurrency)])
        
        let listOfCurrenceEchangeRatesList = try? context.fetch(fetchRequest)
        
        if listOfCurrenceEchangeRatesList!.count == 0 {
            return .notFound
        }
        
        listOfCurrenceEchangeRatesList![0].date = date
        listOfCurrenceEchangeRatesList![0].exchangeRate = exchangeRate
        
        PersistanceContainer.shared.saveContext()
        
        return .updated
    }
    
    
    func checkCoreDataInCaseOfNetworkError (fromCurrency: String, toCurrency: String) -> (Double?, String?) {
        let context = PersistanceContainer.shared.container.viewContext
        let fetchRequest = TwoCurrencysExchangeRate.fetchRequest() as NSFetchRequest<TwoCurrencysExchangeRate>
        fetchRequest.predicate = NSCompoundPredicate(type: .and, subpredicates: [NSPredicate(format: "fromCurrency == %@", fromCurrency), NSPredicate(format: "toCurrency == %@", toCurrency)])
        
        let listOfCurrenceEchangeRatesList = try! context.fetch(fetchRequest)
        
        if listOfCurrenceEchangeRatesList.count == 0 {
            return (nil, nil)
        } else {
            return (listOfCurrenceEchangeRatesList[0].exchangeRate, listOfCurrenceEchangeRatesList[0].date)
        }
    }
    
}
