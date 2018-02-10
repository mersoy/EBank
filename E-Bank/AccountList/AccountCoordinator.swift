//  Copyright © 2018 Muge Ersoy. All rights reserved.

import UIKit

class AccountCoordinator {

    
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
        let vc = AccountListViewController(delegate: self)
        vc.title = defaults.getName()
        navigationController.setViewControllers([vc], animated: true)
        UIApplication.shared.keyWindow?.rootViewController = navigationController
    }
}

extension AccountCoordinator : AccountListViewControllerDelegate {
    
    func retrieveTransactions(completion: AsyncResult<[String:[Transaction]]>) {
        service.retrieveTransactions(){ result in
            completion(result)
        }
    }
    
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
            service.updateTransactions(transaction: transaction) { result in
                if case .success(_) = result {
                    vc.showToast(message: "Category has been changed!")
                } else {
                    vc.showToast(message: "Ooops something went wrong.")
                }
            }
        }
    }
}
