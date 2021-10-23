//
//  RouterTest.swift
//  MVP-2NTests
//
//  Created by Denis Medvedev on 22/10/2021.
//  Copyright © 2021 Denis Medvedev. All rights reserved.
//

import XCTest
@testable import MVP_2N

class MockNavigationController: UINavigationController {
    var presentedVC: UIViewController?
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        self.presentedVC = viewController
        super.pushViewController(viewController, animated: animated)
    }
}

class RouterTest: XCTestCase {

    var router: RouterProtocol!
    var navigationController = MockNavigationController()
    let assembly = AsselderModuleBuilder()
    
    override func setUp() {
        router = Router(navigationController: navigationController, assembyBuilder: assembly)
    }

    override func tearDown() {
        router = nil
    }
    
    func testRouter() {
        router.showDetail(comment: nil)
        let detailViewController = navigationController.presentedVC
        
        XCTAssertTrue(detailViewController is DetailViewController)
    }

}
