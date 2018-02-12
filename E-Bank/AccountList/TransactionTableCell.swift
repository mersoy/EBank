//  Copyright © 2018 Muge Ersoy. All rights reserved.

import UIKit

class TransactionTableCell: UITableViewCell {
    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()

    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet var category: UIView!
    @IBOutlet var company: UILabel!
    @IBOutlet var amount: UILabel!
    @IBOutlet var date: UILabel!

    func update(with transaction: Transaction) {
        if let code = colour[transaction.category] {
            category.backgroundColor = UIColor(hexString: code)
        }
        if let letter = transaction.category.rawValue.first {
            categoryLabel.text = String(describing: letter)
        }
        company.text = transaction.detail
        let total = transaction.transactionType == .credit ? "+" : "-"
        amount.text = total + transaction.amount
        date.text = dateFormatter.string(from: transaction.date)
    }
}
