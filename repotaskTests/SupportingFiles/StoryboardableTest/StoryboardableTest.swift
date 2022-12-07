//
//  StoryboardableTest.swift
//  repotaskTests
//
//  Created by Jędrzej Sokołowski on 06/12/2022.
//

import XCTest
@testable import repotask
final class StoryboardableTest: XCTestCase {
    
    func testStaticInstantiateReturnsValidViewController() {
        let sut = MockViewController.self
        
        let vc = sut.instantiate(bundle: Bundle(for: sut))
        
        let expected: MockViewController? = nil
        
        XCTAssertEqual("\(type(of: vc))", "\(type(of: expected))")
    }
}
