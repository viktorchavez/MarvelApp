//
//  DataTests.swift
//  DataTests
//
//  Created by Viktor on 09/11/21.
//

import Domain
import Moya
@testable import Data
import XCTest

final class DataTests: XCTestCase {
    enum ResponseType {
        case success, timeoutError, serverError
    }
    
    private let expectationTimeout = 0.5
    private let namePrefixData: String? = nil
    private let offsetData: Int? = nil
    private let characterIDData = 1
    
    func charactersProvider(responseType: ResponseType = .success) -> CharactersProviderContract {
        var sampleResponse: EndpointSampleResponse?
        var endpointClosure: (CharactersService) -> Endpoint
        
        switch(responseType){
        case .success:
            sampleResponse = nil
        case .timeoutError:
            sampleResponse = EndpointSampleResponse.networkError(NSError(domain: NSURLErrorDomain, code: URLError.timedOut.rawValue, userInfo: nil))
        case .serverError:
            sampleResponse = EndpointSampleResponse.networkResponse(500, Data())
        }

        
        if let response = sampleResponse {
            endpointClosure = { target in
                return Endpoint(url: URL(target: target).absoluteString,
                                sampleResponseClosure: { response },
                                method: target.method,
                                task: target.task,
                                httpHeaderFields: target.headers)
            }
        } else {
            endpointClosure = MoyaProvider<CharactersService>.defaultEndpointMapping
        }
        
        let provider = MoyaProvider<CharactersService>(endpointClosure: endpointClosure, stubClosure: MoyaProvider.immediatelyStub)
        return CharactersProvider(provider)
    }
    
    //MARK: - Characters Tests
    
    func testCharactersSuccess() {
        let expectation = expectation(description: "Success")
        
        charactersProvider().characters(namePrefix: namePrefixData, offset: offsetData) { result in
            if case let .success(characters) = result {
                XCTAssert(!characters.isEmpty)
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: expectationTimeout, handler: nil)
    }
    
    func testCharactersTimeoutError() {
        let expectation = expectation(description: "Timeout Error")
        
        charactersProvider(responseType: .timeoutError).characters(namePrefix: namePrefixData, offset: offsetData) { result in
            if case let .failure(failure) = result,
                case let .related(related) = failure,
                let moyaError = related as? MoyaError,
                case let .underlying(error, _) = moyaError {
                XCTAssertEqual((error as NSError).code, URLError.timedOut.rawValue)
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: expectationTimeout, handler: nil)
    }
    
    func testCharactersServerError() {
        let expectation = expectation(description: "Server Error")
        
        charactersProvider(responseType: .serverError).characters(namePrefix: namePrefixData, offset: offsetData) { result in
            if case let .failure(failure) = result,
                case let .related(related) = failure,
                case let .dataCorrupted(dataError) = related as? DecodingError,
                let error = dataError.underlyingError as NSError? {
                XCTAssertEqual(error.code, NSPropertyListReadCorruptError)
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: expectationTimeout, handler: nil)
    }
    
    //MARK: Character Tests
    
    func testCharacterSuccess() {
        let expectation = expectation(description: "Success")
        
        charactersProvider().character(id: characterIDData) { result in
            if case let .success(character) = result {
                XCTAssertNotNil(character)
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: expectationTimeout, handler: nil)
    }
    
    func testCharacterTimeoutError() {
        let expectation = expectation(description: "Timeout Error")
        
        charactersProvider(responseType: .timeoutError).character(id: characterIDData) { result in
            if case let .failure(failure) = result,
                case let .related(related) = failure,
                let moyaError = related as? MoyaError,
                case let .underlying(error, _) = moyaError {
                XCTAssertEqual((error as NSError).code, URLError.timedOut.rawValue)
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: expectationTimeout, handler: nil)
    }
    
    func testCharacterServerError() {
        let expectation = expectation(description: "Server Error")
        
        charactersProvider(responseType: .serverError).character(id: characterIDData) { result in
            if case let .failure(failure) = result,
                case let .related(related) = failure,
                case let .dataCorrupted(dataError) = related as? DecodingError,
                let error = dataError.underlyingError as NSError? {
                XCTAssertEqual(error.code, NSPropertyListReadCorruptError)
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: expectationTimeout, handler: nil)
    }
}
