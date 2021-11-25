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
        var ids = [Int]()
        if let wishlistIds = self.wishlist {
            do {
                if let idsArray = try NSKeyedUnarchiver.unarchivedObject(ofClass: NSArray.self, from: wishlistIds) as? [Int] {
                    print("Wishlist Ids \(idsArray)")
                    ids = idsArray
                }
            } catch {
                print("could not unarchive array: \(error)")
            }
        }
        return ids
    }
    
    var cartCourses_Ids: [Int] {
        var ids = [Int]()
        if let cartIds = self.cartItems {
            do {
                if let cartIdsArray = try NSKeyedUnarchiver.unarchivedObject(ofClass: NSArray.self, from: cartIds) as? [Int] {
                    print("Cart Ids \(cartIdsArray)")
                    ids = cartIdsArray
                }
            } catch {
                print("could not unarchive array: \(error)")
            }
        }
        return ids
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
                print("Course appended to user cart")
                courses.append(course)
            }
        }
       
        courses.sort(by: { $0.id < $1.id })
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
                print("Course appended to user cart")
                courses.append(course)
            }
        }
       
        courses.sort(by: { $0.id < $1.id })
        return courses
    }
}
