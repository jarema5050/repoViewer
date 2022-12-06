//
//  AppCoordinatorTests.swift
//  repotaskTests
//
//  Created by Jędrzej Sokołowski on 05/12/2022.
//

import XCTest
import Swinject
@testable import repotask

class AppCoordinatorTests: XCTest {
    var sut: AppCoordinator!
    
    override func setUp() {
        super.setUp()
        
        sut = AppCoordinator(window: UIWindow(), container: Container())
    }
    
    override func tearDown() {
        sut = nil
        
        super.tearDown()
    }
    
}
