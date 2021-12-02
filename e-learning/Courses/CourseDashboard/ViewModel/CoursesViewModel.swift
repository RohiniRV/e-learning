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
    let user: User
    
    let manager = CoursesManager()
    
    func updateCart(course: Course) {
        cartCourses.append(course)
        courses = manager.courses
        print("CartList \(cartCourses)")
    }
    
    func updateFavs(course: Course)  {
        wishlistCourses.append(course)
        courses = manager.courses
        print("WishList \(wishlistCourses)")
    }
    
    init(networkManager: NetworkManager, user: User) {
        self.networkManager = networkManager
        self.user = user
        
        //New architecture
        courses = manager.courses
        preloadUserCart()
        preloadUserWishlist()
    }
    
    func preloadUserWishlist() {
        wishlistCourses = user.wishlistCourses
    }
    
    func preloadUserCart() {
        cartCourses = user.cartCourses
        print("Cart courses of user \(cartCourses)")
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
    
    func addToCart(course: Course) {
        manager.addToCart(course: course)
        updateCart(course: course)
    }
    
    func addToWishlist(course: Course) {
        manager.addToWishList(course: course)
        updateFavs(course: course)
    }
    
    func removeFromCart(course: Course) {
        manager.removefromCart(course: course)
        updateCart(course: course)
    }
    
    func removeFromWishList(course: Course) {
        manager.removeFromWishList(course: course)
        updateFavs(course: course)
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
}

