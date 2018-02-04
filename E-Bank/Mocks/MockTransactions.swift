//  Copyright © 2018 Muge Ersoy. All rights reserved.

import Foundation

class MockTransactions {
    
    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()

    
    func generate(with count: Int) -> [Transaction] {
        var transactions = [Transaction]()
        for _ in 0..<count {
            let transaction = Transaction(date:dateGenerator() , description: descriptionGenerator(), amount: amountGenerator(),type: typeGenerator(), category: categoryGenerator(), location: "London")
            transactions.append(transaction)
        }
        return transactions
    }
    
    private func dateGenerator() -> Date {
        let month = String(format: "%02d", arc4random_uniform(UInt32(12)) + 1)
        //For simplicity I am setting maximum number of days in month to 28
       // let day = Int(arc4random_uniform(UInt32(28)))
        let day = String(format: "%02d", arc4random_uniform(UInt32(28)) + 1)
        let date =  "2018-" + month + "-" + day
        let formatter = dateFormatter.date(from: date)
        return formatter ?? Date()
    }
    
    private func descriptionGenerator() -> String {
        let letters = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
        let letter = letters[Int(arc4random_uniform(UInt32(letters.count - 1)))]
        return "Company " + letter
    }
    
    private func amountGenerator() -> String {
        let a = String(arc4random_uniform(UInt32(100)))
        let b = String(arc4random_uniform(UInt32(100)))
        return "£"+a + "," + b
    }
    
    private func typeGenerator() -> Transaction.type {
        let types = [Transaction.type.credit,
                     Transaction.type.debit]
        let index = Int(arc4random_uniform(UInt32(2)))
        return types[index]
    }
    
    private func categoryGenerator() -> Transaction.category {
        let all = Transaction.category.all()
        let category = all[Int(arc4random_uniform(UInt32(all.count - 1)))]
        return category
    }
}
