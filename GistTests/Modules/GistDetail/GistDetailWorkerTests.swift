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
        sut.fetchGist(gistId: dummyGistId) { result in
            switch result {
            case .success(let success):
                XCTAssertNotEqual(success.id, dummyGistId, "Os ids deveriam ser diferentes")
            case .failure:
                XCTFail("Requisição Falhou")
            }
        }
        //Then
        XCTAssertEqual(networkSpy.requestCount, 1)
    }
    
    func testGistDetailFailure() {
        //Given
        networkSpy.returnedCompletion = .failure(GistsError.notFound)
        
        //When
        
        sut.fetchGist(gistId: "") { result in
            switch result {
            case .success:
                XCTFail("A requisição deveria falhar")
            case .failure(let failure):
                XCTAssertEqual(failure as? GistsError, GistsError.notFound, "O erro encontrado deveria ser não encontrado")
            }
        }
        //Then
        
        XCTAssertEqual(networkSpy.requestCount, 1)
    }
}
