//
//  GistListWorkerTests.swift
//  GistTests
//
//  Created by gabriel hideki on 07/08/24.
//

import XCTest
@testable import Gist

class GistListWorkerTests: XCTestCase {
    private let networkSpy: NetworkSpy = .init()
    private lazy var sut: GistListWorker = .init(network: networkSpy)
    
    func testSuccessWhenParseFailure() {
        //Given
        let dummyGistId = "1231231"
        let dummyDataDictionary: [[String: Any]] = [["":""]]
        networkSpy.returnedCompletion = .success(.makeData(value: dummyDataDictionary))
        
        //When
        let expectation = self.expectation(description: "fetchGists retornou sucesso mas falhou ao fazer o parse")
        sut.fetchGists(page: 0) { result in
            //Then
            switch result {
            case .success(let gists):
                XCTAssertNotEqual(gists.first?.id, dummyGistId, "O id não deveria ser igual")
            case .failure:
                XCTFail("Requisição falhou")
            }
            XCTAssertEqual(self.networkSpy.requestCount, 1)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testSuccessWhenParseSuccess() {
        //Given
        let dummyGistId = "1231231"
        let dummyDataDictionary: [[String: Any]] = [["id": "\(dummyGistId)"]]
        networkSpy.returnedCompletion = .success(.makeData(value: dummyDataDictionary))
        
        //When
        let expectation = self.expectation(description: "fetchGists retornou sucessoe teve sucesso ao fazer o parse")
        sut.fetchGists(page: 0) { result in
            //Then
            switch result {
            case .success(let gists):
                XCTAssertFalse(gists.isEmpty, "Sucesso porém lista vazia")
                XCTAssertEqual(gists.first?.id, dummyGistId, "O ID do primeiro gist deveria ser \(dummyGistId).")
            case .failure:
                XCTFail("Requisição falhou")
            }
            XCTAssertEqual(self.networkSpy.requestCount, 1)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testFetchGistsWhenFailure() {
        //Given
        networkSpy.returnedCompletion = .failure(GistsError.notFound)
        
        //When
        let expectation = self.expectation(description: "fetchGists retornou falha")
        sut.fetchGists(page: 0) { result in
            //Then
            switch result {
            case .success(let success):
                XCTAssertNil(success)
            case .failure(let failure):
                XCTAssertEqual(failure as? GistsError, GistsError.notFound)
            }
            XCTAssertEqual(self.networkSpy.requestCount, 1)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
}
