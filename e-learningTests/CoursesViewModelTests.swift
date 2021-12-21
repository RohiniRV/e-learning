//
//  CoursesViewModelTests.swift
//  e-learningTests
//
//  Created by rvaidya on 21/12/21.
//

import XCTest
@testable import e_learning

class CourseViewModelTests: XCTestCase {
    
    let sut = CoursesViewModel(networkManager: NetworkManager(), user: User(context: PersistenceController.shared.container.viewContext))
    
    func testAddToCart() {
        sut.addToCart(course: mockCourses[0])
        XCTAssertEqual(sut.cartCourses[0].isAddedToCart, true)
    }
    
    func testAddToWishList() {
        sut.addToWishlist(course: mockCourses[0])
    }
    
    func testGetTotalAmoutInCart() {
        sut.getTotalAmount()
    }
    
    func testRemoveFromCart() {
        sut.removeFromCart(course: mockCourses[0])
        print("\(sut.cartCourses)")

    }
    
    func testRemoveFromWishlist() {
        sut.removeFromWishList(course: mockCourses[0])
    }
    
    func testTotalDiscountedPrice() {
        sut.getDiscountedBalance()
    }
    
}
