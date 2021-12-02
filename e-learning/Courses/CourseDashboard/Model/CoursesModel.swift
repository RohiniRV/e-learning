//
//  CoursesModel.swift
//  e-learning
//
//  Created by rvaidya on 22/11/21.
//

import Foundation


struct Course: Hashable, Identifiable, Codable {
    var id: UUID
    var name: String
    var description: String
    var image: String
    var price: Double
    var originalPrice: Double
    var isFav: Bool
    var isAddedToCart: Bool
}

protocol CourseBuilder {
    func createCourses()
    func addToWishList(course: Course)
    func addToCart(course: Course)
    func removeFromWishList(course: Course)
    func removefromCart(course: Course)
}

final class CoursesManager: CourseBuilder {
    
    var courses = [Course]()
    
    init() {
        createCourses()
    }
    
    func createCourses() {
        courses = mockCourses
    }
    
    func addToCart(course: Course) {
        courses.indices.forEach({
            if courses[$0].id == course.id {
                courses[$0].isAddedToCart = true
            }
        })
        print("Add to cart \(courses)")
    }
    
    func addToWishList(course: Course) {
        courses.indices.forEach({
            if courses[$0].id == course.id {
                courses[$0].isFav = true
            }
        })
    }
    
    func removefromCart(course: Course) {
        courses.indices.forEach({
            if courses[$0].id == course.id {
                courses[$0].isAddedToCart = false
            }
        })
    }
    
    func removeFromWishList(course: Course) {
        courses.indices.forEach({
            if courses[$0].id == course.id {
                courses[$0].isFav = false
            }
        })
    }
}


let mockCourses: [Course] = [
                             .init(id: UUID(), name: "100 days of SwiftUI", description: "This is a free collection of videos, tutorials, tests, and more, all drawn from around my work here on Hacking with Swift, and all designed to help you learn SwiftUI effectively.", image: "swiftui_logo", price: 450, originalPrice: 600, isFav: false, isAddedToCart: false),
                             .init(id: UUID(), name: "100 days of Swift", description: "This is a free collection of videos, tutorials, tests, and more, all drawn from around my existing work here on Hacking with Swift, and all designed to help you learn Swift.", image: "swift_logo", price: 700, originalPrice: 800, isFav: false, isAddedToCart: false),
                             .init(id: UUID(), name: "Dependency Injection in Swift", description: "This tutorial helps in understanding the basics of Dependency Injection in Swift.", image: "dependencyInjection", price: 700, originalPrice: 800, isFav: false, isAddedToCart: false),
                             .init(id: UUID(), name: "What's new in Swift 5.5?", description: "This tutorial helps in understanding the what's new in Swift 5.5?.", image: "5_5", price: 700, originalPrice: 800, isFav: false, isAddedToCart: false),
                             .init(id: UUID(), name: "Dependency Injection in Swift", description: "This tutorial helps in understanding the basics of Dependency Injection in Swift.", image: "dependencyInjection", price: 720, originalPrice: 820, isFav: false, isAddedToCart: false),
                             .init(id: UUID(), name: "What's new in Swift 5.5?", description: "This tutorial helps in understanding the what's new in Swift 5.5?.", image: "5_5", price: 740, originalPrice: 840, isFav: false, isAddedToCart: false),
                             .init(id: UUID(), name: "Dependency Injection in Swift", description: "This tutorial helps in understanding the basics of Dependency Injection in Swift.", image: "dependencyInjection", price: 760, originalPrice: 860, isFav: false, isAddedToCart: false),
                             .init(id: UUID(), name: "What's new in Swift 5.5?", description: "This tutorial helps in understanding the what's new in Swift 5.5?.", image: "5_5", price: 780, originalPrice: 880, isFav: false, isAddedToCart: false),
                             .init(id: UUID(), name: "100 days of SwiftUI", description: "This is a free collection of videos, tutorials, tests, and more, all drawn from around my work here on Hacking with Swift, and all designed to help you learn SwiftUI effectively.", image: "swiftui_logo", price: 500, originalPrice: 650, isFav: false, isAddedToCart: false),
                             .init(id: UUID(), name: "100 days of Swift", description: "This is a free collection of videos, tutorials, tests, and more, all drawn from around my existing work here on Hacking with Swift, and all designed to help you learn Swift.", image: "swift_logo", price: 710, originalPrice: 810, isFav: false, isAddedToCart: false),
                             .init(id: UUID(), name: "Dependency Injection in Swift", description: "This tutorial helps in understanding the basics of Dependency Injection in Swift.", image: "dependencyInjection", price: 900, originalPrice: 1050, isFav: false, isAddedToCart: false),
                            ]
