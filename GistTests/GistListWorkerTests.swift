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
    
    func testFetchGistsWhenSuccess() {
        let dummyDataDictionary: [String: Any] = ["id": "1231231"]
        networkSpy.returnedCompletion = .success(.makeData(value: dummyDataDictionary))
    }
    
    func testSuccessWhenParseFailure() {
        //given
        let dummyGistId = "1231231"
        let dummyDataDictionary: [[String: Any]] = [["":""]]
        networkSpy.returnedCompletion = .success(.makeData(value: dummyDataDictionary))
        
        //when
        let expectation = self.expectation(description: "fetchGists completion")
        sut.fetchGists(page: 0) {  result in
            //then
            switch result {
            case .success(let gists):
                XCTAssertTrue(gists.isEmpty, "Sucesso porém lista vazia")
                XCTAssertNotEqual(gists.first?.id, dummyGistId, "O ID do primeiro gist deveria ser \(dummyGistId).")
            case .failure:
                XCTFail("Requisição falhou")
            }
            XCTAssertEqual(self.networkSpy.requestCount, 1)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testSuccessWhenParseSuccess() {
        //given
        let dummyGistId = "1231231"
        let dummyDataDictionary: [[String: Any]] = [["id": "\(dummyGistId)"]]
        networkSpy.returnedCompletion = .success(.makeData(value: dummyDataDictionary))
        
        //when
        let expectation = self.expectation(description: "fetchGists completion")
        sut.fetchGists(page: 0) {  result in
            //then
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
        //given
        networkSpy.returnedCompletion = .failure(GistsError.notFound)
        
        //when
        sut.fetchGists(page: 0) { result in
            //then
            switch result {
            case .success(let success):
                XCTAssertNil(success)
            case .failure(let failure):
                XCTAssertEqual(failure as? GistsError, GistsError.notFound)
            }
            
            XCTAssertEqual(self.networkSpy.requestCount, 1)
        }
    }
    
    func testNil() {
        networkSpy.returnedCompletion = .success(nil)
    }
}

final class NetworkSpy: NetworkProtocol {
    var inject: InjectProtocol.Type = Inject.self
    
    var returnedCompletion: Result<Data?, Error> = .success(nil)
    
    private(set) var requestCount: Int = 0
    
    func request(requestEndpoint: RequestEndpoint, completion: @escaping (Result<Data?, Error>) -> Void) {
        requestCount += 1
        completion(returnedCompletion)
    }
}

extension Data {
    static func makeData(value: Any) -> Data? {
        if let dictionary = value as? [String: Any] {
            do {
                let data = try JSONSerialization.data(withJSONObject: dictionary, options: [])
                return data
            } catch {
                return nil
            }
        } else if let array = value as? [[String: Any]] {
            do {
                let data = try JSONSerialization.data(withJSONObject: array, options: [])
                return data
            } catch {
                return nil
            }
        }
        return nil
    }
}
