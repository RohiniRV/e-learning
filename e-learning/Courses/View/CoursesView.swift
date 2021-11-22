//
//  CoursesView.swift
//  e-learning
//
//  Created by rvaidya on 22/11/21.
//

import SwiftUI

struct CoursesView: View {
    
    @StateObject var viewModel = CoursesViewModel()
    
    var body: some View {
        NavigationView {
            VStack{
                NavBar(viewType: .constant(.courses))
                Spacer()
                    .frame(width: UIScreen.main.bounds.width, height: 1, alignment: .center)
                    .background(Color.gray)
                GeometryReader { proxy in
                    List(viewModel.courses, id: \.id) { course in
                        NavigationLink {
                            CourseDetailView(course: course)
                               
                        } label: {
                            coursesListView(course: course, size: proxy.size)
                        }
                        .buttonStyle(.plain)
                    }
                    .listStyle(.plain)
                    .onAppear {
                        viewModel.getCourses()
                    }
                    
                }
                
            }
            .navigationBarTitle(Text(""), displayMode: .inline)
            .navigationBarHidden(true)
        }
        .navigationViewStyle(.stack)
    }
    
    func coursesListView(course: Course, size: CGSize) -> some View {
        HStack {
            Image(course.image)
                .resizable()
                .scaledToFit()
                .frame(width: size.width * 0.15, height: size.width * 0.15)
                .cornerRadius(12)
//                .padding(.horizontal)
                
            VStack(alignment: .leading, spacing: 10) {
                Text(course.name)
                    .font(.headline)
                
                Text(course.description)
                    .font(.footnote)
            }
            .frame(height: size.height * 0.12)
            
            VStack(spacing: 5) {
                Text("Rs." + course.price + "/-")
                    .font(.footnote)
                Text(course.originalPrice)
                    .strikethrough()
                    .font(.caption2)
            }

        }
    }
}

struct CoursesView_Previews: PreviewProvider {
    static var previews: some View {
        CoursesView()
    }
}


