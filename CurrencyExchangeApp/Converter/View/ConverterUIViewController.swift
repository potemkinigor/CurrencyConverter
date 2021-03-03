//
//  ConverterUIViewController.swift
//  CurrencyExchangeApp
//
//  Created by User on 26.02.2021.
//

import UIKit

class ConverterUIViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    @IBOutlet weak var fromCurrencyPicker: UIPickerView!
    @IBOutlet weak var toCurrencyPicker: UIPickerView!
    @IBOutlet weak var amountConvertableTextField: UITextField!
    @IBOutlet weak var amountConvertedTextField: UITextField!
    
    
    var listOfCurrencies: [(String, String)] = []
    
    var presenterProtocol: ConverterPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fromCurrencyPicker.dataSource = self
        self.fromCurrencyPicker.delegate = self
        
        self.toCurrencyPicker.dataSource = self
        self.toCurrencyPicker.delegate = self
        
        amountConvertableTextField.delegate = self
        amountConvertedTextField.delegate = self
        
        amountConvertableTextField.addTarget(self, action: #selector(updateNumbersView), for: .editingChanged)
        amountConvertedTextField.addTarget(self, action: #selector(updateNumbersView), for: .editingChanged)
        
        
        self.presenterProtocol.updatePickers()
        
        self.amountConvertableTextField.becomeFirstResponder()
    
    }
    
    //MARK: - PickerView delegates
    
    func updatePickerViews(_ currencies: [(String, String)]) {
        self.listOfCurrencies = currencies
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        self.listOfCurrencies.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.listOfCurrencies[row].0
    }
    
    //MARK: - Actions
    
    @IBAction func currencyRatesViewPresent(_ sender: Any) {
        self.presenterProtocol.currencyRatesViewControllerTransfer(viewController: self)
    }
    
    
    @IBAction func convertButtonPush(_ sender: Any) {
        
        let currencyCodeConvertFrom = listOfCurrencies[self.fromCurrencyPicker.selectedRow(inComponent: 0)].0
        let currencyCodeConvertTo = listOfCurrencies[self.toCurrencyPicker.selectedRow(inComponent: 0)].0
        
        let text = amountConvertableTextField.text?.replacingOccurrences(of: ",", with: "")
        
        guard let amountToConvert = Double(text!) else {
            let alert = UIAlertController(title: "Ошибка", message: "Введите, пожалуйста, число", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        
        self.presenterProtocol.convertAmount(inputMoney: amountToConvert, fromCurrency: currencyCodeConvertFrom, toCurrency: currencyCodeConvertTo)
    }
    
    @objc func updateNumbersView(textField: UITextField) {
        let text = textField.text?.replacingOccurrences(of: ",", with: "")
        if text?.last == "." {
            return
        }
        guard let number = Double(text!) else {
            return
        }
        let updatedText = textField.text?.convertNumberFormat(number: number, maximimFractions: 3)
        textField.text = updatedText
    }
    
    @IBAction func infoButtonPush(_ sender: Any) {
        let alert = UIAlertController(title: "Информация", message: "Данные по официальным курсам для конвертации валют берутся с https://exchangeratesapi.io. Если сервер недоступен, то для конвертации применяются последние сохраненные курсы валют", preferredStyle: .alert)
        let alertOkAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(alertOkAction)
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension ConverterUIViewController: ConverterViewProtocol {
    func showConvertedNumbers(_ amount: Double, warningText: String?) {
        
        if warningText != nil {
            let alert = UIAlertController(title: "Предупреждение", message: warningText, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
        
        let text = ""
        let updatedText = text.convertNumberFormat(number: amount, maximimFractions: 3)
        
        UIView.transition(with: self.amountConvertedTextField,
                          duration: 0.25,
                          options: .transitionFlipFromRight,
                          animations: {
                            self.amountConvertedTextField.text = updatedText
                          },
                          completion: nil)
    }
    
    func setPickers(_ listOfCurrencies: [(String, String)]) {
        self.listOfCurrencies = listOfCurrencies
    }
}
