//
//  CharacterUseCaseTests.swift
//  DomainTests
//
//  Created by Viktor on 09/11/21.
//

@testable import Domain
import XCTest

final class CharacterUseCaseTests: XCTestCase {
    private var useCase: CharacterUseCase?
    
    private let expectationTimeout = 0.5
    private let IdData = 1
    
    override func setUp() {
        super.setUp()
        useCase = CharacterUseCase(MockCharactersProvider())
    }
    
    override func tearDown() {
        useCase = nil
        super.tearDown()
    }
    
    func testCharacters() {
        let expectation = expectation(description: "Success")
        
        useCase?.execute(IdData, completion: { result in
            if case let .success(character) = result {
                XCTAssertNotNil(character)
                expectation.fulfill()
            }
        })
        
        waitForExpectations(timeout: expectationTimeout, handler: nil)
    }
}
