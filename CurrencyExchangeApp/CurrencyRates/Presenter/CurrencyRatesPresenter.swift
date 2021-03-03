//
//  CurrencyRatesPresenter.swift
//  CurrencyExchangeApp
//
//  Created by User on 27.02.2021.
//

import Foundation
import UIKit

protocol CurrencyRateViewProtocol {
    func setPicker (data: [(String, String)])
    func setListOfCurrencyExchangeRates (data: [(String, Double)]?, errorText: String?)
}

protocol CurrencyRatePresenterProtocol {
    init(view: CurrencyRateViewProtocol!, networkRequest: CurrencyRatestNetworkRequestProtocol!)
    func updatePickers()
    func updateListOfCurrenciesRates(baseCurrency: String)
    func converterViewControllerTransfer(viewController: UIViewController)
}

class CurrencyRatePresenter: CurrencyRatePresenterProtocol {
    var view: CurrencyRateViewProtocol!
    var networkRequest: CurrencyRatestNetworkRequestProtocol!
    
    required init(view: CurrencyRateViewProtocol!, networkRequest: CurrencyRatestNetworkRequestProtocol!) {
        self.view = view
        self.networkRequest = networkRequest
    }
    
    func updatePickers() {
        
        let data = listOfCurrencies.sorted { (s1, s2) -> Bool in
            s1.0 < s2.0
        }
        
        self.view.setPicker(data: data)
    }
    
    func updateListOfCurrenciesRates(baseCurrency: String) {
        
        var listOfCurrenciesExhangeRates: [(String, Double)]!
        var errorDescription: String!
        
        let queue = DispatchQueue.global(qos: .background)
        
        queue.async {
            self.networkRequest.getCurrenciesExchangeData(fromCurerency: baseCurrency) { array, errorText in
                if array != nil {
                    listOfCurrenciesExhangeRates = array
                    errorDescription = nil
                } else {
                    listOfCurrenciesExhangeRates = nil
                    errorDescription = errorText
                }
                
                DispatchQueue.main.sync {
                    self.view.setListOfCurrencyExchangeRates(data: listOfCurrenciesExhangeRates, errorText: errorDescription)
                }
            }
        }
    }
    
    func converterViewControllerTransfer(viewController: UIViewController) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "converterViewController")
        viewController.present(vc, animated: true, completion: nil)
    }
    
    
}




