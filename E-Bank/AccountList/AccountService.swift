//  Copyright © 2018 Muge Ersoy. All rights reserved.

import Foundation

protocol AccountService {
    func retrieveTransactions(completion: AsyncResult<[String:[Transaction]]>)
    func updateTransactions(transaction: Transaction, completion: AsyncResult<[String:[Transaction]]>)
}

class DefaultAccountService : AccountService {
    
    var defaults: Defaults
    
    init(defaults: Defaults){
        self.defaults = defaults
    }
    
    func retrieveTransactions(completion: AsyncResult<[String:[Transaction]]>) {
      
        if defaults.getTransactions().keys.count == 0 {
            let all = MockTransactions().generate(with: 24)
            let transactions = formatTransactions(all)
            self.defaults.saveTransactions(transactions: transactions)
            completion(.success(transactions))
        } else {
            completion(.success(defaults.getTransactions()))
        }

    }
    
    func updateTransactions(transaction: Transaction, completion: ((NetworkResult<[String:[Transaction]]>) -> Void)) {
        var transactionsDic = defaults.getTransactions()
        guard transactionsDic.values.count != 0 else {
            completion(.success(transactionsDic))
            return
        }
        
        for transactions in transactionsDic.values {
            if let index = transactions.index(where: {$0.id == transaction.id}) {
                transactions[index].category = transaction.category
                defaults.saveTransactions(transactions: transactionsDic)
                completion(.success(transactionsDic))
                return
            }
        }
        completion(.failure(nil))
    }
}
