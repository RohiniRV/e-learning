//
//  CoursesModel.swift
//  e-learning
//
//  Created by rvaidya on 22/11/21.
//

import Foundation


struct Course: Hashable, Identifiable, Codable {
    var id: Int
    var name: String
    var description: String
    var image: String
    var price: Double
    var originalPrice: Double
    var isFav: Bool
    var isAddedToCart: Bool
}


//MARK: -Need to be refined

let mockCourses: [Course] = [
                             .init(id: 0, name: "100 days of SwiftUI", description: "This is a free collection of videos, tutorials, tests, and more, all drawn from around my work here on Hacking with Swift, and all designed to help you learn SwiftUI effectively.", image: "swiftui_logo", price: 450, originalPrice: 600, isFav: false, isAddedToCart: false),
                             .init(id: 1, name: "100 days of Swift", description: "This is a free collection of videos, tutorials, tests, and more, all drawn from around my existing work here on Hacking with Swift, and all designed to help you learn Swift.", image: "swift_logo", price: 700, originalPrice: 800, isFav: false, isAddedToCart: false),
                             .init(id: 2, name: "Dependency Injection in Swift", description: "This tutorial helps in understanding the basics of Dependency Injection in Swift.", image: "dependencyInjection", price: 700, originalPrice: 800, isFav: false, isAddedToCart: false),
                             .init(id: 3, name: "What's new in Swift 5.5?", description: "This tutorial helps in understanding the what's new in Swift 5.5?.", image: "5_5", price: 700, originalPrice: 800, isFav: false, isAddedToCart: false),
                             .init(id: 4, name: "Dependency Injection in Swift", description: "This tutorial helps in understanding the basics of Dependency Injection in Swift.", image: "dependencyInjection", price: 720, originalPrice: 820, isFav: false, isAddedToCart: false),
                             .init(id: 5, name: "What's new in Swift 5.5?", description: "This tutorial helps in understanding the what's new in Swift 5.5?.", image: "5_5", price: 740, originalPrice: 840, isFav: false, isAddedToCart: false),
                             .init(id: 6, name: "Dependency Injection in Swift", description: "This tutorial helps in understanding the basics of Dependency Injection in Swift.", image: "dependencyInjection", price: 760, originalPrice: 860, isFav: false, isAddedToCart: false),
                             .init(id: 7, name: "What's new in Swift 5.5?", description: "This tutorial helps in understanding the what's new in Swift 5.5?.", image: "5_5", price: 780, originalPrice: 880, isFav: false, isAddedToCart: false),
                             .init(id: 8, name: "100 days of SwiftUI", description: "This is a free collection of videos, tutorials, tests, and more, all drawn from around my work here on Hacking with Swift, and all designed to help you learn SwiftUI effectively.", image: "swiftui_logo", price: 500, originalPrice: 650, isFav: false, isAddedToCart: false),
                             .init(id: 9, name: "100 days of Swift", description: "This is a free collection of videos, tutorials, tests, and more, all drawn from around my existing work here on Hacking with Swift, and all designed to help you learn Swift.", image: "swift_logo", price: 710, originalPrice: 810, isFav: false, isAddedToCart: false),
                             .init(id: 10, name: "Dependency Injection in Swift", description: "This tutorial helps in understanding the basics of Dependency Injection in Swift.", image: "dependencyInjection", price: 900, originalPrice: 1050, isFav: false, isAddedToCart: false),
                            ]
