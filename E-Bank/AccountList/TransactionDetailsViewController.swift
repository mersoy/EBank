//  Copyright © 2018 Muge Ersoy. All rights reserved.

import MapKit
import UIKit

protocol TransactionDetailsViewControllerDelegate {
    func editTransaction(transaction: Transaction)
}

class TransactionDetailsViewController: UIViewController {
    @IBOutlet var categoryName: UILabel!
    @IBOutlet var categoryFirstLetter: UILabel!
    @IBOutlet var amount: UILabel!
    @IBOutlet var category: UIView!
    @IBOutlet var companyName: UILabel!
    @IBOutlet var map: MKMapView!
    @IBOutlet var location: UILabel!

    var transaction: Transaction {
        didSet {
            setViewData()
        }
    }

    var delegate: TransactionDetailsViewControllerDelegate
    @IBOutlet var gesture: UIView!

    init(transaction: Transaction, delegate: TransactionDetailsViewControllerDelegate) {
        self.transaction = transaction
        self.delegate = delegate
        super.init(nibName: "TransactionDetails", bundle: nil)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = .bottom
        setViewData()
        title = "Transaction Details"
        let tap = UITapGestureRecognizer(target: self, action: #selector(editTransaction))
        tap.cancelsTouchesInView = false
        gesture.addGestureRecognizer(tap)
    }

    private func setViewData() {
        amount.text = transaction.transactionType == .credit ? "+" : "-"
        amount.text = (amount.text ?? "") + transaction.amount
        categoryName.text = transaction.category.rawValue
        if let colour = colour[transaction.category] {
            category.backgroundColor = UIColor(hexString: colour)
        }

        if let letter = transaction.category.rawValue.first {
            categoryFirstLetter.text = String(describing: letter)
        }
        self.location.text = "Location: " + transaction.location
        companyName.text = transaction.detail
        let location = CLLocation(latitude: 51.5333, longitude: 0.1322)
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, 5000, 5000)
        map.setRegion(coordinateRegion, animated: true)
    }

    @objc func editTransaction() {
        delegate.editTransaction(transaction: transaction)
    }
}
