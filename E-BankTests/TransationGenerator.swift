//  Copyright © 2018 Muge Ersoy. All rights reserved.

@testable import E_Bank
import XCTest

class E_BankTests: XCTestCase {
    func testMockTransactionGenerator() {
        let transtions = MockTransactions().generate(with: 10)
        XCTAssert(transtions.count == 10)
    }

    func testAccountCoordinator() {
        let coor = AccountCoordinator(service: DefaultAccountService(defaults: MockUserDefaults(), formatter: TransactionFormatter()), analytics: DefaultAnalyticsManager(), defaults: EDefaults())
        coor.start()
        let nv = coor.rootViewController as! NavigationController
        XCTAssert((nv.topViewController as? AccountListViewController) != nil)
    }

    func testTransactionsFromCoordinator() {
        let coor = AccountCoordinator(service: DefaultAccountService(defaults: MockUserDefaults(), formatter: TransactionFormatter()), analytics: DefaultAnalyticsManager(), defaults: EDefaults())
        coor.start()
        coor.retrieveTransactions { result in
            if case let .success(transactions) = result {
                XCTAssert(transactions.count == 1)
            }
        }
    }
}
