//  Copyright © 2018 Muge Ersoy. All rights reserved.

import UIKit

class CategoryCell: UICollectionViewCell {
    @IBOutlet var firstLetter: UILabel!
    @IBOutlet var category: UIView!
    @IBOutlet var categoryName: UILabel!

    func update(with category: Transaction.Category) {
        self.category.layer.cornerRadius = 40
        self.category.layer.borderColor = UIColor.black.cgColor
        self.category.layer.borderWidth = 1

        categoryName.text = category.rawValue
        if let colour = colour[category] {
            self.category.backgroundColor = UIColor(hexString: colour)
        }
        if let letter = category.rawValue.first {
            firstLetter.text = String(describing: letter)
        }
    }
}
