//  Copyright © 2018 Muge Ersoy. All rights reserved.

import UIKit

class LoginCoordinator {
    var service: LoginService
    var analytics: AnalyticsManager
    var defaults: Defaults

    var rootViewController: UIViewController {
        return makeLoginController()
    }

    init(service: LoginService, analytics: AnalyticsManager, defaults: Defaults) {
        self.service = service
        self.analytics = analytics
        self.defaults = defaults
    }

    private func makeLoginController() -> LoginViewController {
        return LoginViewController(delegate: self)
    }
}

extension LoginCoordinator: LoginViewControllerDelegate {
    func login(_ loginViewController: LoginViewController, username: String) {
        let name = username.trimmingCharacters(in: .whitespacesAndNewlines)
        if name.count == 0 {
            loginViewController.showMessage(title: "Login", message: "Please enter any username for \"End user\" or \"Bank\" for bank analist or \"Experian\" for Experian Analyst")
        } else {
            service.authenticateUser(name: name) { result in
                if case .success = result {
                    defaults.saveName(name: name)
                    analytics.sendEvent(eventName: .loginSuccessful)
                    let coordinator = AccountCoordinator(service: DefaultAccountService(defaults: EDefaults(), formatter: TransactionFormatter()), analytics: analytics, defaults: EDefaults())
                    coordinator.start()
                } else {
                    analytics.sendEvent(eventName: .loginFailed)
                    loginViewController.showMessage(title: "Error", message: "Something went wrong")
                }
            }
        }
    }
}
