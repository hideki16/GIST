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
    
    func testFetchGistsPageCountOnSuccess() {
        // Given
        let lastPage: Int = sut.currentPage
        let expectation = self.expectation(description: "Ao ter sucesso fetchgists incrementa em 1 a pagina atual")
        mockWorker.result = .success([])
        
        // When
        sut.fetchGists { result in
            // Then
            XCTAssertEqual(self.sut.currentPage - 1, lastPage, "O incremento da paginação não foi realizado")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0)
    }
    
    func testFetchGistsPageCountOnFailure() {
        // Given
        let lastPage: Int = sut.currentPage
        let expectation = self.expectation(description: "Ao ter falha fetchgists não deve incrementar a pagina atual")
        mockWorker.result = .failure(GistsError.notFound)
        
        // When
        sut.fetchGists { result in
            // Then
            XCTAssertEqual(self.sut.currentPage, lastPage, "Ao falhar, a paginação não deveria ser incrementada")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0)
    }
}
