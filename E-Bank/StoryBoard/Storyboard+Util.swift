//  Copyright © 2018 Muge Ersoy. All rights reserved.

import UIKit

extension UIStoryboard {
    
    convenience init(name: String, bundle: Bundle? = nil) {
        self.init(name: name, bundle: bundle)
    }
    
    func instantiateVC<T: UIViewController>(_ type: T.Type) -> T {
        guard let viewController = instantiateViewController(withIdentifier: String(describing: type)) as? T else {
            fatalError("Could not instantiate view controller for: \(type)")
        }
        return viewController
    }
}
