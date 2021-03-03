//
//  ConverterPresenter.swift
//  CurrencyExchangeApp
//
//  Created by User on 26.02.2021.
//

import Foundation
import UIKit


protocol ConverterViewProtocol {
    func setPickers(_ listOfCurrencies: [(String, String)])
    func showConvertedNumbers(_ amount: Double, warningText: String?)
}


protocol ConverterViewPresenterProtocol {
    init (view: ConverterViewProtocol, data: [(String, String)], networkRequest: CurrencyNetworkRequestProtocol)
    func updatePickers()
    func convertAmount(inputMoney: Double, fromCurrency: String, toCurrency: String)
    func currencyRatesViewControllerTransfer(viewController: UIViewController)
}

class ConverterPresenter: ConverterViewPresenterProtocol  {
    var view: ConverterViewProtocol!
    var data: [(String, String)]!
    var networkRequest: CurrencyNetworkRequestProtocol!
    
    required init(view: ConverterViewProtocol, data: [(String, String)], networkRequest: CurrencyNetworkRequestProtocol) {
        self.view = view
        self.data = data
        self.networkRequest = networkRequest
    }
    
    func updatePickers() {
        
        let sortedArrays = self.data.sorted { (element1, element2) -> Bool in
            element1.0 < element2.0
        }
        
        self.view.setPickers(sortedArrays)
    }
    
    func convertAmount(inputMoney: Double, fromCurrency: String, toCurrency: String) {

        var currencyEchangeRate: Double!
        var warningText: String?
        
        let queue = DispatchQueue.global(qos: .background)
        
        queue.async {
            self.networkRequest.getTwoCurrencyExchangeData(fromCurerency: fromCurrency, toCurrency: toCurrency) {currencyRate, inputWarningText in
                if currencyRate == nil {
                    currencyEchangeRate = 0
                } else {
                    currencyEchangeRate = currencyRate
                }
                warningText = inputWarningText
                DispatchQueue.main.sync {
                    self.view.showConvertedNumbers(inputMoney * currencyEchangeRate, warningText: warningText)
                }
            }
        }
    }
    
    
    func currencyRatesViewControllerTransfer(viewController: UIViewController) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(identifier: "currencyEchangeRatesViewController")
        
        viewController.present(vc, animated: true, completion: nil)
        
    }
    
}
