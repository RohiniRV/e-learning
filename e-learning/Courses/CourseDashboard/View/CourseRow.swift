//
//  CourseRow.swift
//  e-learning
//
//  Created by rvaidya on 23/11/21.
//

import SwiftUI

struct courseRow: View {
    var course: Course
    
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height

    init(course: Course) {
        self.course = course
    }

    var body: some View {
        HStack {
            Image(course.image)
                .resizable()
                .scaledToFit()
                .frame(width: width * 0.15, height: width * 0.15)
                .cornerRadius(12)
                
            VStack(alignment: .leading, spacing: 10) {
                Text(course.name)
                    .font(.headline)
                    .foregroundColor(.appGreen)
                Text(course.description)
            }
            .frame(height: height * 0.12)
//            .padding(.vertical)
            VStack(spacing: 5) {
                Text("Rs." + "\(course.price.rounded(toPlaces: 2))" + "/-")
                    .fontWeight(.semibold)
                    .font(.footnote)
                    .foregroundColor(.appGreen)
                Text("Rs." + "\(course.originalPrice.rounded(toPlaces: 2))" + "/-")
                    .strikethrough()
                    .font(.caption2)
                    .foregroundColor(.red)
            }

        }
        .padding()
    }
}


struct courseRow_Previews: PreviewProvider {
    static var previews: some View {
        courseRow(course: mockCourses[0])
    }
}
