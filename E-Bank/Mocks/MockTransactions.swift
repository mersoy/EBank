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
        for index in 0 ..< count {
            let transaction = Transaction(id: index + 1,
                                          category: categoryGenerator(),
                                          type: typeGenerator(), date: dateGenerator(),
                                          detail: detailGenerator(),
                                          amount: amountGenerator(),
                                          location: "London")
            transactions.append(transaction)
        }
        return transactions
    }

    private func dateGenerator() -> Date {
        let month = String(format: "%02d", arc4random_uniform(UInt32(12)) + 1)
        // For simplicity I am setting maximum number of days in month to 28
        // let day = Int(arc4random_uniform(UInt32(28)))
        let day = String(format: "%02d", arc4random_uniform(UInt32(28)) + 1)
        let date = "2018-" + month + "-" + day
        let formatter = dateFormatter.date(from: date)
        return formatter ?? Date()
    }

    private func detailGenerator() -> String {
        let letters = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
        let letter = letters[Int(arc4random_uniform(UInt32(letters.count - 1)))]
        return "Company " + letter
    }

    private func amountGenerator() -> String {
        let a = String(arc4random_uniform(UInt32(100)))
        let b = String(arc4random_uniform(UInt32(100)))
        return "£" + a + "," + b
    }

    private func typeGenerator() -> Transaction.TType {
        let types = [Transaction.TType.credit, Transaction.TType.debit]
        let index = Int(arc4random_uniform(UInt32(2)))
        return types[index]
    }

    private func categoryGenerator() -> Transaction.Category {
        let all = Transaction.Category.all()
        let category = all[Int(arc4random_uniform(UInt32(all.count - 1)))]
        return category
    }
}
