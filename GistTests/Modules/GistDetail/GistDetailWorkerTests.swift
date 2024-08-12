//
//  GistWorkerTests.swift
//  GistTests
//
//  Created by gabriel hideki on 10/08/24.
//

import XCTest
@testable import Gist

class GistDetailWorkerTests: XCTestCase {
    private let networkSpy: NetworkSpy = .init()
    private lazy var sut: GistDetailWorker = .init(network: networkSpy)
    
    func testGistDetailSuccessThenParseSuccedd() {
        //Given
        let dummyGistId = "1231231"
        let dummyDataDictionary: [String: Any] = ["id": dummyGistId]
        networkSpy.returnedCompletion = .success(.makeData(value: dummyDataDictionary))
        
        //When
        sut.fetchGist(gistId: dummyGistId) { result in
            switch result {
            case .success(let success):
                XCTAssertNotNil(success)
                XCTAssertEqual(success.id, dummyGistId, "Os ids são diferentes")
            case .failure:
                XCTFail("Requisição Falhou")
            }
        }
        //Then
        XCTAssertEqual(networkSpy.requestCount, 1)
    }
    
    func testGistDetailSuccessThenParseFail() {
        //Given
        let dummyGistId = "1231231"
        let dummyDataDictionary: [String: Any] = ["": ""]
        networkSpy.returnedCompletion = .success(.makeData(value: dummyDataDictionary))
        
        //When
        let expectation = self.expectation(description: "fetchGistsdetail teve sucesso na requisição e falhou ao fazer o parse")
        sut.fetchGist(gistId: dummyGistId) { result in
            switch result {
            case .success(let success):
                XCTAssertNotEqual(success.id, dummyGistId, "Os ids deveriam ser diferentes")
            case .failure:
                XCTFail("Requisição Falhou")
            }
            expectation.fulfill()
        }
        //Then
        XCTAssertEqual(networkSpy.requestCount, 1)
        waitForExpectations(timeout: 1.0)
    }
    
    func testGistDetailFailure() {
        //Given
        networkSpy.returnedCompletion = .failure(GistsError.notFound)
        
        //When
        let expectation = self.expectation(description: "fetchGistsdetail teve falha na requisição")
        sut.fetchGist(gistId: "") { result in
            switch result {
            case .success:
                XCTFail("A requisição deveria falhar")
            case .failure(let failure):
                XCTAssertEqual(failure as? GistsError, GistsError.notFound, "O erro encontrado deveria ser não encontrado")
            }
            expectation.fulfill()
        }
        //Then
        
        XCTAssertEqual(networkSpy.requestCount, 1)
        waitForExpectations(timeout: 1.0)
    }
}
