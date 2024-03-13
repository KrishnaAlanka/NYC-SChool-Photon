//
//  SchoolAPI.swift
//  NYCSchool
//
//  Created by Krishna on 3/13/24.
//

import Foundation
import Combine

enum NetworkError : Error{
    case InvalidURL
    case NoData
}


enum HTTPType: String {
    case post = "POST"
    case get = "GET"
    case put = "PUT"
}

protocol SchoolsAPIProtocol {
    func fetchSchoolsList() -> Future<[school], Error>
}

class SchoolAPI: SchoolsAPIProtocol{
    
    private var cancellables: Set<AnyCancellable> = []
    
    func fetchSchoolsList() -> Future<[school], Error>  {
        return Future<[school], Error> { promise in
            //Check the URL
            guard let url = URL(string: serviceUtility.SchoolslistURL) else {
                return promise(.failure(NetworkError.InvalidURL))
            }
            
            //Create the request
            var request = URLRequest(url: url)
            request.httpMethod = HTTPType.get.rawValue
            
            //Create a publisher and call the API .sink(combine)
            URLSession.shared.dataTaskPublisher(for: request)
                .map(\.data)
                .decode(type: [school].self, decoder: JSONDecoder())
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion:{ completionType in
                    switch completionType {
                    case .finished :
                        break
                    case .failure(let error):
                        promise(.failure(error))
                    }
                    
                } , receiveValue: { schools in
                    promise(.success(schools))
                })
                .store(in: &self.cancellables)
        }
        
    }
    
    
    
    
    
}
