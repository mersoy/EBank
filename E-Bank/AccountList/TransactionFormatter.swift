//  Copyright © 2018 Muge Ersoy. All rights reserved.

import Foundation

class TransactionFormatter {
    lazy var date: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLL"
        dateFormatter.dateFormat = "MM"
        dateFormatter.locale = Locale.current
        return dateFormatter
    }()

    func formatTransactions(_ transactions: [Transaction]) -> [String: [Transaction]] {
        var dic = [String: [Transaction]]()

        for t in transactions {
            date.dateFormat = "MM"
            let month = date.string(from: t.date)
            var list = dic[month] ?? [Transaction]()
            list.append(t)
            dic[month] = list
        }
        return dic
    }

    func generateKeys(_ transactions: inout [String: [Transaction]]) -> [String] {
        let keys = transactions.keys.sorted(by: { $0 > $1 })
        let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]

        var newkeys = [String]()
        var newDic = [String: [Transaction]]()
        for key in keys {
            let value = transactions[key] ?? [Transaction]()
            let month = months[(Int(key) ?? 1) - 1]
            let newone = month + " " + "2018"
            let sortedValue = value.sorted(by: { $0.date > $1.date })
            newDic[newone] = sortedValue
            newkeys.append(newone)
        }
        transactions = newDic
        return newkeys
    }
}
