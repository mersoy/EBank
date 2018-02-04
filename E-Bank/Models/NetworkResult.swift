//  Copyright © 2018 Muge Ersoy. All rights reserved.

import Foundation

typealias AsyncResult<T> = (NetworkResult<T>) -> Void

enum NetworkResult<T> {
    case success(T)
    case failure(Error)
}
