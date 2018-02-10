//  Copyright © 2018 Muge Ersoy. All rights reserved.

import UIKit

var colour = [Transaction.Category.bankingfees : "27487c",
              Transaction.Category.cashWithDrawal : "b2ffb2",
              Transaction.Category.clothing : "80619d",
              Transaction.Category.restaurants : "ab5d33",
              Transaction.Category.payment : "fd878f",
              Transaction.Category.energy : "acf6f8",
              Transaction.Category.generalHealth : "ea2a3f",
              Transaction.Category.insurance : "43a24b",
              Transaction.Category.loanRepayment : "ff7f50",
              Transaction.Category.general : "b2dbd5"
]

class Transaction:NSObject, NSCoding {
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(category.rawValue, forKey: "category")
        aCoder.encode(transactionType?.rawValue ?? "", forKey: "transactionType")
        aCoder.encode(date, forKey: "date")
        aCoder.encode(detail, forKey: "detail")
        aCoder.encode(amount, forKey: "amount")
        aCoder.encode(location, forKey: "location")

    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeInteger(forKey: "id")
        let categoryString = aDecoder.decodeObject(forKey: "category") as? String
        let typeString = aDecoder.decodeObject(forKey: "transactionType") as? String
        let date = aDecoder.decodeObject(forKey: "date") as? Date ?? Date()
        let detail = aDecoder.decodeObject(forKey: "detail") as? String ?? ""
        let amount = aDecoder.decodeObject(forKey: "amount") as? String ?? ""
        let location = aDecoder.decodeObject(forKey: "location") as? String ?? ""
        let category = Transaction.Category(rawValue: categoryString ?? "General")
        let type = Transaction.TType(rawValue: typeString ?? "")

        self.init(id: id,
                  category: category ?? .general,
                  type: type,
                  date: date,
                  detail: detail,
                  amount: amount,
                  location: location)
    }
    
    init(id:Int, category:Transaction.Category , type: Transaction.TType? , date: Date, detail: String, amount: String, location: String){
        self.id = id
        self.category = category
        self.transactionType = type
        self.date = date
        self.detail = detail
        self.amount = amount
        self.location = location
    }
    
    enum Category: String {
        case bankingfees = "Banking Fees"
        case cashWithDrawal = "Cash Withdrawal"
        case clothing = "Clothing/Footwear"
        case restaurants = "Coffee/Restaurant/Takeaway/Pubs"
        case payment = "Credit-Card Payment"
        case energy = "Energy"
        case generalHealth = "General Health and Beauty"
        case insurance = "Insurance Expense"
        case loanRepayment = "Loan Repayment"
        case general = "General"
        
        static func all() -> [Category]{
            return [.bankingfees, .cashWithDrawal, .clothing, .restaurants, .payment, .energy,.generalHealth,.insurance,.loanRepayment,.general]
        }
    }
    
    enum TType:String {
        case debit
        case credit
    }
    
    let id: Int
    let date: Date
    let detail: String
    let amount: String
    let transactionType: TType?
    var category: Category
    let location: String
}
