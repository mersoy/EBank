//  Copyright © 2018 Muge Ersoy. All rights reserved.

import XCTest
@testable import E_Bank

class E_BankTests: XCTestCase {
    
    func testMockTransactionGenerator() {
        let transtions =  MockTransactions().generate(with: 10)
        XCTAssert(transtions.count == 10 )
    }
    
    func testAccountCoordinator(){
        let coor = AccountCoordinator(service: DefaultAccountService(), analytics: DefaultAnalyticsManager(), defaults: EDefaults())
        coor.start()
        let nv = coor.rootViewController as! NavigationController
        XCTAssert((nv.topViewController as? AccountListViewController) != nil)
    }
}
