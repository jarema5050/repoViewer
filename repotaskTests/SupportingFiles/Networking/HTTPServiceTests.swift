//
//  HTTPServiceTests.swift
//  repotaskTests
//
//  Created by Jędrzej Sokołowski on 07/12/2022.
//

import XCTest
import Swinject
@testable import repotask


final class HTTPServiceTests: XCTestCase {

    let container = Container()
    
    override func setUp() {
        container.register(MockURLProtocol.self) { _ in
            let mockDataEncoded = try JSONEncoder().encode(MockData())
            return MockURLProtocol.requestHandler = { request in
                return (HTTPURLResponse(), mockDataEncoded)
            }
        }
        
        container.register(URLSession.self) { _ in
            let configuration = URLSessionConfiguration.ephemeral
            configuration.protocolClasses = [MockURLProtocol.self]
            return URLSession(configuration: configuration)
        }
        
        container.register(HTTPService.self) { resolver in
            HTTPService(session: resolver.resolve(URLSession.self))
        }
        
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    override func testHttpService_whenSuccess_MessageIsValid() {
        container.resolve(HTTPService.self)?.fetch(url: URL(string: <#T##String#>))
    }
}
