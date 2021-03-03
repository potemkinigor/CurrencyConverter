//
//  ConverterCoreDataManager.swift
//  CurrencyExchangeApp
//
//  Created by User on 02.03.2021.
//

import Foundation
import CoreData

struct PersistanceContainer {
    
    static var shared = PersistanceContainer()
    
    let container: NSPersistentContainer
    
    init() {
        self.container = NSPersistentContainer(name: "CurrencyExchange")
        container.loadPersistentStores { (persistentStoreDescription, error) in
            if error != nil {
                print("Ошибка \(String(describing: error?.localizedDescription))")
            }
        }
        
    }
    
    func saveContext () {
        let context = self.container.viewContext
        
        do {
            try context.save()
        } catch {
            let error = error as NSError
            fatalError("Fatal error: \(error)")
        }
    }
}
