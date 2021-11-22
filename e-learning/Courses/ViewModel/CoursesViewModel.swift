//
//  CoursesViewModel.swift
//  e-learning
//
//  Created by rvaidya on 22/11/21.
//

import Foundation


class CoursesViewModel: ObservableObject {
    
    @Published var courses = [Course]()
    
    func getCourses() {
        courses = mockCourses
    }
    
}

let mockCourses: [Course] = [
                             .init(id: 0, name: "100 days of SwiftUI", description: "This is a free collection of videos, tutorials, tests, and more, all drawn from around my work here on Hacking with Swift, and all designed to help you learn SwiftUI effectively.", image: "swiftui_logo", price: "600", originalPrice: "450", isFav: false),
                             .init(id: 1, name: "100 days of Swift", description: "This is a free collection of videos, tutorials, tests, and more, all drawn from around my existing work here on Hacking with Swift, and all designed to help you learn Swift.", image: "swift_logo", price: "800", originalPrice: "700", isFav: false),
                             .init(id: 2, name: "Dependency Injection in Swift", description: "This tutorial helps in understanding the basics of Dependency Injection in Swift.", image: "dependencyInjection", price: "800", originalPrice: "700", isFav: false),
                             .init(id: 3, name: "What's new in Swift 5.5?", description: "This tutorial helps in understanding the what's new in Swift 5.5?.", image: "5_5", price: "800", originalPrice: "700", isFav: false)
                            ]
