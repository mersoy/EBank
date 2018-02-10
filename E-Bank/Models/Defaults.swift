//  Copyright © 2018 Muge Ersoy. All rights reserved.

import Foundation

protocol Defaults {
    func saveName(name: String)
    func getName() -> String
    func saveTransactions(transactions: [String:[Transaction]])
    func getTransactions() ->  [String:[Transaction]]
}

class EDefaults : Defaults {
    func saveName(name: String){
        UserDefaults().set(name, forKey: "username")
    }
    
    func getName() -> String {
        if let username = UserDefaults().object(forKey: "username") as? String {
            return username
        }
        return ""
    }
    
    func saveTransactions(transactions: [String:[Transaction]]) {
        let data = NSKeyedArchiver.archivedData(withRootObject: transactions)
        //Since we dont have the BE trying to save the transactions with more specific name
        let key = getName() + "transactions"
        UserDefaults().set(data, forKey: key)
    }
    
    func getTransactions() -> [String:[Transaction]] {
        let key = getName() + "transactions"
        if let data = UserDefaults().object(forKey: key) as? Data,
        let transactions = NSKeyedUnarchiver.unarchiveObject(with: data) as? [String:[Transaction]] {
            return transactions
        }
        return [:]
    }

}
