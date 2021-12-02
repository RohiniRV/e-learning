//
//  CourseObject+Coredata .swift
//  e-learning
//
//  Created by rvaidya on 30/11/21.
//

import Foundation
import CoreData

extension CourseObject {
    
    var courseId: UUID {
        id ?? UUID()
    }
    
    var courseName: String {
        title ?? "New Course"
    }
    
    var courseDetails: String {
        details ?? "default"
    }
    
    var courseImage: String {
        image ?? ""
    }
}
