//
//  CurrencyRatesAssembly.swift
//  CurrencyExchangeApp
//
//  Created by User on 02.03.2021.
//

import Foundation
import UIKit


class CurrencyRatesAssembly: NSObject {
    
    @IBOutlet weak var viewController: UIViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        guard let view = self.viewController as? CurrencyRatesViewController else { return }
        let networkRequest = CurrencyRatestNetworkRequest()
        
        let presenter = CurrencyRatePresenter(view: view, networkRequest: networkRequest)
        
        view.presenterProtocol = presenter
        
    }
}
