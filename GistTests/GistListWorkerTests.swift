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
    
    func testSuccessThenParseError() {
        //given
        let dummyDataDictionary: [[String: Any]] = [["id": "1231231"]]
        networkSpy.returnedCompletion = .success(.makeData(value: dummyDataDictionary))
        
        //when 
        sut.fetchGists(page: 0) { result in
            //then
            if case let .success(data) = result {
                XCTAssertNil(data)
            }
            
            XCTAssertEqual(self.networkSpy.requestCount, 1)
        }
    }
    
    func testSuccessWhenParseSuccess() {
        //given
        let dummyDataDictionary: [[String: Any]] = [["id": "1231231"]]
        networkSpy.returnedCompletion = .success(.makeData(value: dummyDataDictionary))
        
        //when
        sut.fetchGists(page: 0) { result in
            //then
            if case let .success(data) = result {
                XCTAssertNotNil(data)
            }
            
            XCTAssertEqual(self.networkSpy.requestCount, 1)
        }
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
                // Tratamento de erro: a conversão falhou
            }
        } else {
            return nil
        }
    }
}
