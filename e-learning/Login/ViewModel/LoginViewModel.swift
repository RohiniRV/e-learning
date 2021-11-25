//
//  LoginViewModel.swift
//  e-learning
//
//  Created by rvaidya on 22/11/21.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    func isValid(usn: String) -> Bool {
        return usn.contains("@") && usn.contains(".")
    }
    
    func isValid(pwd: String) -> Bool {
        let hasCapitalLetter = pwd.rangeOfCharacter(from: .uppercaseLetters) != nil
        let hasLowerCaseLetter = pwd.rangeOfCharacter(from: .lowercaseLetters) != nil
        let hasSpecialCharacter = pwd.contains("$") || pwd.contains("@") || pwd.contains("*")
        return hasCapitalLetter && hasLowerCaseLetter && hasSpecialCharacter && pwd.count >= 8
    }
    
    func login() {
        //should call an api & validate if the login was successful
    }
}
