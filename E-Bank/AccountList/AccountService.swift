//  Copyright © 2018 Muge Ersoy. All rights reserved.

import Foundation

protocol AccountService {
    func retrieveTransactions(completion: (([Transaction])->Void))
}

class DefaultAccountService : AccountService {
    func retrieveTransactions(completion: (([Transaction]) -> Void)) {
        let transactions = MockTransactions().generate(with: 24)
        completion(transactions)
    }
}
