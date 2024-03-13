//
//  School.swift
//  NYCSchool
//
//  Created by Krishna on 3/13/24.
//

import Foundation


struct school : Codable, Hashable, Identifiable {
    var id = UUID()
    let schoolId: String? //not sure this is unique so used the id
    let schoolName: String?
    let overView: String?

    enum CodingKeys: String, CodingKey {
        case schoolId = "dbn"
        case schoolName = "school_name"
        case overView = "overview_paragraph"
    }
    
}
