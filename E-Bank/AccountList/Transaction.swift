//  Copyright © 2018 Muge Ersoy. All rights reserved.

import UIKit

var colour = [Transaction.category.cash : "27487c",
              Transaction.category.eatOut : "b2ffb2",
              Transaction.category.general : "80619d",
              Transaction.category.holidays : "ffde00",
              Transaction.category.entertainment : "ab5d33",
              Transaction.category.groceries : "fd878f",
              Transaction.category.transport : "acf6f8",
              Transaction.category.bill : "ea2a3f",
              Transaction.category.shopping : "43a24b",
              Transaction.category.expenses : "ff7f50",
              Transaction.category.rent : "b2dbd5"
]

struct Transaction {
    
    enum category: String {
        case cash = "Cash"
        case eatOut = "Eat Out"
        case general = "General"
        case holidays = "Holidays"
        case entertainment = "Entertainment"
        case groceries = "Grocerious"
        case transport = "Transport"
        case bill = "Bill"
        case shopping = "Shopping"
        case expenses = "Expenses"
        case rent = "Rent"
        
        static func all() -> [category]{
            return [.bill,.cash,.eatOut,.entertainment,.expenses,.general,.groceries,.holidays,.rent,.shopping,.transport]
        }
    }
    
    enum type {
        case debit
        case credit
    }
    let date : Date
    let description: String
    let amount: String
    let type : type
    var category : category
    let location : String

}
