//  Copyright © 2018 Muge Ersoy. All rights reserved.

import UIKit

class AccountCoordinator {
    
    private lazy var date: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLL"
        dateFormatter.dateFormat = "MM"
        dateFormatter.locale = Locale.current
        return dateFormatter
    }()
    
    var service: AccountService
    var analytics: AnalyticsManager
    var defaults: Defaults

    fileprivate let navigationController = NavigationController()
    
    var rootViewController: UIViewController {
        return navigationController
    }
    
    init(service : AccountService,
         analytics: AnalyticsManager,
         defaults: Defaults){
        self.service = service
        self.analytics = analytics
        self.defaults = defaults
    }
    
    func start() {
        service.retrieveTransactions(){ transactions in
            let vc = AccountListViewController(delegate: self)
            var transactions = formatTransactions(transactions)
            vc.keys = generateKeys(&transactions)
            vc.transaction = transactions
            vc.title = defaults.getName()
            navigationController.setViewControllers([vc], animated: true)
            UIApplication.shared.keyWindow?.rootViewController = navigationController
        }
    }
    
    func formatTransactions(_ transactions: [Transaction]) -> [String:[Transaction]]{
        var dic = [String:[Transaction]]()
      
        for t in transactions {
            date.dateFormat = "MM"
            let month = date.string(from: t.date)
            var list = dic[month] ?? [Transaction]()
            list.append(t)
            dic[month] = list
        }
        return dic
    }
    
    func generateKeys(_ transactions:inout [String:[Transaction]]) -> [String]{
        let keys = transactions.keys.sorted(by: { $0 > $1})
        let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
       
        var newkeys = [String]()
        var newDic = [String:[Transaction]]()
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

extension AccountCoordinator : AccountListViewControllerDelegate {
    func didSelect(transaction: Transaction){
        let vc = TransactionDetailsViewController(transaction:transaction, delegate: self)
        navigationController.pushViewController(vc, animated: true)
    }
}
extension AccountCoordinator : TransactionDetailsViewControllerDelegate {
    func editTransaction(transaction: Transaction){
        let vc = EditTransactionViewController(transaction: transaction, delegate: self)
        navigationController.pushViewController(vc, animated: true)
    }
}

extension AccountCoordinator: EditTransactionViewControllerDelegate {
    func didChangeCategory(_ vc: UIViewController, transaction: Transaction) {
        navigationController.popViewController(animated: true)
        if let vc = navigationController.topViewController as? TransactionDetailsViewController {
            vc.transaction = transaction
            vc.showToast(message: "Category has been changed!")
        }
    }
}
