//
//  CoursesView.swift
//  e-learning
//
//  Created by rvaidya on 22/11/21.
//

import SwiftUI
import CoreData

struct CoursesView: View {
    
    @EnvironmentObject var viewModel: CoursesViewModel
    var user: User
    @State var goToCart = false
    @State var searchText = ""

    var body: some View {
        NavigationView {
            VStack {
                navBarView
                Spacer()
                    .frame(width: UIScreen.main.bounds.width, height: 1, alignment: .center)
                    .background(Color.gray)
                TextField("", text: $searchText, prompt: Text("Search for courses"))
                    .modifier(CustomTextField())
                    .padding()
                ScrollView{
                    LazyVStack {
                        ForEach(searchResults, id: \.id) { course in
                            NavigationLink {
                                CourseDetailView(user: user, pageType: .cart, course: course)
                                    .environmentObject(viewModel)
                                
                            } label: {
                                courseRow(course: course)
                            }
                            .buttonStyle(.plain)
                        }
                        .listStyle(.plain)
                    }
                    
                    
                }
                
            }
            .navigationBarTitle(Text(""), displayMode: .inline)
            .navigationBarHidden(true)
            .onAppear {
                viewModel.getAPIData()
            }
        }
        .navigationViewStyle(.stack)
        
    }
    
    var searchResults: [Course] {
           if searchText.isEmpty {
               return viewModel.courses
           } else {
               return viewModel.courses.filter({$0.name.contains(searchText)})
           }
       }
    
    var navBarView: some View {
        HStack {
            Text("Courses")
                .font(.title2)
                .fontWeight(.medium)
                .padding()
            Spacer()
            
            Button {
                goToCart = true
                viewModel.getCartCourses(for: user)
            } label: {
                Image(systemName: "cart.fill")
                    .resizable()
                    .frame(width: 30, height: 30, alignment: .center)
                    .padding()
            }
            .buttonStyle(.plain)
            
            NavigationLink(isActive: $goToCart) {
                CartView(user: user)
                    .environmentObject(viewModel)
              
            } label: {
                EmptyView()
            }
        }
    }

}

struct CoursesView_Previews: PreviewProvider {
    static var previews: some View {
        CoursesView(user: User())
            .environmentObject(CoursesViewModel(networkManager: NetworkManager()))
    }
}


