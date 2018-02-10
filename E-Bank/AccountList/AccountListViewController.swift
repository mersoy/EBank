//  Copyright © 2018 Muge Ersoy. All rights reserved.

import UIKit

protocol AccountListViewControllerDelegate:class {
    func retrieveTransactions(completion: AsyncResult<[String:[Transaction]]>)
    func didSelect(transaction: Transaction)
}

class AccountListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var delegate : AccountListViewControllerDelegate
    var transaction = [String:[Transaction]]()
    var keys = [String]()
    
    init(delegate: AccountListViewControllerDelegate) {
        self.delegate = delegate
        super.init(nibName: "AccountList", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "TransactionTableCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TransactionTableCell")
        tableView.estimatedRowHeight = 52
        edgesForExtendedLayout = .bottom
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        delegate.retrieveTransactions(){ result in
            if case let .success(transactions) = result {
                var t = transactions
                self.keys = generateKeys(&t)
                self.transaction = t
                tableView.reloadData()
            }
        }
    }
}

extension AccountListViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        let value = keys[section]
        return transaction[value]?.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return keys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionTableCell") as? TransactionTableCell {
            let value = keys[indexPath.section]
            if let list = transaction[value]{
                cell.update(with:list[indexPath.row])
            }
            return cell
        }
        return TransactionTableCell(style: .default, reuseIdentifier: "TransactionTableCell")
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 52
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return keys[section]
    }
    
    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        let value = keys[indexPath.section]
        if let list = transaction[value]{
            delegate.didSelect(transaction: list[indexPath.row])
            self.tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}


