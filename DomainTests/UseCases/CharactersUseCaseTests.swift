//
//  CharactersUseCaseTests.swift
//  DomainTests
//
//  Created by Viktor on 09/11/21.
//

@testable import Domain
import XCTest

final class CharactersUseCaseTests: XCTestCase {
    private var useCase: CharactersUseCase?
    
    private let expectationTimeout = 0.5
    private let namePrefixData: String? = nil
    private let offsetData: Int? = nil
    
    override func setUp() {
        super.setUp()
        useCase = CharactersUseCase(MockCharactersProvider())
    }
    
    override func tearDown() {
        useCase = nil
        super.tearDown()
    }
    
    func testCharacters() {
        let expectation = expectation(description: "Success")
        
        useCase?.execute(namePrefix: namePrefixData, offset: offsetData, completion: { result in
            if case let .success(characters) = result {
                XCTAssert(!characters.isEmpty)
                expectation.fulfill()
            }
        })
        
        waitForExpectations(timeout: expectationTimeout, handler: nil)
    }
}
