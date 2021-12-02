//
//  User+CoreData.swift
//  e-learning
//
//  Created by rvaidya on 24/11/21.
//

import Foundation
import CoreData

extension User {
    
    var profileName: String {
        name ?? "--"
    }
    
    var userBio: String {
        bio ?? "--"
    }
    
    var userBandName: String {
        bandName ?? "--"
    }
    
    var userLevel: String {
        level ?? "--"
    }
    
    var userSkills: String {
        skills ?? "--"
    }
    
    var email: String {
        self.username ?? "New User@\(UUID()).com"
    }
    
    var wishlistCourses: [Course] {
        guard let list = self.courses as? Set<CourseObject> else {
            print("Wishlist Courses []")
            return []
        }
        var courseList = [Course]()
        print("List \(list)")
        list.forEach { course in
            if course.isFav {
                let newCourse = Course(id: course.courseId, name: course.courseName, description: course.courseDetails, image: course.courseImage, price: course.sellingPrice, originalPrice: course.costPrice, isFav: course.isFav, isAddedToCart: course.isInCart)
                courseList.append(newCourse)
            }
        }
        return courseList
    }
    
    var cartCourses: [Course] {
        guard let list = self.courses as? Set<CourseObject> else {
            print("Cart Courses []")
            return []
            
        }
        var courseList = [Course]()
        list.forEach { course in
            if course.isInCart {
                let newCourse = Course(id: course.courseId, name: course.courseName, description: course.courseDetails, image: course.courseImage, price: course.sellingPrice, originalPrice: course.costPrice, isFav: course.isFav, isAddedToCart: course.isInCart)
                courseList.append(newCourse)
            }
        }
        return courseList
    }
}

//solving the array problem in coredata
//solving the save, fetch, update & delete problem. Betterement of that architecture.
//better use of combine in asynchronous calls
//better modularization
//error management system
