//
//  AppCoordinatorTests.swift
//  repotaskTests
//
//  Created by Jędrzej Sokołowski on 05/12/2022.
//

import XCTest
import Swinject
@testable import repotask

final class AppCoordinatorTests: XCTest {
    var sut: AppCoordinator!
    
    override func setUp() {
        super.setUp()
        
        self.sut = AppCoordinator(window: UIWindow(), container: Container())
    }
    
    override func tearDown() {
        self.sut = nil
        
        super.tearDown()
    }
    
}
