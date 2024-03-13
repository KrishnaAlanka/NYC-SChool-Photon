//
//  SchoolsListViewModel.swift
//  NYCSchool
//
//  Created by Krishna on 3/13/24.
//

import Foundation
import Combine

struct MyError: Error, Equatable {
    let LocalizedDescription: String
    init(LocalizedDescription: String) {
        self.LocalizedDescription = LocalizedDescription
    }
}

class SchoolsListViewModel: ObservableObject {
    var apiServer: SchoolsAPIProtocol
    @Published var schools : [school] = []
    @Published var error : MyError? = nil
    @Published var isloading: Bool = true
    
    private var cancellable : Set<AnyCancellable> = []
    
    init(apiServer: SchoolsAPIProtocol) {
        self.apiServer = apiServer
    }
    
    func fetchSchoolslist() {
        apiServer.fetchSchoolsList()
            .sink(receiveCompletion: { completionType in
                switch completionType {
                case .finished:
                    break
                case .failure(let error):
                    self.error = error as? MyError
                    self.isloading = false
                }
                
            }, receiveValue: { response in
                self.schools = response
                self.error = nil
                self.isloading = false
            })
            .store(in: &self.cancellable)
    }
    
    
}
