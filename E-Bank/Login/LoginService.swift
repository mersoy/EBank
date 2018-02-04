//  Copyright © 2018 Muge Ersoy. All rights reserved.

import Foundation

protocol LoginService {
    func authenticateUser(name: String, complete: AsyncResult<User>)
}

class DefaultLoginService : LoginService {
    func authenticateUser(name: String, complete: AsyncResult<User>){
        //This should be connected to BE
        if name.caseInsensitiveCompare("End User") == .orderedSame {
            complete(.success(User.endUser))
        }else if name.caseInsensitiveCompare("Experian") == .orderedSame {
            complete(.success(User.experian))
        }else{
            complete(.success(User.bank))
        }
    }
}
