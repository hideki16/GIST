//
//  GistViewModelTests.swift
//  GistTests
//
//  Created by gabriel hideki on 11/08/24.
//

import XCTest
@testable import Gist

class GistDetailViewModelTests: XCTestCase {
    let mockWorker: GistDetailWorkerMock = .init()
    let gistDummy: Gist = .init(id: "1")
    private lazy var sut: GistDetailViewModel = .init(worker: mockWorker, gist: gistDummy)
    
    func testFetchGistsDetailSuccess() {
        // Given
        let expectedGist = Gist(id: "1")
        mockWorker.result = .success(expectedGist)
        
        // When
        let expectation = self.expectation(description: "fetchGist faz a requisição e retorna um gist valido")
        sut.fetchGistDetail { result in
            XCTAssertTrue(result)
            XCTAssertEqual(expectedGist, self.sut.gist, "Os gists armazenados deveriam ser os mesmos")
            expectation.fulfill()
        }
        
        // Then
        XCTAssertEqual(mockWorker.fetchCount, 1)
        waitForExpectations(timeout: 1.0)
    }
    
    func testFetchGistsDetailFailure() {
        // Given
        mockWorker.result = .failure(GistsError.notFound)
        
        // When
        let expectation = self.expectation(description: "fetchGist faz a requisição e retorna um gist valido")
        sut.fetchGistDetail { result in
            XCTAssertFalse(result)
            expectation.fulfill()
        }
        
        // Then
        XCTAssertEqual(mockWorker.fetchCount, 1)
        waitForExpectations(timeout: 1.0)
    }
    
    func testFetchGistsDetailCallsCompletionOnSuccess() {
        //Given
        var callbackCalled = false
        let gist: Gist = .init(id: "1")
        mockWorker.result = .success(gist)
        
        //When
        let expectation = expectation(description: "fetchGists chamou o callback em um retorno de falha")
        sut.fetchGistDetail { result in
            callbackCalled = true
            expectation.fulfill()
        }
        
        //Then
        XCTAssertEqual(mockWorker.fetchCount, 1)
        XCTAssertTrue(callbackCalled)
        waitForExpectations(timeout: 1.0)
    }
    
    func testFetchGistsDetailCallsCompletionOnFailure() {
        //Given
        var callbackCalled = false
        mockWorker.result = .failure(GistsError.notFound)
        
        //When
        let expectation = expectation(description: "fetchGists chamou o callback em um retorno de falha")
        sut.fetchGistDetail { result in
            callbackCalled = true
            expectation.fulfill()
            XCTAssertTrue(callbackCalled)
        }
        
        //Then
        XCTAssertEqual(mockWorker.fetchCount, 1)
        waitForExpectations(timeout: 1.0)
    }
}
