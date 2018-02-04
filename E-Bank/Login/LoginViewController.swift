//  Copyright © 2018 Muge Ersoy. All rights reserved.

import UIKit

protocol LoginViewControllerDelegate: class {
    func login(_ loginViewController:LoginViewController, username: String)
}

class LoginViewController: UIViewController {
    
    @IBOutlet private weak var username: UITextField!
    var delegate: LoginViewControllerDelegate
    
    init(delegate:LoginViewControllerDelegate ) {
        self.delegate = delegate
        super.init(nibName: "LoginView", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func loginButtonTabbed(_ sender: Any) {
        delegate.login(self,username: username.text ?? "")
    }
}
