//
//  ContentView.swift
//  NYCSchool
//
//  Created by Krishna on 3/13/24.
//

import SwiftUI

struct SchoolsListView: View {
    
    @ObservedObject private var viewModel = SchoolsListViewModel(apiServer: SchoolAPI())
    var body: some View {
        NavigationView {
            VStack {
                Text(stringContants.schoolsList)
                    .font(.headline)
                if viewModel.isloading {
                    Spacer()
                    ProgressView(stringContants.loading)
                        .progressViewStyle(.circular)
                        .foregroundColor(.black)
                        .padding()
                    Spacer()
                }else {
                    SchoolsList(viewModel: viewModel)
                }
            }
            .padding()
            .onAppear{
                viewModel.fetchSchoolslist()
            }
            .onReceive(viewModel.$error){ error in
                if let error = error {
                    Utility.showAlert(message: error.localizedDescription)
                }
            }
        }
    }
}


//School List View
struct SchoolsList: View {
    @ObservedObject var viewModel : SchoolsListViewModel
    var body: some View {
        List(viewModel.schools, id: \.self){ school in
            NavigationLink(destination: SchoolDetailView(schoolOverView: school.overView)) {
                SchoolCellView(schoolName: school.schoolName ?? ""){}
            }
        }
    }
}

//School Cell View
struct SchoolCellView: View {
    var schoolName: String
    var tapOnView: () -> Void
    var body: some View {
        VStack(alignment: .leading) {
            Button(action: {
                tapOnView()
            }, label: {
                VStack(alignment: .leading) {
                    Text("\(stringContants.schoolName) \(schoolName)")
                }
            })
        }
    }
}


#Preview {
    SchoolsListView()
}
