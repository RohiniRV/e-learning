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
    
    init(networkManager: NetworkManager, user: User) {
        self.networkManager = networkManager
        self.user = user
        
        //New architecture
        courses = mockCourses
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
        
        courses.indices.forEach { index in
           if courses[index].id == course.id {
               courses[index].isAddedToCart = true
           }
        }
        
        cartCourses = courses.filter({$0.isAddedToCart == true})

    }
    
    func addToWishlist(course: Course) {
        courses.indices.forEach { index in
            if courses[index].id == course.id {
                courses[index].isFav = true
            }
        }
        wishlistCourses = courses.filter({$0.isFav == true })

    }
    
    func removeFromCart(course: Course) {
        courses.indices.forEach { index in
            if courses[index].id == course.id {
                courses[index].isAddedToCart = false
            }
        }
        cartCourses = courses.filter({$0.isAddedToCart == true })
    }
    
    func removeFromWishList(course: Course) {
        courses.indices.forEach { index in
            if courses[index].id == course.id {
                courses[index].isFav = false
            }
        }
        cartCourses = courses.filter({$0.isFav == true })
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

