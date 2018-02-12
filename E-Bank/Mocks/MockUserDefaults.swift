//  Copyright © 2018 Muge Ersoy. All rights reserved.

import Foundation

class MockUserDefaults: Defaults {
    var nameSaved = false
    var transactionsSaved = false

    func saveName(name _: String) {
        nameSaved = true
    }

    func getName() -> String {
        return "muge"
    }

    func saveTransactions(transactions _: [String: [Transaction]]) {
        transactionsSaved = true
    }

    func getTransactions() -> [String: [Transaction]] {
        let date = NSDate()
        let timestamp = Int64(date.timeIntervalSince1970 * 1000.0)
        let t = Transaction(id: 1, category: .bankingfees, type: .credit, date: Date(timeIntervalSince1970: TimeInterval(timestamp)), detail: "Company A", amount: "12,29", location: "London")
        return ["Nowember 2018": [t]]
    }
}
