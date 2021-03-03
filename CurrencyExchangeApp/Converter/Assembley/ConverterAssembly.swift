//
//  ConverterAssembly.swift
//  CurrencyExchangeApp
//
//  Created by User on 27.02.2021.
//

import Foundation
import UIKit

class ConverterAssembly: NSObject {
    
    @IBOutlet weak var viewController: UIViewController!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        guard let view = viewController as? ConverterUIViewController else { return }
        let networkRequest = ConvertNetworkRequest()
        
        let presenter = ConverterPresenter(view: view, data: listOfCurrencies, networkRequest: networkRequest)
        
        view.presenterProtocol = presenter
        
    }
}
