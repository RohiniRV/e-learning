//
//  CoursesViewModel.swift
//  e-learning
//
//  Created by rvaidya on 22/11/21.
//

import Foundation
import Combine

class CoursesViewModel: ObservableObject {
    
    @Published var courses = [Course]()
    @Published var cartCourses = [Course]()
    @Published var totalCartPrice: Double = 0
    @Published var discountedDifference: Double = 0
    @Published var wishlistCourses = [Course]()
    
    private var cancellables = Set<AnyCancellable>()
    let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
        self.getCourses()
    }
    
    func getAPIData() {
        self.networkManager.getData(of: HighLevelAPIDataModel.self, url: "https://reqres.in/api/users?page=2")
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error in getting employeeData \(error)")
                case .finished:
                    print("Finished getting data.")
                }
            }) { data in
                guard !data.data.isEmpty else {return}
                print("API Data recieved")

            }
            .store(in: &cancellables)
    }
    
    func getCourses() {
        courses = mockCourses
    }
    
    func addToCart(course: Course, user: User) {
        guard !isInCart(course: course) else {return}
        
        if cartCourses.isEmpty {
            print("Initializing the cart...")
            cartCourses = user.cartCourses
        }
        else {
//            cartCourses.append(course)
            print("Course succesfully added to the cart with course id: \(course.id)")
        }
        courses.indices.forEach{
            if (courses[$0].id == course.id) {
                courses[$0].isAddedToCart = true
                cartCourses.append(courses[$0])
            }
        }
        print("Cart Courses \(cartCourses)")
    }
    
    func getCartCourses(for user: User) {
        if cartCourses.isEmpty {
            cartCourses = user.cartCourses
        }
    }
    
    func getTotalAmount() {
        var amt = 0.0
        cartCourses.forEach { course in
            amt += course.price
        }
        totalCartPrice = amt
        print("TotalCartPrice: \(totalCartPrice)")

    }
    
    func getDiscountedBalance() {
        var amt = 0.0
        cartCourses.forEach { course in
            amt += course.originalPrice
        }
        discountedDifference = (amt - totalCartPrice)
        print("DiscountedDifference of cart items: \(discountedDifference)")

    }
    
    func addToWishList(course: Course, user: User) {
        guard !isInWishlist(course: course) else {return}
       
        if wishlistCourses.isEmpty {
            print("Initializing the wishlist...")
            wishlistCourses = user.wishlistCourses
        }
        else {
            print("Course succesfully added to the wishlist: \(course.id)")
        }
        
        courses.indices.forEach{
            if (courses[$0].id == course.id) {
                courses[$0].isFav = true
                wishlistCourses.append(courses[$0])
            }
        }
        
        print("Wishlist Courses \(wishlistCourses)")

    }
        
    func getCoursesInWishlist(for user: User) {
        if self.wishlistCourses.isEmpty {
            wishlistCourses = user.wishlistCourses
        }
    }
    
    func isInCart(course: Course) -> Bool {
        cartCourses.contains(course)
    }
    
    func isInWishlist(course: Course) -> Bool {
        wishlistCourses.contains(course)
    }
}

