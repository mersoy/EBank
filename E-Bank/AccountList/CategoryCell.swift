//  Copyright © 2018 Muge Ersoy. All rights reserved.

import UIKit

class CategoryCell: UICollectionViewCell {
    
    @IBOutlet weak var firstLetter: UILabel!
    @IBOutlet weak var category: UIView!
    @IBOutlet weak var categoryName: UILabel!
    

    func update(with category:Transaction.category){
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
