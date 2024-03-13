//
//  NYCSchoolTests.swift
//  NYCSchoolTests
//
//  Created by Krishna on 3/13/24.
//

import XCTest
import Combine
@testable import NYCSchool

final class SchoolsListViewModelTest: XCTestCase {
    
    var viewModel: SchoolsListViewModel!
    var cancellable : Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        let mockServer = MockApiserver(Successresponse: true)
        viewModel = SchoolsListViewModel(apiServer: mockServer)
        cancellable = Set<AnyCancellable>()
    }
    
    override func tearDown() {
        viewModel = nil
        cancellable = nil
        super.tearDown()
    }
    
    func testfetchSchoolslistSuccess() {
        let expectation = XCTestExpectation(description: "Fetch School List Success")
        
        let mockServer = MockApiserver(Successresponse: true)
        viewModel = SchoolsListViewModel(apiServer: mockServer)
        
        viewModel.$schools
            .sink(receiveValue: { schools in
                XCTAssertEqual(schools.count, 1)
                expectation.fulfill()
            })
            .store(in: &self.cancellable)
        
        viewModel.fetchSchoolslist()
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testfetchSchoolslistFailure() {
        let expectation = XCTestExpectation(description: "Fetch School List Failure")
        
        let mockServer = MockApiserver(Successresponse: false)
        viewModel = SchoolsListViewModel(apiServer: mockServer)
        
        viewModel.$schools
            .sink(receiveValue: { error in
                XCTAssertNotNil(error)
                expectation.fulfill()
            })
            .store(in: &self.cancellable)
        
        viewModel.fetchSchoolslist()
        
        wait(for: [expectation], timeout: 5.0)
    }

}

class MockApiserver: SchoolsAPIProtocol {
  
    
    let Successresponse : Bool
    init(Successresponse: Bool) {
        self.Successresponse = Successresponse
    }
    
    func fetchSchoolsList() -> Future<[NYCSchool.school], Error> {
        return Future { promise in
            if self.Successresponse {
                promise(.success([school(schoolId: "02M260", schoolName: "Mock School", overView: "Mock Overview")]))
            }else {
                promise(.failure(NetworkError.NoData))
            }
            
        }
    }
 
    
}
