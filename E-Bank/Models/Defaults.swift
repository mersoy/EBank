//  Copyright © 2018 Muge Ersoy. All rights reserved.

import Foundation

protocol Defaults {
    func saveName(name: String)
    func getName() -> String
}

class EDefaults : Defaults {
    func saveName(name: String){
        UserDefaults().set(name, forKey: "username")
    }
    
    func getName() -> String {
        if let username = UserDefaults().object(forKey: "username") as? String {
            return username
        }
        return ""
    }
}
