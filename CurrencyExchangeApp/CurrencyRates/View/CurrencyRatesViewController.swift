//
//  CurrencyRatesViewController.swift
//  CurrencyExchangeApp
//
//  Created by User on 27.02.2021.
//

import UIKit

class CurrencyRatesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource, CurrencyRateViewProtocol {
    
    
    @IBOutlet weak var currentCurrency: UIPickerView!
    @IBOutlet weak var currencyListTableView: UITableView!
    
    var listOfCurrencies: [(String, String)] = []
    var listOfCurrenciesRates: [(String, Double)] = []
    var errorDescriptionText = ""
    
    var presenterProtocol: CurrencyRatePresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.currencyListTableView.register(UINib(nibName: "CurrenciesTableViewCell", bundle: nil), forCellReuseIdentifier: "currencyChangeRateReuseIdentifier")
        
        currencyListTableView.dataSource = self
        currencyListTableView.delegate = self
        
        currentCurrency.delegate = self
        currentCurrency.dataSource = self
        
        self.presenterProtocol.updatePickers()
        self.presenterProtocol.updateListOfCurrenciesRates(baseCurrency: self.listOfCurrencies[currentCurrency.selectedRow(inComponent: 0)].0)
        
    }
    
    //MARK: - TableView data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var returnedValuesCount = 1
        
        if self.listOfCurrenciesRates.count != 0 {
            returnedValuesCount = self.listOfCurrenciesRates.count
        }
        
        return returnedValuesCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.currencyListTableView.dequeueReusableCell(withIdentifier: "currencyChangeRateReuseIdentifier") as! CurrenciesTableViewCell
        
        if listOfCurrenciesRates.count != 0 {
            
            cell.currencyNameLabel.font = UIFont(name: cell.currencyNameLabel.font.fontName, size: 31)
            
            cell.currencyNameLabel.text = listOfCurrenciesRates[indexPath.row].0
            
            let text = ""
            let updatedText = text.convertNumberFormat(number: listOfCurrenciesRates[indexPath.row].1, maximimFractions: 3)
            
            cell.currencyConvertRate.text = updatedText
        } else {
            cell.currencyNameLabel.font = UIFont(name: cell.currencyNameLabel.font.fontName, size: 11)
            
            cell.currencyNameLabel.text = self.errorDescriptionText
            cell.currencyConvertRate.text = ""
        }
        
        return cell
    }
    
    
    //MARK: - Picker view data source
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.listOfCurrencies.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.listOfCurrencies[row].0
    }
    
    //MARK: - Presenter protocols
    func setPicker(data: [(String, String)]) {
        listOfCurrencies = data
    }
    
    func setListOfCurrencyExchangeRates(data: [(String, Double)]?, errorText: String?) {
        
        if data != nil {
            self.listOfCurrenciesRates = data!
        }
        
        if errorText != nil {
            self.errorDescriptionText = errorText!
        }
        
        self.currencyListTableView.reloadData()
    }
    
    //MARK: - Actions
    
    @IBAction func backButtonPush(_ sender: Any) {
        presenterProtocol.converterViewControllerTransfer(viewController: self)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.listOfCurrenciesRates.removeAll()
        
        presenterProtocol.updateListOfCurrenciesRates(baseCurrency: self.listOfCurrencies[pickerView.selectedRow(inComponent: 0)].0)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.listOfCurrenciesRates.removeAll()
        
        self.currentCurrency.selectRow(indexPath.row, inComponent: 0, animated: true)
        presenterProtocol.updateListOfCurrenciesRates(baseCurrency: self.listOfCurrencies[indexPath.row].0)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

}
