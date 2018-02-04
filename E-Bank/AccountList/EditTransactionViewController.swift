//  Copyright © 2018 Muge Ersoy. All rights reserved.

import UIKit

protocol EditTransactionViewControllerDelegate {
    func didChangeCategory(_ vc: UIViewController,transaction: Transaction)
}

class EditTransactionViewController: UIViewController {
   
    @IBOutlet weak var text: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var transaction: Transaction
    private var delegate: EditTransactionViewControllerDelegate
    
    init(transaction: Transaction, delegate: EditTransactionViewControllerDelegate) {
        self.transaction = transaction
        self.delegate = delegate
        super.init(nibName: "EditTransaction", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = .bottom
        text.text = "Please select the right category if you think " + transaction.category.rawValue + " is not."
       collectionView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellWithReuseIdentifier: "cell")
    }
}

extension EditTransactionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Transaction.category.all().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CategoryCell{
            let catArray = Transaction.category.all()
            cell.update(with: catArray[indexPath.row])
            return cell
        }
  
        return CategoryCell()
    }
    
    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = Transaction.category.all()[indexPath.row]
        self.transaction.category = category
        delegate.didChangeCategory(self, transaction: transaction)
    }
}
