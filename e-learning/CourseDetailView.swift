//
//  CourseDetailView.swift
//  e-learning
//
//  Created by rvaidya on 22/11/21.
//

import SwiftUI

struct CourseDetailView: View {
    var course: Course
    
    var body: some View {
//        VStack {
//
          
            GeometryReader { proxy in
               Divider()
                VStack {
               
                    Image(course.image)
                        .resizable()
                        .frame(width: proxy.size.width * 0.9, height: proxy.size.height * 0.3, alignment: .center)
                        .cornerRadius(16)
                        .padding()
                    VStack(alignment: .leading) {
                        Text(course.name)
                            .font(.title)
                            .fontWeight(.semibold)
                            .padding(.vertical)
                        Text("Course Description")
                            .font(.title3)
                            .fontWeight(.medium)
                            .padding(.vertical)
                        Text(course.description)
                            .font(.body)
                        
                        HStack {
                            Text("Price:")
                                .font(.title3)
                                .fontWeight(.medium)
                                .padding(.vertical)
                            Text("Rs." + course.price + "/-")
                        }
                       
                    }
                    Spacer()
                    Button {
                        //
                    } label: {
                        Text("Add to cart")
                            .font(.title3)
                            .bold()
                    }
                    .buttonStyle(.plain)
                    .padding()
                    .frame(width: proxy.size.width * 0.9, height: 50, alignment: .center)
                    .background(Color.green)
                    .cornerRadius(16)
                    .padding()

                }
                .padding()
                
            }
//        }
//        .navigationBarBackButtonHidden(true)
        
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Text("Courses")
                    .font(.title3)
                    .foregroundColor(.blue)
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Image(systemName: "heart.fill")
                   
            }
        }
    }
}

struct CourseDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CourseDetailView(course: mockCourses[0])
    }
}
