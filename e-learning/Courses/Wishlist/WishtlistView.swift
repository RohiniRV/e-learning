//
//  WishtlistView.swift
//  e-learning
//
//  Created by rvaidya on 23/11/21.
//

import SwiftUI

struct WishtlistView: View {
    
    @EnvironmentObject var viewModel: CoursesViewModel
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var user: User

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.wishlistCourses.isEmpty && user.wishlistCourses.isEmpty {
                    Text("You dont have a wishlist yet!")
                }
                else {
                    navBarView
                    List(user.wishlistCourses.isEmpty ? viewModel.wishlistCourses : user.wishlistCourses, id: \.id) { course in
                        NavigationLink {
                            CourseDetailView(user: user, pageType: .wishlist, course: course)
                                .environmentObject(viewModel)
                            
                        } label: {
                            courseRow(course: course)
                        }
                        .buttonStyle(.plain)
                    }
                    .listStyle(.plain)
                }
                
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle(Text(""), displayMode: .inline)
            .navigationBarHidden(true)
           
        }
        .navigationViewStyle(.stack)

    }
    
    var navBarView: some View {
        HStack {
            Spacer()
            Text("Wishlist")
                .font(.title2)
                .fontWeight(.medium)
                .padding()
            Spacer()
            
          
        }
    }
}

struct WishtlistView_Previews: PreviewProvider {
    static var previews: some View {
        WishtlistView(user: User())
    }
}
