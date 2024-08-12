//
//  GistListViewModelTests.swift
//  GistTests
//
//  Created by gabriel hideki on 11/08/24.
//

import XCTest
@testable import Gist

class GistListViewModelTests: XCTestCase {
    private let mockWorker: GistListWorkerMock = .init()
    private lazy var sut: GistListViewModel = .init(worker: mockWorker)
    
    func testFetchGistsSuccess() {
        // Given
        let expectedGists = [Gist(id: "1"), Gist(id: "2")]
        
        mockWorker.result = .success(expectedGists)
        
        // When
        sut.fetchGists { result in
            XCTAssertTrue(result)
            XCTAssertEqual(expectedGists, self.sut.gists, "Os gists armazenados deveriam ser os mesmos")
        }
        
        // Then
        XCTAssertEqual(mockWorker.fetchCount, 1)
    }
    
    
    func testFetchGistsFailure() {
        // Given
        mockWorker.result = .failure(GistsError.notFound)
        
        // When
        sut.fetchGists { result in
            XCTAssertFalse(result)
            XCTAssertTrue(self.sut.gists.isEmpty, "A lista de gists deveria estar vazia")
        }
        
        // Then
        XCTAssertEqual(mockWorker.fetchCount, 1)
    }
    
    func testFetchGistsCallsCompletionOnSuccess() {
        // Given
        var callbackCalled = false
        let expectation = self.expectation(description: "O Callback de fetchGists foi chamado")
        mockWorker.result = .success([])
        
        // When
        sut.fetchGists { result in
            callbackCalled = true
            XCTAssertTrue(callbackCalled)
            expectation.fulfill()
        }
        
        // Then
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testFetchGistsCallsCompletionOnFailure() {
        // Given
        var callbackCalled = false
        let expectation = self.expectation(description: "O Callback de fetchGists foi chamado")
        mockWorker.result = .failure(GistsError.notFound)
        
        // When
        sut.fetchGists { result in
            callbackCalled = true
            XCTAssertTrue(callbackCalled)
            expectation.fulfill()
        }
        
        // Then
        waitForExpectations(timeout: 1.0, handler: nil)
    }
}
