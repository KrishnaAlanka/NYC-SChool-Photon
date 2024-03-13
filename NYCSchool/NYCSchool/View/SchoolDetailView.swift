//
//  SchoolDetailView.swift
//  NYCSchool
//
//  Created by Krishna on 3/13/24.
//

import Foundation
import SwiftUI

struct SchoolDetailView: View {
    var schoolOverView: String?
    
    var body: some View {
        NavigationView {
            VStack {
                Text(stringContants.schoolOverView)
                Spacer()
                Text(schoolOverView ?? "")
                Spacer()
            }
            .padding()
        }
    }
}
