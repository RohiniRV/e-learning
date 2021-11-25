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
    
    var wishlistCourses_Ids: [Int] {
        var courseIds = [Int]()
        if let storedIds = self.wishlist {
            do {
                if let idsUnarchived = try NSKeyedUnarchiver.unarchivedObject(ofClass: NSArray.self, from: storedIds) as? [Int] {
                    courseIds = idsUnarchived
                }
            } catch {
                print("could not unarchive array: \(error)")
            }
        }
        return courseIds
    }
    
    var cartCourses_Ids: [Int] {
        var courseIds = [Int]()
        if let storedIds = self.cartItems {
            do {
                if let idsUnarchived = try NSKeyedUnarchiver.unarchivedObject(ofClass: NSArray.self, from: storedIds) as? [Int] {
                    courseIds = idsUnarchived
                }
            } catch {
                print("could not unarchive array: \(error)")
            }
        }
        return courseIds
    }
    
    var wishlistCourses: [Course] {
        guard !wishlistCourses_Ids.isEmpty else {
            print("Wishlist courses are empty")
            return []
        }
        let ids = wishlistCourses_Ids.sorted(by: {$0 > $1})
        var courses = [Course]()
        mockCourses.forEach { course in
            if ids.contains(course.id) {
                print("Course with id: \(course.id) appended to the cart")
                var favCourse = course
                favCourse.isFav = true
                courses.append(favCourse)
            }
        }
        courses.sort(by: { $0.id < $1.id })
        print("Wishlist Course from Coredata \(courses)")
        return courses
        
    }
    
    var cartCourses: [Course] {
        guard !cartCourses_Ids.isEmpty else {
            print("Cart courses are empty")
            return []
            
        }
        let ids = cartCourses_Ids.sorted(by: {$0 > $1})
        var courses = [Course]()
        mockCourses.forEach { course in
            if ids.contains(course.id) {
                print("Course with id: \(course.id) appended to wishlist")
                var cartCourse = course
                cartCourse.isAddedToCart = true
                courses.append(cartCourse)
            }
        }
        courses.sort(by: { $0.id < $1.id })
        return courses
    }
}
