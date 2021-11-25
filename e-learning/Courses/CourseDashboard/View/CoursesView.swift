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
    @State var goToCart = false
    @State var searchText = ""

    var user: User

    var body: some View {
        NavigationView {
            VStack {
                navBarView
                customDivider
                searchBar
                coursesList
            }
            .navigationBarTitle(Text(""), displayMode: .inline)
            .navigationBarHidden(true)
            .onAppear {
                viewModel.getAPIData()
            }
        }
        .navigationViewStyle(.stack)
    }
    
  
    var navBarView: some View {
        HStack {
            Text("Courses")
                .font(.title)
                .foregroundColor(.indigo)
                .fontWeight(.semibold)
                .padding()
            Spacer()
            cartBtn
            NavigationLink(isActive: $goToCart) {
                CartView(user: user)
                    .environmentObject(viewModel)
              
            } label: {
                EmptyView()
            }
        }
    }
    
    var cartBtn: some View {
        Button {
            goToCart = true
            viewModel.getCartCourses(for: user)
        } label: {
            Image(systemName: "cart.fill")
                .resizable()
                .foregroundColor(.indigo)
                .frame(width: 30, height: 30, alignment: .center)
                .padding()
        }
        .buttonStyle(.plain)
    }
    
    var customDivider: some View {
        Spacer()
            .frame(width: UIScreen.main.bounds.width, height: 1, alignment: .center)
            .background(Color.gray)
    }

    var searchBar: some View {
        TextField("", text: $searchText, prompt: Text("Search for courses"))
            .modifier(CustomTextField())
            .padding()
    }
    
    var coursesList: some View {
        ScrollView {
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
                .listStyle(.grouped)
            }
        }
        .frame(height: UIScreen.main.bounds.height*0.7)
    }
    
    var searchResults: [Course] {
        if searchText.isEmpty {
            return viewModel.courses
        } else {
            return viewModel.courses.filter({$0.name.contains(searchText)})
        }
    }
    
}

struct CoursesView_Previews: PreviewProvider {
    static var previews: some View {
        CoursesView(user: User())
            .environmentObject(CoursesViewModel(networkManager: NetworkManager()))
    }
}


