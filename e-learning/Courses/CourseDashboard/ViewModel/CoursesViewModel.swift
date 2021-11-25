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
//    @Published var
    
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
                    print("Finished")
                }
            }) { [weak self] data in
                guard !data.data.isEmpty else {return}
                print("Data recieved")
                //here is where data is recieved.
//                self?.employeeData = data.data
            }
            .store(in: &cancellables)
    }
    
    func getCourses() {
        courses = mockCourses
        print("Courses count \(courses.count)")
    }
    
    func addToCart(course: Course, user: User) {
        courses.indices.forEach{
            if (courses[$0].id == course.id) {
                courses[$0].isAddedToCart = true
                print("Course succesfully added to the cart  \(course.id)")
            }
        }
        if cartCourses.isEmpty {
            cartCourses = user.cartCourses
            print("Initializing the cart... \(cartCourses)")
            cartCourses.append(course)
        }
        else {
            cartCourses.append(course)
        }
    }
    
    func getCartCourses(for user: User) {
        if cartCourses.isEmpty {
            cartCourses = user.cartCourses
        }
    }
    
//    func getCoursesInCart(user: User) {
//        //First time when the user logs in, user.cart will be empty. So add it to the cartcourses.
//        //Next time when the user logs in, check if user.cart has items {
//        //cartcourses.append
//        //else if cartcourses not empty, just append
//    //}
//        if cartCourses.isEmpty {
//            cartCourses = user.cartCourses.isEmpty ? courses.filter({$0.isAddedToCart == true }) : user.cartCourses
//        }
//        else {
//            cartCourses.append(contentsOf: courses.filter({$0.isAddedToCart == true }))
//        }
//        print("Courses in cart \(cartCourses)")
//    }
    
    func getTotalAmount() {
        var amt = 0.0

        cartCourses.forEach { course in
            amt += course.price
        }
        
        totalCartPrice = amt
        print("totalCartPrice in cart \(totalCartPrice)")

    }
    
    func getDiscountedBalance() {
        var amt = 0.0
        cartCourses.forEach { course in
            amt += course.originalPrice
        }
        discountedDifference = (amt - totalCartPrice)
        print("discountedDifference in cart \(discountedDifference)")

    }
    
    func addToWishList(course: Course, user: User) {
        courses.indices.forEach{
            if (courses[$0].id == course.id) {
                courses[$0].isFav = true
                print("Course succesfully added to the wishlist  \(course.id)")
            }
        }
        if wishlistCourses.isEmpty {
            wishlistCourses = user.wishlistCourses
            print("Initializing the cart... \(cartCourses)")
            wishlistCourses.append(course)
        }
        else {
            wishlistCourses.append(course)
        }
        
    }
        
    func getCoursesInWishlist(for user: User) {
        if self.wishlistCourses.isEmpty {
            wishlistCourses = user.wishlistCourses
        }
    }
}

