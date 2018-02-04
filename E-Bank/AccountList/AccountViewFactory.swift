//  Copyright © 2018 Muge Ersoy. All rights reserved.

import UIKit

class AccountViewFactory {
    func makeAccountList() -> UIViewController {
        return UIStoryboard(name: "Main").instantiateViewController(withIdentifier: "AccountListNController")
    }
}
