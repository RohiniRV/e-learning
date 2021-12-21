//
//  LoginViewModelTests.swift
//  e-learningTests
//
//  Created by rvaidya on 22/11/21.
//

import XCTest

@testable import e_learning

class LoginViewModelTest: XCTestCase {
    
    let vm = LoginViewModel()
    
    func testUSNValidityFunction() {
       let _ = vm.isValid(usn: "r@d.com")
    }
    
    func testPWDValidityFunction() {
        let _ = vm.isValid(pwd: "R@r")
    }
    
}
